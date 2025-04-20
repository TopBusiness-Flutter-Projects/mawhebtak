part of 'profile_cubit.dart';

@immutable
sealed class ProfileState {}

final class ProfileInitial extends ProfileState {}
final class ChangeIndexState extends ProfileState {}
final class ChangeFollowersState extends ProfileState {}
final class VideoPickedState extends ProfileState {}
final class ImagePickedState extends ProfileState {}
