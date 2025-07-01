part of 'top_talents_cubit.dart';

@immutable
sealed class TopTalentsState  {}

final class TopTalentsStateLoading extends TopTalentsState {

}

final class TopTalentsStateLoadingMore extends TopTalentsState {

}

final class TopTalentsStateError extends TopTalentsState {
  final String? errorMessage;
  TopTalentsStateError(this.errorMessage);

}

final class TopTalentsStateLoaded extends TopTalentsState {
  final TopTalentsModel? topTalents;
  TopTalentsStateLoaded(this.topTalents);


}

final class HideTopTalentStateError extends TopTalentsState {
  final String? errorMessage;
  HideTopTalentStateError(this.errorMessage);

}

final class HideTopTalentStateLoaded extends TopTalentsState {
  HideTopTalentStateLoaded();

}

final class HideTopTalentStateLoading extends TopTalentsState {
  HideTopTalentStateLoading();

}

class FollowAndUnFollowStateError extends TopTalentsState {
  String? errorMessage;
  FollowAndUnFollowStateError(this.errorMessage);


}

class FollowAndUnFollowStateLoaded extends TopTalentsState {

}

class FollowAndUnFollowStateLoading extends TopTalentsState {

}

class UpdateIsFollowState extends TopTalentsState {


}


class LoadingGetUserTypesState extends TopTalentsState {}

class ErrorGetUserTypesState extends TopTalentsState {
  final String errorMessage;

  ErrorGetUserTypesState(this.errorMessage);
}

class LoadedGetUserTypesState extends TopTalentsState {
  final MainRegisterUserTypes data;
  LoadedGetUserTypesState(this.data);
}class LoadingGetUserSubTypesState extends TopTalentsState {}

class ErrorGetUserSubTypesState extends TopTalentsState {
  final String errorMessage;

  ErrorGetUserSubTypesState(this.errorMessage);
}

class LoadedGetUserSubTypesState extends TopTalentsState {
  final MainRegisterUserTypes data;
  LoadedGetUserSubTypesState(this.data);
}
final class GetFollowersStateError extends TopTalentsState {
  final String errorMessage;

  GetFollowersStateError(this.errorMessage);

}
final class GetFollowersStateLoaded extends TopTalentsState {}
final class GetFollowersStateLoading extends TopTalentsState {}
final class GetFollowersStateLoadingMore extends TopTalentsState {}
final class TopTalentsStateUpdated extends TopTalentsState {}
