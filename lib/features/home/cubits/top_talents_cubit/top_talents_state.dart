part of 'top_talents_cubit.dart';

@immutable
sealed class TopTalentsState extends Equatable{}
final class TopTalentsStateLoading extends TopTalentsState {
  @override
  List<Object?> get props => [];
}
final class TopTalentsStateLoadingMore extends TopTalentsState {
  List<Object?> get props => [];
}

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
final class HideTopTalentStateError extends TopTalentsState {
  final String? errorMessage;
   HideTopTalentStateError(this.errorMessage);
  @override
  List<Object?> get props => [errorMessage];
}

final class HideTopTalentStateLoaded extends TopTalentsState {
   HideTopTalentStateLoaded();
  @override
  List<Object?> get props => [];
}
final class HideTopTalentStateLoading extends TopTalentsState {
   HideTopTalentStateLoading();
  @override
  List<Object?> get props => [];
}