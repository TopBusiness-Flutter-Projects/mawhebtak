import 'package:mawhebtak/core/exports.dart';
import 'package:mawhebtak/features/home/data/models/announcements_model.dart';
import 'package:mawhebtak/features/home/data/repositories/announcements_repository.dart';
part 'announcements_state.dart';

class AnnouncementsCubit extends Cubit<AnnouncementsState> {
  AnnouncementsCubit() : super(AnnouncementsStateLoading());
  AnnouncementsRepository? api = AnnouncementsRepository(serviceLocator());
  AnnouncementsModel? announcements;
  bool isLoadingMore = false;
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
