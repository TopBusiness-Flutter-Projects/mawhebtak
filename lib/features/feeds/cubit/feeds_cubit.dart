import 'package:mawhebtak/core/exports.dart';
import 'package:mawhebtak/features/feeds/cubit/feeds_state.dart';
import 'package:mawhebtak/features/feeds/data/models/posts_model.dart';
import 'package:mawhebtak/features/feeds/data/repository/feeds_repository.dart';

class FeedsCubit extends Cubit<FeedsState> {
  FeedsCubit() : super(FeedsStateLoading());
  FeedsRepository? api = FeedsRepository(serviceLocator());
  PostsModel? posts;
  bool isLoadingMore = false;
  postsData({bool isGetMore = false,required String page }) async {
    if (isGetMore) {
      isLoadingMore = true;
      emit(FeedsStateLoadingMore());
    } else {
      emit(FeedsStateLoading());
    }
    try {
      final res = await api!.feedsData(page: page);
      res.fold((l) {
        emit(FeedsStateError(l.toString()));
      }, (r) {
        if (isGetMore) {
          posts = PostsModel(
            links: r.links,
            status: r.status,
            msg: r.msg,
            data: [...posts!.data!, ...r.data!],
          );
          emit(FeedsStateLoaded(posts!));
        }else{
          posts = r;
          emit(FeedsStateLoaded(r));
        }

      });
    } catch (e) {
      emit(FeedsStateError(e.toString()));

    }
    finally {
      isLoadingMore = false;
    }
  }
}
