part of 'event_cubit.dart';

@immutable
sealed class EventState {}

final class EventInitial extends EventState {}
final class ChangeToggleState extends EventState {

}
