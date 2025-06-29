import 'package:mawhebtak/core/preferences/preferences.dart';
import 'package:mawhebtak/core/utils/widget_from_application.dart';
import 'package:mawhebtak/features/announcement/data/models/announcement_details_model.dart';
import 'package:mawhebtak/features/auth/login/data/models/login_model.dart';
import 'package:mawhebtak/features/calender/cubit/calender_cubit.dart';
import 'package:mawhebtak/features/calender/data/model/countries_model.dart';
import 'package:mawhebtak/features/announcement/data/models/announcements_model.dart';
import 'package:mawhebtak/features/home/data/models/home_model.dart';
import 'package:mawhebtak/features/location/cubit/location_cubit.dart';
import '../../../core/exports.dart';
import '../data/repo/announcement_repo_impl.dart';
part 'announcement_state.dart';

class AnnouncementCubit extends Cubit<AnnouncementState> {
  AnnouncementCubit(this.api) : super(AnnouncementInitial());
  AnnouncementRepo api;
  DateTime? selectedDate;
  TextEditingController announcementDateController = TextEditingController();
  GetCountriesMainModelData? selectedSubCategory;
  GetCountriesMainModelData? selectedCategory;
  int? subCategoryId;
  TextEditingController locationController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController announcementTitleController = TextEditingController();
  TextEditingController announcementDescriptionController =
      TextEditingController();
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

        selectedDate = finalDateTime;

        String formattedDateTime =
            DateFormat('dd MMMM yyyy \'at\' hh:mm a', 'en')
                .format(finalDateTime);
        announcementDateController.text = formattedDateTime;

