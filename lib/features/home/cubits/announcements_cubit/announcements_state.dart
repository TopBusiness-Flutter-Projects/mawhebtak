part of 'announcements_cubit.dart';

@immutable
sealed class AnnouncementsState {}

final class AnnouncementsStateLoading extends AnnouncementsState {}

final class AnnouncementsStateError extends AnnouncementsState {
  final String? errorMessage;
  AnnouncementsStateError(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}

final class AnnouncementsStateLoaded extends AnnouncementsState {
  final AnnouncementsModel? topTalents;
  AnnouncementsStateLoaded(this.topTalents);

  @override
  List<Object?> get props => [topTalents];
}