import 'package:mawhebtak/core/exports.dart';
import 'package:mawhebtak/core/models/default_model.dart';
import 'package:mawhebtak/features/feeds/cubit/feeds_state.dart';
import 'package:mawhebtak/features/feeds/data/models/posts_model.dart';
import 'package:mawhebtak/features/feeds/data/repository/feeds_repository.dart';

class FeedsCubit extends Cubit<FeedsState> {
  FeedsCubit() : super(FeedsStateLoading());
  FeedsRepository? api = FeedsRepository(serviceLocator());
  PostsModel? posts;
  bool isLoadingMore = false;
  postsData({bool isGetMore = false, required String page}) async {
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
        } else {
          posts = r;
          emit(FeedsStateLoaded(r));
        }
      });
    } catch (e) {
      emit(FeedsStateError(e.toString()));
    } finally {
      isLoadingMore = false;
    }
  }

  DefaultMainModel? defaultMainModel;
  PostsModelData ? post;
 addReaction({String? reaction = 'like',required String postId}) async {
   emit(AddReactionStateLoading());
    try {
      final res = await api!.addReaction(postId: postId, reaction:reaction!);
      res.fold((l) {
        emit(AddReactionStateError(l.toString()));
      }, (r) {
        if (reaction == 'like') {
          if (post?.isLiked == true) {
            // If already liked, unlike it
            post?.isLiked = false;
            post?.countLike = (post?.countLike ?? 1) - 1;
          } else {
            // If not liked, like it
            post?.isLiked = true;
            post?.countLike = (post?.countLike ?? 0) + 1;

            // If previously disliked, reset the dislike state
            if (post?.isDisliked == true) {
              post?.isDisliked = false;
              post?.countDislike = (post?.countDislike ?? 1) - 1;
            }
          }
        } else if (reaction == 'dislike') {
          if (post?.isDisliked == true) {
            // If already disliked, undislike it
            post?.isDisliked = false;
            post?.countDislike = (post?.countDislike ?? 1) - 1;
          } else {
            // If not disliked, dislike it
            post?.isDisliked = true;
            post?.countDislike = (post?.countDislike ?? 0) + 1;

            // If previously liked, reset the like state
            if (post?.isLiked == true) {
              post?.isLiked = false;
              post?.countLike = (post?.countLike ?? 1) - 1;
            }
          }
        }
        successGetBar(r.msg);
        emit(AddReactionStateLoaded());
      });
    }
    catch (e) {
      emit(AddReactionStateError(e.toString()));
    }
  }
  // addPostAction(
  //     {String? reaction = 'like', required PostsModelData post}) async {
  //   emit(LoadingAddActionPostData());
  //   final res = await api.addPostAction(
  //       blogId: post.id?.toString() ?? 'like', reaction: reaction);
  //   res.fold((l) {
  //     emit(ErrorAddActionPostData());
  //   }, (r) {
  //     if (reaction == 'like') {
  //       if (post.isLiked == true) {
  //         // If already liked, unlike it
  //         post.isLiked = false;
  //         post.countLike = (post.countLike ?? 1) - 1;
  //       } else {
  //         // If not liked, like it
  //         post.isLiked = true;
  //         post.countLike = (post.countLike ?? 0) + 1;
  //
  //         // If previously disliked, reset the dislike state
  //         if (post.isDisliked == true) {
  //           post.isDisliked = false;
  //           post.countDislike = (post.countDislike ?? 1) - 1;
  //         }
  //       }
  //     } else if (reaction == 'dislike') {
  //       if (post.isDisliked == true) {
  //         // If already disliked, undislike it
  //         post.isDisliked = false;
  //         post.countDislike = (post.countDislike ?? 1) - 1;
  //       } else {
  //         // If not disliked, dislike it
  //         post.isDisliked = true;
  //         post.countDislike = (post.countDislike ?? 0) + 1;
  //
  //         // If previously liked, reset the like state
  //         if (post.isLiked == true) {
  //           post.isLiked = false;
  //           post.countLike = (post.countLike ?? 1) - 1;
  //         }
  //       }
  //     }
  //
  //     emit(LoadedAddActionPostData());
  //   });
  // }

}
