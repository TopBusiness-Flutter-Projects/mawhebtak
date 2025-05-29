part of 'event_cubit.dart';

@immutable
sealed class EventState {}

final class EventInitial extends EventState {}

final class ChangeToggleState extends EventState {}

final class ChangePhotoState extends EventState {}

final class ChangeCurrencyState extends EventState {}

final class ImagePickedState extends EventState {}

final class VideoPickedState extends EventState {}

final class GetEventDetailsLoadingState extends EventState {}

final class GetEventDetailsLoadedState extends EventState {}

final class GetEventDetailsErrorState extends EventState {}

final class FollowUnFollowEventLoadingState extends EventState {}

final class FollowUnFollowEventLoadedState extends EventState {}

final class FollowUnFollowEventErrorState extends EventState {}

final class DeleteEventErrorState extends EventState {}

final class DeleteEventLoadingState extends EventState {}

final class DeleteEventLoadedState extends EventState {}

final class ActionRequestEventErrorState extends EventState {}

final class ActionRequestEventLoadingState extends EventState {}

final class ActionRequestEventLoadedState extends EventState {}
