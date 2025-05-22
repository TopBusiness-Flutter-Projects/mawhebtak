import 'dart:developer';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mawhebtak/core/exports.dart';
import 'package:mawhebtak/core/models/default_model.dart';
import 'package:mawhebtak/core/preferences/preferences.dart';
import 'package:mawhebtak/core/utils/widget_from_application.dart';
import 'package:mawhebtak/features/auth/login/data/models/login_model.dart';
import 'package:mawhebtak/features/feeds/cubit/feeds_state.dart';
import 'package:mawhebtak/features/feeds/data/models/comments_model.dart';
import 'package:mawhebtak/features/feeds/data/models/posts_model.dart';
import 'package:mawhebtak/features/feeds/data/repository/feeds_repository.dart';
import 'package:video_compress/video_compress.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
import 'package:path/path.dart' as path;

class FeedsCubit extends Cubit<FeedsState> {
  FeedsCubit() : super(FeedsStateLoading());
  FeedsRepository? api = FeedsRepository(serviceLocator());
  PostsModel? posts;
  TextEditingController bodyController = TextEditingController();
  TextEditingController commentController = TextEditingController();

  List<File> validVideos = [];
  List<XFile>? myImages;
  List<File>? myImagesF;
  List<File> thumbnails = [];

  Future pickMultiImage() async {
    List<XFile>? images;
    List<File> files = [];
    try {
      images = await ImagePicker().pickMultiImage();
      if (images == null || images.isEmpty) return;

      for (var xImage in images) {
        final file = File(xImage.path);

        final imageBytes = await file.readAsBytes();
        if (imageBytes.length > 3 * 1024 * 1024) {
          final compressedImageBytes =
              await FlutterImageCompress.compressWithFile(
            file.path,
            quality: 75,
          );
          final compressedImage = File('${file.path}.compressed.jpg');
          await compressedImage.writeAsBytes(compressedImageBytes!);
          files.add(compressedImage);
        } else {
          files.add(file);
        }

        // ✅ Add XFile and File to lists
        myImages = [...?myImages, xImage];
      }

      myImagesF = [...?myImagesF, ...files];

      emit(SuccessSelectNewImageState());
    } on PlatformException catch (e) {
      debugPrint('Image picker error: $e');
    }
  }

  void deleteImage(File image) {
    myImagesF!.removeWhere((element) => element.path == image.path);
    myImages!.removeWhere((element) => element.path == image.path);
    if (myImagesF!.isEmpty) {
      myImages = null;
      myImagesF = null;
    }
    emit(SuccessRemoveImageState());
  }

  void deleteVideo(File video) {
    validVideos.removeWhere((element) => element.path == video.path);

    if (validVideos.isEmpty) {
      validVideos = [];
    }
    emit(SuccessRemoveVideoState());
  }

