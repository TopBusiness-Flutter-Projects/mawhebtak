import 'package:mawhebtak/features/calender/screens/widgets/calender_widget.dart';

class CalenderState {}

class CalenderInitial extends CalenderState {}

class DateTimeSelected extends CalenderState {
  String? formattedDateTime;
  DateTimeSelected(this.formattedDateTime);
}

class LocationLoading extends CalenderState {}

class LocationLoaded extends CalenderState {
  final String address;
  LocationLoaded(this.address);
}

class LocationError extends CalenderState {
  final String message;
  LocationError(this.message);
}

class CalendarUpdated extends CalenderState {
  late List<CalendarEvent> events;
  CalendarUpdated(this.events);
}

final class GetGetCountriesErrorState extends CalenderState {}

final class GetGetCountriesLoadingState extends CalenderState {}

final class GetGetCountriesSuccessState extends CalenderState {}

final class GetGetCategoriesErrorState extends CalenderState {}

final class GetGetCategoriesLoadingState extends CalenderState {}

final class GetGetCategoriesSuccessState extends CalenderState {}

final class SuccessSelectNewImageState extends CalenderState {}

final class SuccessRemoveImageState extends CalenderState {}

final class SuccessRemoveVideoState extends CalenderState {}

final class LoadedAddNewViedoState extends CalenderState {}
