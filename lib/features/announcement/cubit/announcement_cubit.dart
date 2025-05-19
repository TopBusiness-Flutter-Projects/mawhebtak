import 'package:easy_localization/easy_localization.dart';

import '../../../core/exports.dart';
import '../../home/screens/home_screen.dart';
import '../data/repo/announcement_repo_impl.dart';

part 'announcement_state.dart';

class AnnouncementCubit extends Cubit<AnnouncementState> {
  AnnouncementCubit(this.api) : super(AnnouncementInitial());
  AnnouncementRepo api;
  DateTime? selectedDate;
  TextEditingController eventDateController = TextEditingController();

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
