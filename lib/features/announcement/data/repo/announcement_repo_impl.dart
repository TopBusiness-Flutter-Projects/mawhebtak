import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:mawhebtak/core/api/end_points.dart';
import 'package:mawhebtak/core/error/exceptions.dart';
import 'package:mawhebtak/core/error/failures.dart';
import 'package:mawhebtak/core/exports.dart';
import 'package:mawhebtak/core/models/default_model.dart';
import 'package:mawhebtak/core/preferences/preferences.dart';
import 'package:mawhebtak/features/announcement/data/models/announcement_details_model.dart';
import 'package:mawhebtak/features/announcement/data/models/announcements_model.dart';
import 'package:mawhebtak/features/auth/login/data/models/login_model.dart';
import 'package:mawhebtak/features/calender/data/model/countries_model.dart';
import 'package:mawhebtak/features/casting/data/model/get_gigs_from_sub_category_model.dart';
import '../../../../core/api/base_api_consumer.dart';

class AnnouncementRepo {
  final BaseApiConsumer dio;
  AnnouncementRepo(this.dio);

  Future<Either<Failure, GetCountriesMainModel>> getCategoryFromAnnouncement({
    String? page,
    String? orderBy,
  }) async {
    try {
      var response = await dio.get(EndPoints.getDataBaseUrl, queryParameters: {
        "model": "Category",
        "paginate": true,
        "page": page,
        "orderBy": orderBy,
        "where[2]": "type,1"
      });
      return Right(GetCountriesMainModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, AnnouncementsModel>> announcementsData({
    required String page,
    String? orderBy,
  }) async {
    String date = DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());
    final userModel = await Preferences.instance.getUserModel();
    print("userid ${userModel.data?.id?.toString()}");
    print("userid ${date}");
    try {
      var response = await dio.get(EndPoints.getDataBaseUrl, queryParameters: {
        "model": "Announce",
         "where[0]": "expire_in,>=,$date",
       "where[1]": "user_id,${userModel.data?.id?.toString()}",
        "paginate": "true",
        "orderBy": orderBy,
        "page": page,
      });
      return Right(AnnouncementsModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, GetCountriesMainModel>>
      dataFromSubCategoryAnnouncement({required String categoryId}) async {
    try {
      var response = await dio.get(EndPoints.getDataBaseUrl, queryParameters: {
        "model": "SubCategory",
        "where[0]": "category_id,$categoryId",
      });
      return Right(GetCountriesMainModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, GetGigsFromSubCategoryModel>>
      getAnnouncementsFromSubCategory({required String subCategoryId}) async {
    try {
      var response = await dio.get(EndPoints.getDataBaseUrl, queryParameters: {
        "model": "Gig",
        "where[1]": "sub_category_id,$subCategoryId",
        "orderBy": 'desc',
      });
      return Right(GetGigsFromSubCategoryModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, GetCountriesMainModel>>
      subCategoryFromCategoryAnnouncement({required String categoryId}) async {
    try {
      var response = await dio.get(EndPoints.getDataBaseUrl, queryParameters: {
        "model": "SubCategory",
        "where[0]": "category_id,$categoryId",
      });
      return Right(GetCountriesMainModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, AnnouncementDetailsModel>> announcementDetails(
      {required String announcementId}) async {
    try {
      var response =
          await dio.get(EndPoints.getDetailsDataUrl, queryParameters: {
        "model": "Announce",
        "id": announcementId,
      });
      return Right(AnnouncementDetailsModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }


  Future<Either<Failure, DefaultMainModel>> addAnnouncement({
    required List<File> mediaFiles,
    required String title,
    required String description,
    required String location,
    required String lat,
    required String long,
    required String price,
    required String subCategoryId,
    required DateTime expireIn,
  }) async {
    try {
      LoginModel? user;
      user = await Preferences.instance.getUserModel();
      var response = await dio.post(EndPoints.storeDataUrl, formDataIsEnabled: true, body: {
        "model": "Announce",
        "user_id": user.data?.id,
        "title": title,
        "description": description,
        "location": location,
        "lat": lat,
        "long": long,
        "expire_in": expireIn,
        "sub_category_id": subCategoryId,
        "price": price,
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
