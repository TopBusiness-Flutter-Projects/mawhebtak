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
final class AnnouncementsStateLoadingMore extends AnnouncementState {}
final class AnnouncementsStateLoading extends AnnouncementState {}

final class AnnouncementsStateError extends AnnouncementState {
  final String? errorMessage;
  AnnouncementsStateError(this.errorMessage);
}

final class AnnouncementsStateLoaded extends AnnouncementState {
  final AnnouncementsModel? announcementsModel;
  AnnouncementsStateLoaded(this.announcementsModel);
}

