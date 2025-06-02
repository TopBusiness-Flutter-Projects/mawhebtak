part of 'announcement_cubit.dart';

@immutable
sealed class AnnouncementState {}

final class AnnouncementInitial extends AnnouncementState {}
final class CategoryFromAnnouncementStateError extends AnnouncementState {
  final String errorMessage;

  CategoryFromAnnouncementStateError(this.errorMessage);
}
final class CategoryFromAnnouncementStateLoading extends AnnouncementState {}
final class CategoryFromAnnouncementStateLoaded extends AnnouncementState {

}
final class CategoryFromAnnouncementStateLoadingMore extends AnnouncementState {}
final class DateTimeSelected extends AnnouncementState {
  String? formattedDateTime;
  DateTimeSelected(this.formattedDateTime);
}
