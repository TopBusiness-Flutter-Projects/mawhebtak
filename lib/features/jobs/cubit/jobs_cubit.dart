import 'package:mawhebtak/core/exports.dart';
import 'package:mawhebtak/core/utils/widget_from_application.dart';
import 'package:mawhebtak/features/calender/cubit/calender_cubit.dart';
import 'package:mawhebtak/features/jobs/data/model/user_jop_details_model.dart';
import 'package:mawhebtak/features/jobs/data/model/user_jop_model.dart';
import 'package:mawhebtak/features/jobs/data/repos/jobs.repo.dart';
import 'package:mawhebtak/features/location/cubit/location_cubit.dart';
import 'package:mawhebtak/features/more_screen/cubit/more_cubit.dart';
import 'jobs_state.dart';

class JobsCubit extends Cubit<JobsState> {
  JobsCubit(this.jobsRepo) : super(JobsInitial());
  JobsRepo jobsRepo;
  DateTime? selectedDate;
  TextEditingController jopUserTitleController = TextEditingController();
  TextEditingController priceStartAt = TextEditingController();
  TextEditingController priceEndAt = TextEditingController();
  TextEditingController eventDateController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

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
            DateFormat('dd MMMM yyyy \'at\' hh:mm a', 'en')
                .format(finalDateTime);
        eventDateController.text = formattedDateTime;

        emit(DateTimeSelected(formattedDateTime));
      }
    }
  }

  UserJobModel? userJopModel;
  bool isLoadingMore = false;
  getUserJobData(
      {bool isGetMore = false, required String page, String? orderBy}) async {
    if (isGetMore) {
      isLoadingMore = true;
      emit(GetUserJopStateLoadingMore());
    } else {
      emit(GetUserJopStateLoading());
    }
    try {
      final res = await jobsRepo.getUserJopData(page: page, orderBy: orderBy);
      res.fold((l) {
        emit(GetUserJopStateError(l.toString()));
      }, (r) {
        if (isGetMore) {
          userJopModel = UserJobModel(
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
    } finally {
      isLoadingMore = false;
    }
  }

  UserJobDetailsModel? userJobDetailsModel;
  getUserJopDetailsData({required String userJopId}) async {
    emit(GetUserJopDetailsStateLoaded());

    try {
      final res = await jobsRepo.getUserJopDetailsData(userJopId: userJopId);

      res.fold((l) {
        emit(GetUserJopDetailsStateError(l.toString()));
      }, (r) {
        userJobDetailsModel = r;
        emit(GetUserJopStateLoaded());
      });
    } catch (e) {
      emit(GetUserJopDetailsStateError(e.toString()));
    }
  }

  toggleFavorite(
      {required String userJopId,
      required JopData? userJop,
      required BuildContext context}) async {
    emit(ToggleFavoriteStateLoading());
    try {
      final res = await jobsRepo.toggleFavorite(userJopId: userJopId);

      res.fold((l) {
        emit(ToggleFavoriteStateError(l.toString()));
      }, (r) {
        if (userJop?.isFav == true) {
          userJop?.isFav = false;
          userJobDetailsModel?.data?.isFav = false;
        } else {
          userJop?.isFav = true;

        }
        emit(ToggleFavoriteStateLoaded());
      });
    } catch (e) {
      emit(ToggleFavoriteStateError(e.toString()));
    }
  }

  addJopUser({required BuildContext context}) async {
    AppWidgets.create2ProgressDialog(context);
    emit(AddUserJopStateLoading());

    try {
      final res = await jobsRepo.addJopUser(
        title: jopUserTitleController.text,
        deadLine: selectedDate ?? DateTime.now(),
        priceEndAt: priceStartAt.text,
        priceStartAt: priceEndAt.text,
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
        jopUserTitleController.clear();
        selectedDate = null;
        priceStartAt.clear();
        priceEndAt.clear();
        context.read<CalenderCubit>().myImagesF = [];
        context.read<CalenderCubit>().myImages = [];
        context.read<CalenderCubit>().validVideos = [];
        Navigator.pop(context);
        getUserJobData(page: '1', isGetMore: false);
        emit(AddUserJopStateLoaded());
      });
    } catch (e) {
      successGetBar(e.toString());

      emit(AddUserJopStateError(e.toString()));
    }
    Navigator.pop(context);
  }
}
