class JobsState {}

class JobsInitial extends JobsState {}

class DateTimeSelected extends JobsState {
  String? formattedDateTime;
  DateTimeSelected(this.formattedDateTime);
}

class FilePickedSuccessfully extends JobsState {}

class FileNotPicked extends JobsState {}

class FileRemovedSuccessfully extends JobsState {}

class FileAlreadyExists extends JobsState {}

class AllFilesCleared extends JobsState {}

class GetUserJopStateLoaded extends JobsState {}

class GetUserJopStateError extends JobsState {
  final String errorMessage;

  GetUserJopStateError(this.errorMessage);
}

class GetUserJopDetailsStateLoaded extends JobsState {}

class GetUserJopDetailsStateError extends JobsState {
  final String errorMessage;

  GetUserJopDetailsStateError(this.errorMessage);
}

class AddUserJopStateError extends JobsState {
  final String errorMessage;

  AddUserJopStateError(this.errorMessage);
}

class GetUserJopStateLoading extends JobsState {}

class GetUserJopStateLoadingMore extends JobsState {}

class GetUserJopDetailsStateLoading extends JobsState {}

class AddUserJopStateLoading extends JobsState {}

class AddUserJopStateLoaded extends JobsState {}
