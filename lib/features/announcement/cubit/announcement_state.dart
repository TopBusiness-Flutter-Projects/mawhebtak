part of 'announcement_cubit.dart';

@immutable
sealed class AnnouncementState {}

final class AnnouncementInitial extends AnnouncementState {}
final class DateTimeSelected extends AnnouncementState {
  String? formattedDateTime;
  DateTimeSelected(this.formattedDateTime);
}
