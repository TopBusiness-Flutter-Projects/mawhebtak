part of 'request_gigs_cubit.dart';

@immutable
sealed class RequestGigsState {}

final class RequestGigsStateLoading extends RequestGigsState {}
final class RequestGigsStateLoadingMore extends RequestGigsState {}

final class RequestGigsStateError extends RequestGigsState {
  final String? errorMessage;
  RequestGigsStateError(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}

final class RequestGigsStateLoaded extends RequestGigsState {
  final RequestGigsModel? requestGigs;
  RequestGigsStateLoaded(this.requestGigs);

  @override
  List<Object?> get props => [requestGigs];
}