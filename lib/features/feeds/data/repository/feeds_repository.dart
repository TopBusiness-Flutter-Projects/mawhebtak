import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:mawhebtak/core/api/end_points.dart';
import 'package:mawhebtak/core/error/exceptions.dart';
import 'package:mawhebtak/core/error/failures.dart';
import 'package:mawhebtak/core/models/default_model.dart';
import 'package:mawhebtak/core/preferences/preferences.dart';
import 'package:mawhebtak/features/feeds/data/models/add_post_model.dart';
import 'package:mawhebtak/features/feeds/data/models/posts_model.dart';
import '../../../../core/api/base_api_consumer.dart';

class FeedsRepository {
  final BaseApiConsumer dio;
  FeedsRepository(this.dio);
  Future<Either<Failure, PostsModel>> feedsData({required String page}) async {
    try {
      var response = await dio.get(EndPoints.feedsUrl ,
          queryParameters: {
        "model": "Post",
        "where[0]": "status,1",
        "paginate": "true",
        "orderBy": "desc",
        "page": page,
      });
      return Right(PostsModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, DefaultMainModel>> addReaction(
      {required String postId}) async {
    try {
      var response = await dio.post(EndPoints.addReactionUrl,
          body: {"key": "addReaction", "post_id": postId, "reaction": "like"});
      return Right(DefaultMainModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, AddPostModel>> addPost(
      {required List<File> mediaFiles,
      required String body,
      required String userId}) async {
    try {
      var response =
          await dio.post(EndPoints.addPostUrl, formDataIsEnabled: true, body: {
        "model": "Post",
        "user_id": userId,
        "body": body,
        for (int i = 0; i < mediaFiles.length; i++)
          "media[$i]": MultipartFile.fromFileSync(mediaFiles[i].path,
              filename: mediaFiles[i].path.split('/').last)
      });
      return Right(AddPostModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