        emit(DateTimeSelected(formattedDateTime));
      }
    }
  }

  GetCountriesMainModel? announcementCategoryModel;
  bool isLoadingMore = false;
  // category from announcementttttttttttttttttt
  getCategoryFromAnnouncment({
    bool isGetMore = false,
    String? page,
    String? orderBy,
  }) async {
    if (isGetMore) {
      isLoadingMore = true;
      emit(CategoryFromAnnouncementStateLoadingMore());
    } else {
      emit(CategoryFromAnnouncementStateLoading());
    }
    try {
      final res =
          await api.getCategoryFromAnnouncement(page: page, orderBy: orderBy);
      res.fold((l) {
        emit(CategoryFromAnnouncementStateError(l.toString()));
      }, (r) {
        if (isGetMore) {
          announcementCategoryModel = GetCountriesMainModel(
            links: r.links,
            status: r.status,
            msg: r.msg,
            data: [...announcementCategoryModel!.data!, ...r.data!],
          );
          emit(CategoryFromAnnouncementStateLoaded());
        } else {
          announcementCategoryModel = r;
          emit(CategoryFromAnnouncementStateLoaded());
        }
      });
    } catch (e) {
      emit(CategoryFromAnnouncementStateError(e.toString()));
    }
  }

  AnnouncementsModel? announcements;
  announcementsData({
    bool isGetMore = false,
    required String page,
    String? orderBy,
  }) async {
    if (isGetMore) {
      isLoadingMore = true;
      emit(AnnouncementsStateLoadingMore());
    } else {
      emit(AnnouncementsStateLoading());
    }
    try {
      final res = await api.announcementsData(page: page, orderBy: orderBy);
      res.fold((l) {
        emit(AnnouncementsStateError(l.toString()));
      }, (r) {
        if (isGetMore) {
          announcements = AnnouncementsModel(
            links: r.links,
            status: r.status,
            msg: r.msg,
            data: [...announcements!.data!, ...r.data!],
          );
          emit(AnnouncementsStateLoaded(announcements!));
        } else {
          announcements = r;
          emit(AnnouncementsStateLoaded(r));
        }
      });
    } catch (e) {
      emit(AnnouncementsStateError(e.toString()));
    } finally {
      isLoadingMore = false;
    }
  }

  toggleFavoriteAnnounce(
      {required Announcement announcement,
      required BuildContext context}) async {
    emit(ToggleFavoriteAnnounceStateLoading());
    try {
      final res = await api.toggleFavoriteAnnounce(
          announcementId: announcement.id.toString() ?? "");

      res.fold((l) {
        emit(ToggleFavoriteAnnounceStateError(l.toString()));
      }, (r) {
        if (announcement.isFav == true ||
            announcementDetailsModel?.data?.isFav == true) {
          announcement.isFav = false;
          announcementDetailsModel?.data?.isFav = false;
        } else {
          announcement.isFav = true;
          announcementDetailsModel?.data?.isFav = true;
        }
        emit(ToggleFavoriteAnnounceStateLoaded());
      });
    } catch (e) {
      emit(ToggleFavoriteAnnounceStateError(e.toString()));
    }
  }

  AnnouncementsModel? announcementsModel;

  // gigs from sub
  AnnouncementsModel? announcementsFromSubCategory;
  getAnnouncementsFromSubCategory({required String? id}) async {
    emit(AnnouncementsFromCategoryStateLoading());
    try {
      final res = await api.getAnnouncementsFromSubCategory(
        subCategoryId: id ?? '',
      );
      res.fold((l) {
        emit(AnnouncementsFromCategoryStateError(l.toString()));
      }, (r) {
        announcementsFromSubCategory = r;
        emit(AnnouncementsFromCategoryStateLoaded());
      });
    } catch (e) {
      emit(AnnouncementsFromCategoryStateError(e.toString()));
    }
  }

  // details from announcement
  AnnouncementDetailsModel? announcementDetailsModel;
  getDetailsAnnouncements({required String? announcementId}) async {
    emit(AnnouncementsDetailsStateLoading());
    try {
      final res = await api.announcementDetails(
        announcementId: announcementId.toString(),
      );
      res.fold((l) {
        emit(AnnouncementsDetailsStateError(l.toString()));
      }, (r) {
        announcementDetailsModel = r;
        emit(AnnouncementsDetailsStateLoaded());
      });
    } catch (e) {
      emit(AnnouncementsDetailsStateError(e.toString()));
    }
  }

  // sub from category
  GetCountriesMainModel? subCategoryFromCategoryAnnouncementsModel;
  subCategoryFromCategoryAnnouncement({required String categoryId}) async {
    emit(SubCategoryStateLoading());
    try {
      final res =
          await api.subCategoryFromCategoryAnnouncement(categoryId: categoryId);
      res.fold((l) {
        emit(SubCategoryStateError(l.toString()));
      }, (r) {
        announcementsFromSubCategory = null;
        subCategoryFromCategoryAnnouncementsModel = r;
        emit(SubCategoryStateLoaded(r));
      });
    } catch (e) {
      emit(SubCategoryStateError(e.toString()));
    }
  }

  deleteAnnouncement({required String announcementId}) async {
    emit(DeleteAnnounceStateLoading());
    try {
      final res = await api.deleteAnnouncement(announcementId: announcementId);
      res.fold((l) {
        emit(DeleteAnnounceStateError(l.toString()));
      }, (r) {
        successGetBar(r.msg.toString());
        announcementsData(page: '1', orderBy: 'desc');
        emit(DeleteAnnounceStateLoaded());
      });
    } catch (e) {
      emit(DeleteAnnounceStateError(e.toString()));
    }
  }

  // add announcement

  addAnnouncement({required BuildContext context}) async {
    AppWidgets.create2ProgressDialog(context);
    emit(AddAnnouncementStateLoading());
    try {
      final res = await api.addAnnouncement(
        currencyId: context.read<CalenderCubit>().selectedCurrency?.id.toString() ?? '',
        expireIn: selectedDate!,
        price: priceController.text,
        subCategoryId: selectedSubCategory?.id.toString() ?? "",
        title: announcementTitleController.text,
        description: announcementDescriptionController.text,
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
        emit(AddAnnouncementStateError(l.toString()));
      }, (r) {
        selectedDate = null;
        context.read<CalenderCubit>().myImagesF = [];
        context.read<CalenderCubit>().myImages = [];
        context.read<CalenderCubit>().validVideos = [];
        Navigator.pop(context);
        successGetBar(r.msg.toString());
        announcementTitleController.clear();
        announcementDescriptionController.clear();
        selectedCategory = null;
        selectedSubCategory = null;
        locationController.clear();
        priceController.clear();
        announcementsData(page: '1', orderBy: 'desc');
        emit(AddAnnouncementStateLoaded());
      });
    } catch (e) {
      emit(AddAnnouncementStateError(e.toString()));
    }
    Navigator.pop(context);
  }

  Future<LoginModel> getUserFromPreferences() async {
    final user = await Preferences.instance.getUserModel();
    return user;
  }

  LoginModel? user;
  Future<void> loadUserFromPreferences() async {
    user = await Preferences.instance.getUserModel();
  }
}
