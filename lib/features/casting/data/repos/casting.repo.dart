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
import 'package:mawhebtak/features/casting/data/model/add_gig_model.dart';
import 'package:mawhebtak/features/casting/data/model/get_datails_gigs_model.dart';
import 'package:mawhebtak/features/casting/data/model/get_gigs_from_sub_category_model.dart';

import '../../../calender/data/model/countries_model.dart';

class CastingRepo {
  BaseApiConsumer api;
  CastingRepo(this.api);
  Future<Either<Failure, AddNewGigModel>> addNewGig({
    required List<File> mediaFiles,
    required String subCategoryId,
    required String categoryId,
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
        "category_id": categoryId,
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
  Future<Either<Failure, GetCountriesMainModel>> getCategoryFromGigs(
      {
        String ?page,
        String ?orderBy,
      }) async {
    try {
      var response = await api.get(EndPoints.getDataBaseUrl, queryParameters: {
        "model": "Category",
        "paginate":true,
        "page":page,
        "orderBy":orderBy,
        "where[2]":"type,0"

      });
      return Right(GetCountriesMainModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, GetGigsFromSubCategoryModel>> getGigsFromSubCategory(
      {required String id}) async {
    try {
      var response = await api.get(EndPoints.getDataBaseUrl,
          queryParameters: {
        "model": "Gig",
        "where[1]": "sub_category_id,$id",
            "where[2]":"type,0"
      });
      return Right(GetGigsFromSubCategoryModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, GetDetailsGigsModel>> getDetailsGigs(
      {required String id}) async {
    try {
      var response =
          await api.get(EndPoints.getDetailsDataUrl, queryParameters: {
        "model": "Gig",
        "id": id,
      });
      return Right(GetDetailsGigsModel.fromJson(response));
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

  Future<Either<Failure, DefaultMainModel>> actionGig(
      {required String gigId, required String status}) async {
    try {
      var response = await api.post(
        EndPoints.actionGigsUrl + gigId,
        body: {
          "key": "ActionGig",
          "status": status,
        },
      );

      return Right(DefaultMainModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, DefaultMainModel>> requestGig(
      {required String gigId}) async {
    try {
      var response = await api.post(
        EndPoints.requestGigs,
        body: {
          "key": "RequestCancelGig",
          "gig_id": gigId,
        },
      );
      return Right(DefaultMainModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, DefaultMainModel>> followAndUnFollow(
      {required String followedId}) async {
    try {
      var response = await api.post(
        EndPoints.followAndUnFollow,
        body: {
          "followed_id": followedId,
        },
      );
      return Right(DefaultMainModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
