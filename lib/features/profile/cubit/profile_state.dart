part of 'profile_cubit.dart';

@immutable
sealed class ProfileState {}

final class ProfileInitial extends ProfileState {}
final class ChangeIndexState extends ProfileState {}
final class ChangeFollowersState extends ProfileState {}
