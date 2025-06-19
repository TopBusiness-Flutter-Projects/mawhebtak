part of 'profile_cubit.dart';

@immutable
sealed class ProfileState {}

final class ProfileInitial extends ProfileState {}

final class ChangeIndexState extends ProfileState {}

final class ChangeFollowersState extends ProfileState {}

final class VideoPickedState extends ProfileState {}

final class ImagePickedState extends ProfileState {}

final class SuccessSelectNewImageProfileState extends ProfileState {}

final class GetProfileStateError extends ProfileState {
  final String errorMessage;
  GetProfileStateError(this.errorMessage);
}

final class GetProfileStateLoaded extends ProfileState {}

final class GetProfileStateLoading extends ProfileState {}

final class AddReviewStateError extends ProfileState {
  final String errorMessage;
  AddReviewStateError(this.errorMessage);
}

final class AddReviewStateLoaded extends ProfileState {}

final class AddReviewStateLoading extends ProfileState {}

final class UpdateProfileStateError extends ProfileState {
  final String errorMessage;

  UpdateProfileStateError(this.errorMessage);
}

final class UpdateProfileStateLoaded extends ProfileState {}

final class UpdateProfileStateLoading extends ProfileState {}


final class EditingState extends ProfileState {}

class ExperienceInitial extends ProfileState {}

class ExperienceFormChanged extends ProfileState {}

class ExperienceLoading extends ProfileState {}

class ExperienceSuccess extends ProfileState {}

class ExperienceError extends ProfileState {}

class ProfileFormChanged extends ProfileState {}
