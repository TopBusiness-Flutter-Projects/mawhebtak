
import 'package:mawhebtak/features/calender/data/model/countries_model.dart';
import 'package:mawhebtak/features/announcement/data/models/announcements_model.dart';
import '../../../core/exports.dart';
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

        selectedDate = finalDateTime;

        String formattedDateTime =
            DateFormat('dd MMMM yyyy \'at\' hh:mm a').format(finalDateTime);
        eventDateController.text = formattedDateTime;

        emit(DateTimeSelected(formattedDateTime));
      }
    }
  }
  GetCountriesMainModel? announcementCategoryModel;
  bool isLoadingMore = false;
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
      final res = await api!.announcementsData(page: page, orderBy: orderBy);
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

}
