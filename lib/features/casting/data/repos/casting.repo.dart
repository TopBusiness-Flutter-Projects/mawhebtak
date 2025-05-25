import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:mawhebtak/core/api/base_api_consumer.dart';
import 'package:mawhebtak/core/api/end_points.dart';
import 'package:mawhebtak/core/error/exceptions.dart';
import 'package:mawhebtak/core/error/failures.dart';
import 'package:mawhebtak/core/preferences/preferences.dart';
import 'package:mawhebtak/features/auth/login/data/models/login_model.dart';
import 'package:mawhebtak/features/casting/data/model/add_gig_model.dart';

import '../../../calender/data/model/countries_model.dart';

class CastingRepo {
  BaseApiConsumer api;
  CastingRepo(this.api);
  Future<Either<Failure, AddNewGigModel>> addNewGig({
    required List<File> mediaFiles,
    required String subCategoryId,
    required String title,
    required String description,
    required String location,
    required String lat,
    required String long,
    required String price,
  }) async {
    try {
      LoginModel? user;
      user = await Preferences.instance.getUserModel();
      var response = await api
          .post(EndPoints.storeDataUrl, formDataIsEnabled: true, body: {
        "model": "Gig",
        "user_id": user.data?.id,
        "sub_category_id": subCategoryId,
        "title": title,
        "description": description,
        "location": location,
        "lat": lat,
        "long": long,
        "price": price,
        for (int i = 0; i < mediaFiles.length; i++)
          "media[$i]": MultipartFile.fromFileSync(mediaFiles[i].path,
              filename: mediaFiles[i].path.split('/').last)
      });
      return Right(AddNewGigModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  // categories data
  Future<Either<Failure, GetCountriesMainModel>> getCategory() async {
    try {
      var response = await api.get(EndPoints.getDataBaseUrl, queryParameters: {
        "model": "Category",
        "where[0]": "status,1",
        "orderBy": "asc",
      });
      return Right(GetCountriesMainModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, GetCountriesMainModel>> subCetCategory(
      {required String categoryId}) async {
    try {
      var response = await api.get(EndPoints.getDataBaseUrl, queryParameters: {
        "model": "SubCategory",
        "where[0]": "category_id,$categoryId",
      });
      return Right(GetCountriesMainModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
