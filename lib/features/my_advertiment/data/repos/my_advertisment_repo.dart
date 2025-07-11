import 'dart:io';

import 'package:dio/dio.dart';
import 'package:mawhebtak/core/exports.dart';
import 'package:mawhebtak/core/models/default_model.dart';
import 'package:mawhebtak/core/preferences/preferences.dart';
import 'package:mawhebtak/features/announcement/data/models/announcements_model.dart';
import 'package:mawhebtak/features/casting/data/model/request_gigs_model.dart';
import 'package:mawhebtak/features/home/data/models/top_events_model.dart';
import 'package:mawhebtak/features/my_advertiment/data/models/user_package_details_model.dart';
import '../models/user_package_model.dart';

class MyAdvertismentRepo {
  BaseApiConsumer dio;
  MyAdvertismentRepo(this.dio);
  //events
  Future<Either<Failure, TopEventsModel>> eventsData() async {
    final userModel = await Preferences.instance.getUserModel();
    try {
      var response = await dio.get(EndPoints.getDataBaseUrl, queryParameters: {
        "model": "Event",
        "where[1]": "user_id,${userModel.data?.id?.toString()}",
      });
      return Right(TopEventsModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  // announcment
  Future<Either<Failure, AnnouncementsModel>> announcmentData() async {
    try {
      final userModel = await Preferences.instance.getUserModel();
      var response = await dio.get(EndPoints.getDataBaseUrl, queryParameters: {
        "model": "Announce",
        "where[1]": "user_id,${userModel.data?.id?.toString()}",
      });
      return Right(AnnouncementsModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  // gigs
  Future<Either<Failure, RequestGigsModel>> gigsData() async {
    try {
      final userModel = await Preferences.instance.getUserModel();
      var response = await dio.get(EndPoints.getDataBaseUrl, queryParameters: {
        "model": "Gig",
        "where[1]": "user_id,${userModel.data?.id?.toString()}",
      });
      return Right(RequestGigsModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  // // الاشتراكات
  Future<Either<Failure, UserPackageModel>> getUserPackageData() async {
    final userModel = await Preferences.instance.getUserModel();
    try {
      final response =
          await dio.get(EndPoints.getDataBaseUrl, queryParameters: {
        'model': 'UserPackage',
        'where[0]': 'status,1',
        "where[1]": "user_id,${userModel.data?.id?.toString()}",
      });
      return Right(UserPackageModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  // // تفاصيل الاشتراك

  Future<Either<Failure, UserPackageDetailsModel>> getUserPackageDetailsData(
      {required String idFromPackage}) async {
    try {
      final response = await dio.get(
        EndPoints.userPackageDetailsUrl + idFromPackage,
      );
      return Right(UserPackageDetailsModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  // // اضافة اعلان
  Future<Either<Failure, DefaultMainModel>> addAdds(
      {required String id,
      required String fromDate,
      required String toDate,
      required String modelType,
      String? modelId,
      required File image}) async {
    try {
      final response =
          await dio.post(EndPoints.addAddsUrl, formDataIsEnabled: true, body: {
        'key': 'addAd',
        'user_package_id': id,
        'from_date': fromDate,
        'to_date': toDate,
        'model_type': modelType,
        if (modelId != null) 'model_id': modelId,
        'image': MultipartFile.fromFileSync(image.path,
            filename: image.path.split('/').last),
      });
      return Right(DefaultMainModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
