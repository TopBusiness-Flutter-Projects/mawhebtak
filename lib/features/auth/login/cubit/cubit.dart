import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:mawhebtak/core/exports.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import '../../../../core/preferences/preferences.dart';
import '../data/repos/login_repo.dart';
import 'state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this.api) : super(LoginStateInitial());
  LoginRepo api;

  login(
    String email,
    String password,
  ) async {
    emit(LoginStateLoading());
    try {
      final res = await api.login(email, password);

      res.fold((l) {
        emit(LoginStateError());
      }, (r) {
        if (r.status == 200) {
          Preferences.instance.setUser(r);
          successGetBar(r.msg ?? '');
          emit(LoginStateLoaded());
        } else {
          errorGetBar(r.msg ?? '');
          emit(LoginStateError());
        }
      });
    } catch (e) {
      emit(LoginStateError());
      return null;
    }

    //!
  }

  loginWithSocial(
      {required String socialType,
      required String email,
      String? phone,
      required String name}) async {
    emit(LoginStateLoading());
    try {
      final res = await api.loginWithSocial(
          email: email, phone: phone, name: name, socialType: socialType);
      res.fold((l) {
        emit(LoginStateError());
      }, (r) {
        if (r.status == 200) {
          Preferences.instance.setUser(r);
          successGetBar(r.msg ?? '');
          emit(LoginStateLoaded());
        } else {
          errorGetBar(r.msg ?? '');
          emit(LoginStateError());
        }
      });
    } catch (e) {
      emit(LoginStateError());
      return null;
    }
  }

  //! GOOGLE

  //! APPLE

  // Sign in with google
  String userGmail = '';
  String userPhoto = '';
  String userName = '';
  String? accessToken = '';
  Future<UserCredential?> signInWithGoogle(
    BuildContext context,
  ) async {
    log("Starting Google Sign-In process...");

    try {
      final GoogleSignIn _googleSignIn = GoogleSignIn(
        scopes: [
          'email',
          'https://www.googleapis.com/auth/userinfo.profile',
          'openid',
        ],
      );

      // Trigger Google Sign-In
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      log("Google Sign-In successful: ${googleUser != null}");

      // Handle user cancellation
      if (googleUser == null) {
        log("Google Sign-In was cancelled by the user.");
        emit(FailureSignInWithGoogleState(error: 'Sign-in cancelled by user'));
        return null;
      }

      // Retrieve authentication tokens
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      log("Access Token retrieved: ${googleAuth.accessToken != null}");
      log("Access Token retrieved: ${googleAuth.accessToken.toString()}");
      log("ID Token retrieved: ${googleAuth.idToken != null}");
      log("ID Token retrieved: ${googleAuth.idToken.toString()}");

      if (googleAuth.accessToken != null) {
        loginWithSocial(
            socialType: 'google',
            email: googleUser.email,
            phone: null,
            name: googleUser.displayName ?? '');
      }

      if (googleAuth.accessToken == null || googleAuth.idToken == null) {
        log("Missing required authentication tokens.");
        emit(FailureSignInWithGoogleState(
            error: 'Missing authentication tokens'));
        throw Exception('Missing Google authentication tokens.');
      }

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Store the access token locally if needed
      accessToken = googleAuth.accessToken;

      // Emit success state for Google Sign-In
      emit(SuccessSignInWithGoogleState());
      log("Firebase credential created successfully. Signing in...");

      try {
        // Sign in to Firebase with additional error handling
        final UserCredential userCredential =
            await FirebaseAuth.instance.signInWithCredential(credential);

        log("Firebase Sign-In successful. User ID: ${userCredential.user?.uid}");
        return userCredential;
      } on FirebaseAuthException catch (e) {
        log("Firebase Auth Exception: ${e.code} - ${e.message}");
        emit(FailureSignInWithGoogleState(
          error: _getFirebaseErrorMessage(e.code),
        ));
        return null;
      }
    } on PlatformException catch (e) {
      log("Platform Exception during Google Sign-In: ${e.code}, ${e.message}");
      emit(FailureSignInWithGoogleState(error: e.message));
    } catch (e) {
      log("Unexpected error during Google Sign-In: $e");
      emit(FailureSignInWithGoogleState(error: e.toString()));
    }

    return null;
  }

  String _getFirebaseErrorMessage(String code) {
    switch (code) {
      case 'account-exists-with-different-credential':
        return 'An account already exists with the same email address but different sign-in credentials.';
      case 'invalid-credential':
        return 'The credential data is malformed or has expired.';
      case 'operation-not-allowed':
        return 'Google sign-in is not enabled for this project.';
      case 'user-disabled':
        return 'This user account has been disabled.';
      case 'user-not-found':
        return 'No user found for this credential.';
      default:
        return 'An unknown error occurred during sign-in.';
    }
  }

  Future<GoogleSignInAccount?> signOutFromGmail() async {
    emit(LoadingSignOutGoogleState());
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signOut();

    emit(SuccessSignOutGoogleState());

    return googleUser;
  }

  Future<void> signInWithApple(BuildContext context) async {
    try {
      final currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser != null) {
        log("User is already logged in. Logging out...");
        await FirebaseAuth.instance.signOut();
      }
      log("Starting Apple Sign-In...");
      final credential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );

      final oauthCredential = OAuthProvider("apple.com").credential(
        idToken: credential.identityToken,
        accessToken: credential.authorizationCode,
      );
      FirebaseAuth.instance.signInWithCredential(oauthCredential).then((auth) {
        log("auth code: ${auth.user?.email}");
        log("auth code: ${auth.user?.displayName}");
        log("auth code: ${auth.user?.isAnonymous}");
        log("auth code: ${auth.user?.phoneNumber}");
        log("auth code: ${auth.user?.photoURL}");
        log("auth code: ${auth.user?.photoURL}");
        log("auth code: ${auth.user?.uid}");
        log("Apple Sign-In successful!");
        if (auth.user != null) {
          loginWithSocial(
              socialType: 'apple',
              email: auth.user?.email ?? '',
              phone: auth.user?.phoneNumber ?? '',
              name: auth.user?.displayName ?? '');
        } else {}
      }).catchError((e) {
        log("Apple Sign-In Error: $e");
      });
    } catch (e) {
      log("Apple Sign-In Error: $e");
      if (e is PlatformException) {
        log("Error code: ${e.code}");
        log("Error message: ${e.message}");
        log("Error details: ${e.details}");
      }
    }
  }
}
