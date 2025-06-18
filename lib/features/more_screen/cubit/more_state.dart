 class MoreState {}

 class MoreInitial extends MoreState {}
 class GetSettingDataStateLoaded extends MoreState {}
 class GetSettingDataStateLoading extends MoreState {}
 class GetSettingDataStateError extends MoreState {
 final String errorMessage;

  GetSettingDataStateError(this.errorMessage);
 } class ContactUsStateLoaded extends MoreState {}
 class ContactUsStateLoading extends MoreState {}
 class ContactUsStateError extends MoreState {
 final String errorMessage;

 ContactUsStateError(this.errorMessage);
 }
 class LogoutStateLoading extends MoreState {}
 class LogoutStateLoaded extends MoreState {}
 class LogoutStateError extends MoreState {
 final String errorMessage;

 LogoutStateError(this.errorMessage);
 }
 class ChangePasswordStateLoading extends MoreState {}
 class ChangePasswordStateLoaded extends MoreState {}
 class ChangePasswordStateError extends MoreState {
 final String errorMessage;

 ChangePasswordStateError(this.errorMessage);
 }
