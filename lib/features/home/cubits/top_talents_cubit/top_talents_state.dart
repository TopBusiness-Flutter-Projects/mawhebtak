part of 'top_talents_cubit.dart';

@immutable
sealed class TopTalentsState {}
final class TopTalentsStateLoading extends TopTalentsState {}

final class TopTalentsStateError extends TopTalentsState {
  final String? errorMessage;
   TopTalentsStateError(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}

final class TopTalentsStateLoaded extends TopTalentsState {
  final TopTalentsModel? topTalents;
   TopTalentsStateLoaded(this.topTalents);

  @override
  List<Object?> get props => [topTalents];
}
