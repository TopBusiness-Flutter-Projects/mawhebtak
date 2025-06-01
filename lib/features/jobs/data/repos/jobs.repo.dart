
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:mawhebtak/core/api/base_api_consumer.dart';
import 'package:mawhebtak/core/api/end_points.dart';
import 'package:mawhebtak/core/error/exceptions.dart';
import 'package:mawhebtak/core/error/failures.dart';
import 'package:mawhebtak/core/models/default_model.dart';
import 'package:mawhebtak/core/preferences/preferences.dart';
import 'package:mawhebtak/features/auth/login/data/models/login_model.dart';
import 'package:mawhebtak/features/jobs/data/model/user_jop_details_model.dart';
import 'package:mawhebtak/features/jobs/data/model/user_jop_model.dart';

class JobsRepo {
  BaseApiConsumer api;
  JobsRepo(this.api);
  Future<Either<Failure, UserJopModel>> getUserJopData({required String page}) async {
    try {
      var response = await api.get(
        EndPoints.getDataBaseUrl,
       queryParameters: {
          "model":"UserJob",
          "paginate":"true",
          "orderBy":"desc",
         "page":page,
       }
      );
      return Right(UserJopModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }
  Future<Either<Failure, UserJopDetailsModel>> getUserJopDetailsData({required String userJopId}) async {
    try {
      var response = await api.get(
        EndPoints.getDetailsDataUrl,
       queryParameters: {
          "model":"UserJob",
          "id":userJopId
        },
      );
      return Right(UserJopDetailsModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }
  Future<Either<Failure, DefaultMainModel>> addJopUser({
    required List<File> mediaFiles,
    required String title,
    required String description,
    required String location,
    required String lat,
    required String long,
    required String priceEndAt,
    required String priceStartAt,
    required String deadLine,
  }) async {
    try {
      LoginModel? user;
      user = await Preferences.instance.getUserModel();
      var response = await api
          .post(EndPoints.storeDataUrl,
          formDataIsEnabled: true, body: {
        "model": "UserJob",
        "user_id": user.data?.id,
        "title": title,
        "description": description,
        "location": location,
        "lat": lat,
        "long": long,
        "price_end_at": priceEndAt,
        "price_start_at": priceStartAt,
         "deadline":deadLine,
        for (int i = 0; i < mediaFiles.length; i++)
          "media[$i]": MultipartFile.fromFileSync(mediaFiles[i].path,
              filename: mediaFiles[i].path.split('/').last)
      });
      return Right(DefaultMainModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