  Future<List<File>?> pickMultipleVideos(BuildContext context) async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowMultiple: true,
        type: FileType.video,
      );
      if (result != null) {
        List<File> files = result.paths.map((path) => File(path!)).toList();
        validVideos.clear();
        thumbnails.clear();

        for (File file in files) {
          final fileBytes = await file.readAsBytes();
          try {
            if (fileBytes.length > 2 * 1024 * 1024) {
              AppWidgets.create2ProgressDialog(context);
              final thumbnailFile = await _generateThumbnails(file);
              thumbnails.add(thumbnailFile);
              final compressedFile = await _compressVideo(file);
              validVideos.add(compressedFile);

              Navigator.pop(context);
            } else {
              AppWidgets.create2ProgressDialog(context);
              final thumbnailFile = await _generateThumbnails(file);
              thumbnails.add(thumbnailFile);
              validVideos.add(file);
              Navigator.pop(context);
            }
          } catch (e) {
            Navigator.pop(context);
            print("Error processing video: $e");
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                    "Failed to process video: ${path.basename(file.path)}"),
              ),
            );
          }
        }

        return validVideos;
      }
      emit(LoadedAddNewViedoState());
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Error picking videos."),
        ),
      );
      return null;
    }
    return null;
  }

  Future<File> _compressVideo(File file) async {
    try {
      await VideoCompress.setLogLevel(0);

      final MediaInfo mediaInfo = await VideoCompress.getMediaInfo(file.path);
      final num videoDurationMs = mediaInfo.duration ?? 0;
      final int trimDurationInSeconds = (videoDurationMs / 1000).floor() > 30
          ? 30
          : (videoDurationMs / 1000).floor();

      final MediaInfo? compressedVideo = await VideoCompress.compressVideo(
        file.path,
        quality: VideoQuality.MediumQuality,
        deleteOrigin: false,
        includeAudio: true,
        startTime: 0,
        duration: trimDurationInSeconds,
      );
      log('LLLLLLLLLL ${compressedVideo != null && compressedVideo.path != null}');
      log('LLLLLLLLLL ${compressedVideo?.path}');
      if (compressedVideo != null && compressedVideo.path != null) {
        return compressedVideo.path != null
            ? File(compressedVideo.path!)
            : file;
      } else {
        VideoCompress.cancelCompression();
        return file;
      }
    } catch (e) {
      VideoCompress.cancelCompression();
      return file;
    }
  }

  Future<File> _generateThumbnails(File videoFile) async {
    print('thumbnailPath ');
    final thumbnailPath = await VideoThumbnail.thumbnailFile(
      video: videoFile.path,
      imageFormat: ImageFormat.PNG,
      quality: 100,
      timeMs: 0,
    );

    print('thumbnailPath $thumbnailPath');
    return File(thumbnailPath!);
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
              data: [...posts!.data!, ...r.data!]);
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
  CommentsModel? comments;
  commentsData({ required String postId}) async {
    emit(FeedsStateLoading());
    try {
      final res = await api!.getComments(postId: postId);
      res.fold((l) {
        emit(CommentsStateError(l.toString()));
      }, (r) {
        comments = r;
        emit(CommentsStateLoaded(r));
      });
    } catch (e) {
      emit(CommentsStateError(e.toString()));
    }
  }

  DefaultMainModel? defaultMainModel;
  addReaction({required String postId, required int index}) async {
    try {
      final res = await api!.addReaction(postId: postId);
      res.fold((l) {
        emit(AddReactionStateError(l.toString()));
      }, (r) {
        if (posts?.data?[index].isReacted == true) {
          posts?.data![index].reactionCount =
              (posts?.data?[index].reactionCount ?? 1) - 1;
        } else {
          posts?.data![index].reactionCount =
              (posts?.data?[index].reactionCount ?? 0) + 1;
        }
        posts?.data?[index].isReacted =
            !(posts?.data?[index].isReacted ?? false);

        successGetBar(r.msg);
        emit(AddReactionStateSuccess());
      });
    } catch (e) {
      emit(AddReactionStateError(e.toString()));
    }
  }


  deletePost({required String postId}) async {
    emit(DeletePostStateLoading());
    try {
      final res = await api!.deletePost(postId: postId);
      res.fold((l) {
        emit(DeletePostStateError(l.toString()));
      }, (r) {
        postsData(page: '1');
        successGetBar(r.msg);
        emit(DeletePostStateSuccess());
      });
    } catch (e) {
      emit(DeletePostStateError(e.toString()));
    }
  }
  deleteComment({required String commentId,required String postId}) async {
    emit(DeletePostStateLoading());
    try {
      final res = await api!.deleteComment( commentId: commentId);
      res.fold((l) {
        emit(DeletePostStateError(l.toString()));
      }, (r) {
        commentsData(postId: postId);
        successGetBar(r.msg);
        emit(DeletePostStateSuccess());
      });
    } catch (e) {
      emit(DeletePostStateError(e.toString()));
    }
  }


  addReply({required String postId, required String postCommentId}) async {
    emit(AddReplyStateLoading());
    try {
      final res = await api!.addReply(
          postId: postId,
          reply: commentController.text,
          postCommentId:postCommentId );
      res.fold((l) {
        emit(AddReplyStateError(l.toString()));
      }, (r) {
        commentsData(postId: postId);
        successGetBar(r.msg);
        emit(AddReplyStateLoaded());
      });
    } catch (e) {
      emit(AddReplyStateError(e.toString()));
    }
  }

  addComment({required String postId}) async {
    emit(AddCommentStateLoading());
    try {
      final res = await api!
          .addComment(postId: postId, comment: commentController.text);
      res.fold((l) {
        emit(AddCommentStateError(l.toString()));
      }, (r) {
        successGetBar(r.msg);

        emit(AddCommentStateSuccess());
        commentController.clear();
        commentsData(postId: postId);
      });
    } catch (e) {
      emit(AddCommentStateError(e.toString()));
    }
  }

  addPost({required BuildContext context}) async {
    emit(AddPostStateLoading());
    try {
      final user = await Preferences.instance.getUserModel();
      final userId = user.data?.id?.toString() ?? '';
      final res = await api!.addPost(
        mediaFiles: [...?myImagesF, ...validVideos],
        body: bodyController.text,
        userId: userId,
      );
      res.fold((l) {
        emit(AddPostStateError(l.toString()));
        errorGetBar(l.toString());
      }, (r) async {
        emit(AddPostStateLoaded());

        await postsData(page: '1', isGetMore: false);
        Navigator.pop(context);
        bodyController.clear();
        myImages = [];
        myImagesF = [];
        validVideos = [];
        thumbnails = [];
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



  String? replyingToCommentId;
  String? replyingToUserName;

  void startReplying(String commentId, String userName) {
    replyingToCommentId = commentId;
    replyingToUserName = userName;
    commentController.text = '@$userName ';
    commentController.selection = TextSelection.fromPosition(
      TextPosition(offset: commentController.text.length),
    );
    emit(ReplyingToCommentState(commentId: commentId, userName: userName));
  }

  void cancelReplying() {
    replyingToCommentId = null;
    replyingToUserName = null;
    commentController.clear();
    emit(CancelReplyingState());
  }
}
