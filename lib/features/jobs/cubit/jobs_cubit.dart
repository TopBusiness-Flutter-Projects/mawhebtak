

import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mawhebtak/core/exports.dart';
import 'package:mawhebtak/core/utils/widget_from_application.dart';
import 'package:mawhebtak/features/calender/cubit/calender_cubit.dart';
import 'package:mawhebtak/features/jobs/data/model/user_jop_details_model.dart';
import 'package:mawhebtak/features/jobs/data/model/user_jop_model.dart';
import 'package:mawhebtak/features/jobs/data/repos/jobs.repo.dart';
import 'package:mawhebtak/features/location/cubit/location_cubit.dart';
import 'jobs_state.dart';

class JobsCubit extends Cubit<JobsState> {
  JobsCubit(this.jobsRepo) : super(JobsInitial());
  JobsRepo jobsRepo ;
  DateTime? selectedDate;
  TextEditingController jopUserTitleController = TextEditingController();
  final List<File> uploadedImages = [];
  void removeImage(File file) {
    uploadedImages.remove(file);
    emit(FileRemovedSuccessfully());
  }

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

  void clearUploadedImages() {
    uploadedImages.clear();
    emit(AllFilesCleared());
  }
  TextEditingController eventDateController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController fromController = TextEditingController();
  TextEditingController toController = TextEditingController();

  Future<void> selectDateTime( BuildContext context) async {
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
  UserJopModel? userJopModel;
  bool isLoadingMore = false;
  getUserJopData({bool isGetMore = false,required String page}) async {
    if (isGetMore) {
      isLoadingMore = true;
      emit(GetUserJopStateLoadingMore());
    } else {
      emit(GetUserJopStateLoading());
    }
    try {
      final res = await jobsRepo.getUserJopData(page: page);

      res.fold((l) {
        emit(GetUserJopStateError(l.toString()));
      }, (r) {
        if (isGetMore) {
          userJopModel = UserJopModel(
            links: r.links,
            status: r.status,
            msg: r.msg,
            data: [...userJopModel!.data!, ...r.data!],
          );
          emit(GetUserJopStateLoaded());
        } else {
          userJopModel = r;
          emit(GetUserJopStateLoaded());
        }
        emit(GetUserJopStateLoaded());
      });
    } catch (e) {
      emit(GetUserJopStateError(e.toString()));
    }
    finally {
      isLoadingMore = false;
    }
  }
  UserJopDetailsModel? userJopDetailsModel;
  getUserJopDetailsData({required String userJopId}) async {
    emit(GetUserJopDetailsStateLoaded());

    try {
      final res = await jobsRepo.getUserJopDetailsData(userJopId:userJopId);

      res.fold((l) {
        emit(GetUserJopDetailsStateError(l.toString()));
      }, (r) {
        userJopDetailsModel = r;
        emit(GetUserJopStateLoaded());
      });
    } catch (e) {
      emit(GetUserJopDetailsStateError(e.toString()));
    }

  }


  addJopUser({required BuildContext context}) async {
    AppWidgets.create2ProgressDialog(context);
    emit(AddUserJopStateLoading());

    try {
      final res = await jobsRepo.addJopUser(
        title: jopUserTitleController.text,
        deadLine: "2026-04-12",
        priceEndAt: "5000",
        priceStartAt: "2000",
        description: descriptionController.text,
        lat: context
            .read<LocationCubit>()
            .selectedLocation
            ?.latitude
            .toString() ??
            "0.0",
        long: context
            .read<LocationCubit>()
            .selectedLocation
            ?.longitude
            .toString() ??
            "0.0",
        mediaFiles: [
          ...context.read<CalenderCubit>().myImagesF ?? [],
          ...context.read<CalenderCubit>().validVideos
        ],
        location: locationController.text,
      );
      res.fold((l) {
        errorGetBar(l.toString());
        emit(AddUserJopStateError(l.toString()));
      }, (r) {
        successGetBar(r.msg.toString());
        descriptionController.clear();
        context.read<CalenderCubit>().myImagesF = [];
        context.read<CalenderCubit>().myImages = [];
        context.read<CalenderCubit>().validVideos = [];
        Navigator.pop(context);
        emit(AddUserJopStateLoaded());
      });
    } catch (e) {
      successGetBar(e.toString());

      emit(AddUserJopStateError(e.toString()));
    }
    Navigator.pop(context);
  }

}
