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

