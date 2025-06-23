import 'package:mawhebtak/core/exports.dart';
import 'package:mawhebtak/features/announcement/data/models/announcements_model.dart';
import 'package:mawhebtak/features/casting/data/model/request_gigs_model.dart';
import 'package:mawhebtak/features/feeds/data/models/posts_model.dart';
import 'package:mawhebtak/features/home/data/models/top_events_model.dart';
import 'package:mawhebtak/features/jobs/data/model/user_jop_model.dart';
import 'package:mawhebtak/features/search/data/repositories/search_repository.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit(this.searchRepo) : super(SearchInitial());
  SearchRepo? searchRepo;
  AnnouncementsModel? announcementsModel;
  TextEditingController searchController = TextEditingController();


  getSearchAnnouncementData() async {
    emit(SearchAnnouncementDataStateLoading());
    try {
      final res = await searchRepo!
          .getSearchAnnouncmentData(search: searchController.text);
      res.fold((l) {
        emit(SearchAnnouncementDataStateError(l.toString()));
      }, (r) {
        announcementsModel = r;
        emit(SearchAnnouncementDataStateLoaded());
      });
    } catch (e) {
      emit(SearchAnnouncementDataStateError(e.toString()));
    }
  }

  RequestGigsModel? gigs;
  getSearchGigData() async {
    emit(SearchGigDataStateLoading());
    try {
      final res =
          await searchRepo!.getSearchGigsData(search: searchController.text);
      res.fold((l) {
        emit(SearchGigDataStateError(l.toString()));
      }, (r) {
        gigs = r;
        emit(SearchGigDataStateLoaded());
      });
    } catch (e) {
      emit(SearchGigDataStateError(e.toString()));
    }
  }

  UserJobModel? jobModel;
  getSearchJobData() async {
    emit(SearchJobDataStateLoading());
    try {
      final res =
          await searchRepo!.getSearchJobData(search: searchController.text);
      res.fold((l) {
        emit(SearchJobDataStateError(l.toString()));
      }, (r) {
        jobModel = r;
        emit(SearchJobDataStateLoaded());
      });
    } catch (e) {
      emit(SearchJobDataStateError(e.toString()));
    }
  }

  TopEventsModel? eventsModel;
  getSearchEventData() async {
    emit(SearchEventDataStateLoading());
    try {
      final res = await searchRepo!
          .getSearchEventData(search: searchController.text);
      res.fold((l) {
        emit(SearchEventDataStateError(l.toString()));
      }, (r) {
        eventsModel = r;
        emit(SearchEventDataStateLoaded());
      });
    } catch (e) {
      emit(SearchEventDataStateError(e.toString()));
    }
  }

  PostsModel? postsModel;
  getSearchPostData() async {
    emit(SearchPostDataStateLoading());
    try {
      final res = await searchRepo!
          .getSearchPostData(search: searchController.text);
      res.fold((l) {
        emit(SearchPostDataStateError(l.toString()));
      }, (r) {
        postsModel = r;
        emit(SearchPostDataStateLoaded());
      });
    } catch (e) {
      emit(SearchPostDataStateError(e.toString()));
    }
  }
}
