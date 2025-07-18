abstract class LoginState {}

class LoginStateInitial extends LoginState {}

class LoginStateLoading extends LoginState {}

class LoginStateLoaded extends LoginState {
  final int? isRegister;
  LoginStateLoaded({ this.isRegister});
}

class LoginStateError extends LoginState {}

class SuccessSignInWithGoogleState extends LoginState {}

class LoadingSignOutGoogleState extends LoginState {}

class SuccessSignOutGoogleState extends LoginState {}

class FailureSignInWithGoogleState extends LoginState {
  String? error;
  FailureSignInWithGoogleState({this.error});
}
