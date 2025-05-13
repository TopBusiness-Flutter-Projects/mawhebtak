import 'package:mawhebtak/core/exports.dart';
import 'package:mawhebtak/features/home/data/models/announcements_model.dart';
import 'package:mawhebtak/features/home/data/repositories/announcements_repository.dart';
part 'announcements_state.dart';

class AnnouncementsCubit extends Cubit<AnnouncementsState> {
  AnnouncementsCubit() : super(AnnouncementsStateLoading());
  AnnouncementsRepository? api = AnnouncementsRepository(serviceLocator());
  AnnouncementsModel? announcements;
  announcementsData() async {
    try {
      final res = await api!.announcementsData();

      res.fold((l) {
        emit(AnnouncementsStateError(l.toString()));
      }, (r) {
        announcements = r;
        emit(AnnouncementsStateLoaded(r));
      });
    } catch (e) {
      emit(AnnouncementsStateError(e.toString()));
      return null;
    }
  }
}
