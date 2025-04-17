

import 'package:easy_localization/easy_localization.dart';
import 'package:mawhebtak/core/exports.dart';
import 'package:mawhebtak/features/calender/cubit/calender_state.dart';
import 'package:mawhebtak/features/calender/data/repos/calender.repo.dart';

import '../screens/widgets/calender_widget.dart';

class CalenderCubit extends Cubit<CalenderState> {
  CalenderCubit(this.exRepo) : super(CalenderInitial());
  CalenderRepo exRepo ;
   // TextEditingController locationController = TextEditingController();
  TextEditingController eventDateController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController titleOfTheEventController = TextEditingController();
  DateTime? selectedDate;
   List<CalendarEvent> events = [];

  void addEvent({
    required String title,
    required DateTime date,
    Color color = Colors.deepPurpleAccent,
  }) {
    final newEvent = CalendarEvent(
      title: title,
      date: date,
      color: color,
    );

    events.add(newEvent);
    emit(CalendarUpdated(List.from(events))); // إرسال نسخة جديدة من القائمة
  }

  Future<void> selectDateTime(BuildContext context) async {
    DateTime? date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );

    if (date != null) {
      TimeOfDay? time = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

      if (time != null) {
        DateTime finalDateTime = DateTime(
          date.year,
          date.month,
          date.day,
          time.hour,
          time.minute,
        );

        selectedDate = finalDateTime; // ✅ احفظ التاريخ المختار

        String formattedDateTime =
        DateFormat('dd MMMM yyyy \'at\' hh:mm a').format(finalDateTime);
        eventDateController.text = formattedDateTime;

        emit(DateTimeSelected(formattedDateTime));
      }
    }
  }
}
