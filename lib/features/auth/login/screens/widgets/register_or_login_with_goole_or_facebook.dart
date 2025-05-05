import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mawhebtak/core/exports.dart';

class GoogleAndFacebookWidget extends StatefulWidget {
  const GoogleAndFacebookWidget({super.key});

  @override
  State<GoogleAndFacebookWidget> createState() => _GoogleAndFacebookWidgetState();
}

class _GoogleAndFacebookWidgetState extends State<GoogleAndFacebookWidget> {
  @override
  // final FirebaseAuth _auth = FirebaseAuth.instance;
  //
  // final GoogleSignIn googleSignIn = GoogleSignIn();
  // Future<UserCredential?> _handleSignInWithGoogle() async {
  //   try {
  //
  //     final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
  //
  //     final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount!.authentication;
  //
  //     final AuthCredential credential = GoogleAuthProvider.credential(
  //
  //       accessToken: googleSignInAuthentication.accessToken,
  //
  //       idToken: googleSignInAuthentication.idToken,
  //
  //     );
  //
  //     return await _auth.signInWithCredential(credential);
  //
  //   } catch (error) {
  //
  //     print(error);
  //
  //     return null;
  //
  //   }
  //
  // }
  // Future<UserCredential?> _handleSignInWithFace() async {
  //
  //   try {
  //
  //     final LoginResult result = await FacebookAuth.instance.login();
  //
  //     final AuthCredential credential = FacebookAuthProvider.credential(result.token);
  //
  //     return await _auth.signInWithCredential(credential);
  //
  //   } catch (error) {
  //
  //     print(error);
  //
  //     return null;
  //
  //   }
  //
  // }
  @override

  Widget build(BuildContext context) {
    return   Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap:
            () async{
      // UserCredential? userCredential = await _handleSignInWithFace();
      //
      // if (userCredential != null) {
      //   print('User signed in: ${userCredential.user?.displayName}');
      // }
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.sp),
                border: Border.all(color: AppColors.grayLite),
              ),
              child: Padding(
                padding: EdgeInsets.only(
                    left: 15.w,
                    right: 15.w,
                    top: 10.h,
                    bottom: 10.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset(AppIcons.facebookIcon),
                    SizedBox(
                      width: 10.w,
                    ),
                    Text(
                      "facebook".tr(),
                      style: TextStyle(
                          color: AppColors.primary,
                          fontSize: 15.sp),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          width: 20.w,
        ),
        GestureDetector(
          onTap: () async{
            // UserCredential? userCredential = await _handleSignInWithGoogle();
            //
            // if (userCredential != null) {
            //
            //   print('User signed in: ${userCredential.user?.displayName}');
            //
            // }
          },
          child: Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.sp),
                border: Border.all(color: AppColors.grayLite),
              ),
              child: Padding(
                padding: EdgeInsets.only(
                    left: 15.w,
                    right: 15.w,
                    top: 10.h,
                    bottom: 10.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset(AppIcons.googleIcon),
                    SizedBox(
                      width: 10.w,
                    ),
                    Text(
                      "google".tr(),
                      style: TextStyle(
                          color:
                          AppColors.darkGray.withOpacity(0.8),
                          fontSize: 15.sp),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
