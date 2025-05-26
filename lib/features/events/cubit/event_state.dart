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
