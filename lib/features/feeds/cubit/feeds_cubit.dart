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

        // ✅ Check if the image already exists in myImages

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
      validVideos = [];

      emit(SuccessSelectNewImageState());
    } on PlatformException catch (e) {
      debugPrint('Image picker error: $e');
    }
  }

  // delete from path not index
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
    thumbnails.removeWhere((element) => element.path == video.path);
    if (validVideos.isEmpty) {
      validVideos = [];
    }
    emit(SuccessRemoveVideoState());
  }

  Future<List<File>?> pickMultipleVideos(BuildContext context) async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowMultiple: false,
        type: FileType.video,
        // allowCompression: true,
      );
      if (result != null) {
        List<File> files = result.paths.map((path) => File(path!)).toList();
        //! clear List before select
        validVideos.clear();
        for (File file in files) {
          final fileBytes = await file.readAsBytes();
          if (fileBytes.length > 2 * 1024 * 1024) {
            AppWidgets.createProgressDialog(context: context, msg: 'loading');
            try {
              final thumbnailFiles = await _generateThumbnails(File(file.path));
              print('thummmmm : ${thumbnailFiles.path}');
              thumbnails.add(thumbnailFiles);
              final compressedFile = await _compressVideo(File(file.path));
              // print('video Size After : ${await compressedFile.length()}');
              validVideos.add(compressedFile);

              Navigator.pop(context);
            } catch (e) {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                      "Failed to compress video ${path.basename(file.path)}."),
                ),
              );
            }
            myImages = [];
            myImages = null;

            myImagesF = [];
          } else {
            AppWidgets.createProgressDialog(context: context, msg: 'loading');
            validVideos.add(File(file.path));
            Navigator.pop(context);
            myImages = [];

            myImages = null;

            myImagesF = [];
            //////////////////////
            //!

            final thumbnailFiles = await _generateThumbnails(File(file.path));
            thumbnails.add(thumbnailFiles);
          }
        }
      }
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

//!
  Future<File> _compressVideo(File file) async {
    final String videoName =
        'MyVideo-${DateTime.now().millisecondsSinceEpoch}.mp4';
    try {
      await VideoCompress.setLogLevel(0);
      MediaInfo videoDuration = await VideoCompress.getMediaInfo(file.path);

      final compressedVideo = await VideoCompress.compressVideo(
        file.path,
        quality: VideoQuality.MediumQuality,
        deleteOrigin: true,
        includeAudio: true,
        frameRate: 15,
        startTime: 0,
        duration: (videoDuration.duration! / 1000).round() > 30
            ? (videoDuration.duration! / 1000).floor() - 30
            : 0,
      );

      if (compressedVideo != null && compressedVideo.path != null) {
        return File(compressedVideo.path!);
      } else {
        VideoCompress.cancelCompression();
        return File('');
      }
    } catch (e) {
      VideoCompress.cancelCompression();
      return File('');
    }
  }

//? thumbnail
  Future<File> _generateThumbnails(File videoFile) async {
    print('thumbnailPath ');
    final thumbnailPath = await VideoThumbnail.thumbnailFile(
      video: videoFile.path,
      imageFormat: ImageFormat.PNG,
      quality: 100,

      timeMs: 0, // Specify the time in milliseconds to get the thumbnail from
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

  DefaultMainModel? defaultMainModel;
  addReaction({required String postId, required int index}) async {
    try {
      final res = await api!.addReaction(postId: postId);
      res.fold((l) {
        emit(AddReactionStateError(l.toString()));
      }, (r) {
        if (posts?.data?[index]?.isReacted == true) {
          posts?.data![index]!.reactionCount =
              (posts?.data?[index]?.reactionCount ?? 1) - 1;
        } else {
          posts?.data![index]!.reactionCount =
              (posts?.data?[index]?.reactionCount ?? 0) + 1;
        }
        posts?.data?[index]?.isReacted =
            !(posts?.data?[index]?.isReacted ?? false);

        successGetBar(r.msg);
        emit(AddReactionStateSuccess());
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
        mediaFiles: myImagesF ?? [],
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
