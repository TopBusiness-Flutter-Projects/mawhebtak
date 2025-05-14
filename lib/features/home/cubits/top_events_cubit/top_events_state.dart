part of 'top_events_cubit.dart';

@immutable
sealed class TopEventsState {}

final class TopEventsStateError extends TopEventsState {
  final String errorMessage;

  TopEventsStateError(this.errorMessage);
}
final class TopEventsStateLoaded extends TopEventsState {
  final TopEventsModel seeAllEventModel;

  TopEventsStateLoaded(this.seeAllEventModel);
}
final class SeeAllEventStateLoading extends TopEventsState {

}
final class SeeAllEventStateLoadingMore extends TopEventsState {

}

