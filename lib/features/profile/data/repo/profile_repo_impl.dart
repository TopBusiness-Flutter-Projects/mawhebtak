import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:mawhebtak/core/exports.dart';
import 'package:mawhebtak/core/models/default_model.dart';
import 'package:mawhebtak/features/profile/data/models/profile_model.dart';

class ProfileRepo {
  final BaseApiConsumer dio;
  ProfileRepo(this.dio);

  Future<Either<Failure, ProfileModel>> getProfileData({String? id}) async {
    try {
      var response = await dio.get(EndPoints.profile + (id ?? ''));

      log('eeeeeeeeeee ${response}');
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
    String? email,
    String? phone,
    String? userSubTypeId,
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
  }) async {
    try {
      final response = await dio.post(
        EndPoints.updateProfile,
        formDataIsEnabled: true,
        body: {
          'name': name,
          'phone': phone,
          if (userSubTypeId != null) 'user_sub_type_id': userSubTypeId,
          if (avatar != null)
            'avatar': MultipartFile.fromFileSync(avatar.path,
                filename: avatar.path.split('/').last),
          if (byCaver != null)
            'bg_cover': MultipartFile.fromFileSync(byCaver.path,
                filename: byCaver.path.split('/').last),
          'lat': lat,
          'long': long,
          'bio': bio,
          'headline': headline,
          'location': location,
          if (age != null) 'age': age,
          'gender': gender,
          if (syndicate != null) 'syndicate': syndicate,
          'email': email,
        },
      );

      return Right(DefaultMainModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}
