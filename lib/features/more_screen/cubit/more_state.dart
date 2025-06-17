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
