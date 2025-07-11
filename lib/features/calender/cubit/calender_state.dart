import '../data/model/selected_talends.dart';
import '../data/repos/model/calender_model.dart';

class CalenderState {}

class CalenderInitial extends CalenderState {}

class CompressedVideoState extends CalenderState {}

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
  late List<MainCalendarEventData> events;
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

final class AddNewTalendsToEventState extends CalenderState {
  final List<SelectedTalends> selectedTalends;
  AddNewTalendsToEventState(this.selectedTalends);
}

final class RemoveNewTalendsFromEventState extends CalenderState {}

final class GetAddNewEventState extends CalenderState {}

final class GetAddNewEventSuccessState extends CalenderState {}

final class GetAddNewEventErrorState extends CalenderState {}

final class GetMyEventErrorState extends CalenderState {}

final class GetMyEventSuccessState extends CalenderState {}

final class GetMyEventLoadingState extends CalenderState {}

final class GetMyCalenderEventLoadingState extends CalenderState {}

final class GetMyCalenderEventLoadedState extends CalenderState {}

final class GetMyCalenderEventErrorState extends CalenderState {}
