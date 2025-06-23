part of 'search_cubit.dart';

@immutable
sealed class SearchState {}

final class SearchInitial extends SearchState {}
final class SearchAnnouncementDataStateError extends SearchState {
  final String errorMessage;

  SearchAnnouncementDataStateError(this.errorMessage);
}
final class SearchAnnouncementDataStateLoaded extends SearchState {}
final class SearchAnnouncementDataStateLoading extends SearchState {}
final class SearchGigDataStateError extends SearchState {
  final String errorMessage;

  SearchGigDataStateError(this.errorMessage);
}
final class SearchGigDataStateLoaded extends SearchState {}
final class SearchJobDataStateLoading extends SearchState {}
final class SearchJobDataStateError extends SearchState {
  final String errorMessage;

  SearchJobDataStateError(this.errorMessage);
}
final class SearchJobDataStateLoaded extends SearchState {}
final class SearchEventDataStateLoading extends SearchState {}
final class SearchEventDataStateError extends SearchState {
  final String errorMessage;

  SearchEventDataStateError(this.errorMessage);
}
final class SearchEventDataStateLoaded extends SearchState {}
final class SearchPostDataStateLoading extends SearchState {}
final class SearchPostDataStateError extends SearchState {
  final String errorMessage;

  SearchPostDataStateError(this.errorMessage);
}
final class SearchPostDataStateLoaded extends SearchState {}
final class SearchGigDataStateLoading extends SearchState {}
