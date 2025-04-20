

import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mawhebtak/core/exports.dart';
import 'package:mawhebtak/features/jobs/data/repos/jobs.repo.dart';
import 'jobs_state.dart';

class JobsCubit extends Cubit<JobsState> {
  JobsCubit(this.exRepo) : super(JobsInitial());
  JobsRepo exRepo ;
  DateTime? selectedDate;
  final List<File> uploadedImages = [];
  /// إزالة صورة من القائمة
  void removeImage(File file) {
    uploadedImages.remove(file);
    emit(FileRemovedSuccessfully());
  }

  /// اختيار صورة واحدة من المعرض أو الكاميرا
  Future<void> pickImage(BuildContext context, bool isGallery) async {
    try {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(
        source: isGallery ? ImageSource.gallery : ImageSource.camera,
      );

      if (pickedFile != null) {
        File file = File(pickedFile.path);
        if (!uploadedImages.contains(file)) {
          uploadedImages.add(file);
          emit(FilePickedSuccessfully());
        } else {
          emit(FileAlreadyExists()); // الصورة مكررة
        }
      } else {
        emit(FileNotPicked());
      }
    } catch (e) {
      emit(FileNotPicked()); // التعامل مع أي خطأ أثناء اختيار الصورة
    }
  }

  /// اختيار عدة صور من المعرض
  Future<void> pickImages(BuildContext context) async {
    try {
      final picker = ImagePicker();
      final pickedFiles = await picker.pickMultiImage(
        maxHeight: 500,
        maxWidth: 500,
        imageQuality: 100,
      );

      if (pickedFiles.isNotEmpty) {
        for (final file in pickedFiles) {
          File imageFile = File(file.path);
          if (!uploadedImages.contains(imageFile)) {
            uploadedImages.add(imageFile);
          }
        }
        emit(FilePickedSuccessfully());
      } else {
        emit(FileNotPicked());
      }
    } catch (e) {
      emit(FileNotPicked()); // التعامل مع أي خطأ أثناء اختيار الصور
    }
  }

  /// مسح جميع الصور المختارة
  void clearUploadedImages() {
    uploadedImages.clear();
    emit(AllFilesCleared());
  }
  TextEditingController eventDateController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController fromController = TextEditingController();
  TextEditingController toController = TextEditingController();

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
