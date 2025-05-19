import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:mawhebtak/core/exports.dart';
import 'package:mawhebtak/core/models/default_model.dart';
import 'package:mawhebtak/core/preferences/preferences.dart';
import 'package:mawhebtak/features/auth/login/data/models/login_model.dart';
import 'package:mawhebtak/features/feeds/cubit/feeds_state.dart';
import 'package:mawhebtak/features/feeds/data/models/posts_model.dart';
import 'package:mawhebtak/features/feeds/data/repository/feeds_repository.dart';

class FeedsCubit extends Cubit<FeedsState> {
  FeedsCubit() : super(FeedsStateLoading());
  FeedsRepository? api = FeedsRepository(serviceLocator());
  PostsModel? posts;
  TextEditingController bodyController = TextEditingController();
  List<File> selectedImages = [];
  List<File> selectedVideos = [];

  bool isPickingMedia = false;

  Future<void> pickImages() async {
    if (isPickingMedia) return;

    isPickingMedia = true;
    try {
      final pickedImages = await FilePicker.platform.pickFiles(
          allowMultiple: true,
          type: FileType.image,
          allowCompression: true,
          compressionQuality: 25);
      if (pickedImages != null) {
        selectedImages.addAll(
            pickedImages.paths.whereType<String>().map((path) => File(path)));
        emit(MediaPickedState());
      }
    } catch (e) {
      debugPrint('Error picking images: $e');
    } finally {
      isPickingMedia = false;
    }
  }

  Future<void> pickVideos() async {
    if (isPickingMedia) return;

    isPickingMedia = true;
    try {
      final pickedVideos = await FilePicker.platform.pickFiles(
        allowMultiple: true,
        type: FileType.video,
      );

      if (pickedVideos != null) {
        selectedVideos.addAll(
          pickedVideos.paths.whereType<String>().map((path) => File(path)),
        );
        emit(MediaPickedState());
      }
    } catch (e) {
      debugPrint('Error picking videos: $e');
    } finally {
      isPickingMedia = false;
    }
  }

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
            data: [...posts!.data!, ...r.data!]
          );
          emit(FeedsStateLoaded(posts!));
        } else {
          posts = r;
          print("hhhhhhhhhhhhhh${posts?.data?[1].isReacted}");

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
  PostsModelData? post;
  Map<String, bool> postLikes = {};
  addReaction({required String postId}) async {
    try {
      final res = await api!.addReaction(postId: postId);
      res.fold((l) {
        emit(AddReactionStateError(l.toString()));
      }, (r) {
        postLikes[postId] = !(postLikes[postId] ?? false);
        successGetBar(r.msg);
      });
    } catch (e) {
      emit(AddReactionStateError(e.toString()));
    }
  }

  addPost({required BuildContext context}) async {
    emit(AddPostStateLoading());
    try {
      final user = await Preferences.instance.getUserModel();
      final userId = user.data?.id?.toString() ?? '';
      final res = await api!.addPost(
        mediaFiles: [...selectedImages, ...selectedVideos],
        body: bodyController.text,
        userId: userId,
      );
      res.fold((l) {
        emit(AddPostStateError(l.toString()));
        errorGetBar(l.toString());
      }, (r) async {
        emit(AddPostStateLoaded());

        await postsData(page: '1', isGetMore: true);
        Navigator.pop(context);
        bodyController.clear();
        selectedImages = [];
        selectedVideos = [];
      });
    } catch (e) {
      emit(AddPostStateError(e.toString()));
    }
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
