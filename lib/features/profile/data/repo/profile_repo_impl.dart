import 'dart:io';

import 'package:dio/dio.dart';
import 'package:mawhebtak/core/exports.dart';
import 'package:mawhebtak/core/models/default_model.dart';
import 'package:mawhebtak/core/preferences/preferences.dart';
import 'package:mawhebtak/features/calender/data/model/countries_model.dart';
import 'package:mawhebtak/features/casting/data/model/request_gigs_model.dart';
import 'package:mawhebtak/features/home/data/models/followers_model.dart';
import 'package:mawhebtak/features/profile/data/models/profile_model.dart';

class ProfileRepo {
  final BaseApiConsumer dio;
  ProfileRepo(this.dio);

  Future<Either<Failure, ProfileModel>> getProfileData({String? id}) async {
    try {
      var response = await dio.get(EndPoints.profile + (id ?? ''));
      return Right(ProfileModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, DefaultMainModel>> addReview({
    String? userId,
    String? comment,
    String? review,
  }) async {
    try {
      var response = await dio.post(EndPoints.addReview, body: {
        'comment': comment,
        'user_id': userId,
        'review': review,
      });
      return Right(DefaultMainModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }


  Future<Either<Failure, DefaultMainModel>> updateProfileData({
    String? name,
    String? phone,
    File? avatar,
    File? byCaver,
    String? lat,
    String? long,
    String? bio,
    String? headline,
    String? location,
    String? age,
    String? gender,
    String? syndicate,
    int? isPhoneHidden,
    String? countryCode,
    required List<GetCountriesMainModelData> selectedUserSubType,
  }) async {
    try {
      final response = await dio.post(
        EndPoints.updateProfile,
        formDataIsEnabled: true,
        body: {
          if (isPhoneHidden == 0) 'is_phone_hidden': isPhoneHidden,
          'name': name,
          if (phone != null) 'phone': phone,
          if (countryCode != null) 'country_code': countryCode,
          for (int i = 0; i < selectedUserSubType.length; i++)
            "user_sub_type_ids[$i]":
                selectedUserSubType[i].id?.toString() ?? '',
          if (avatar != null)
            'avatar': MultipartFile.fromFileSync(avatar.path,
                filename: avatar.path.split('/').last),
          if (byCaver != null)
            'bg_cover': MultipartFile.fromFileSync(byCaver.path,
                filename: byCaver.path.split('/').last),
          'lat': lat,
          'long': long,
          if (bio != null) 'bio': bio,
          if (headline != null) 'headline': headline,
          if (location != null) 'location': location,
          if (age != null) 'age': age,
          if (gender != null) 'gender': gender,
          if (syndicate != null) 'syndicate': syndicate,
        },
      );

      return Right(DefaultMainModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, DefaultMainModel>> addNewExperience(
      {String? description,
      String? title,
      DateTime? from,
      DateTime? to,
      bool isUntilNow = false}) async {
    try {
      final userModel = await Preferences.instance.getUserModel();
      var response = await dio.post(EndPoints.storeDataUrl, body: {
        'model': 'Experience',
        'user_id': userModel.data?.id.toString(),
        'title': title,
        'description': description,
        if (from != null) 'from': DateFormat('yyyy-MM-dd').format(from),
        if ((!isUntilNow) && (to != null))
          'to': DateFormat('yyyy-MM-dd').format(to),
      });
      return Right(DefaultMainModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, DefaultMainModel>> updateExperience(
      {String? description,
      String? title,
      required String id,
      DateTime? from,
      DateTime? to,
      bool isUntilNow = false}) async {
    try {
      final userModel = await Preferences.instance.getUserModel();
      var response = await dio.post(EndPoints.updateDataUrl, body: {
        'model': 'Experience',
        'user_id': userModel.data?.id.toString(),
        'title': title,
        'description': description,
        'id': id,
        if (from != null) 'from': DateFormat('yyyy-MM-dd').format(from),
        if ((!isUntilNow) && (to != null))
          'to': DateFormat('yyyy-MM-dd').format(to),
      });
      return Right(DefaultMainModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
