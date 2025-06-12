import 'package:dartz/dartz.dart';
import 'package:mawhebtak/core/exports.dart';
import 'package:mawhebtak/core/models/default_model.dart';
import 'package:mawhebtak/features/profile/data/models/profile_model.dart';

class ProfileRepo {
  final BaseApiConsumer dio;
  ProfileRepo(this.dio);

  Future<Either<Failure, ProfileModel>> getProfileData({
    required String id,
  }) async {
    try {
      var response = await dio.get(EndPoints.profile + id.toString());
      return Right(ProfileModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, DefaultMainModel>> updateProfileData({
     String? name,
     String?email,
     String? phone,
     String? userSubTypeId,
     String? avatar,
     String? byCaver,
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
          'user_sub_type_id': userSubTypeId,
          'avatar': avatar,
          'bg_cover': byCaver,
          'lat': lat,
          'long': long,
          'bio': bio,
          'headline': headline,
          'location': location,
          'age': age,
          'gender': gender,
          'syndicate': syndicate,
          'email':email,
        },
      );

      return Right(DefaultMainModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    } catch (e) {
      // Optional: catch unexpected errors
      return Left(ServerFailure());
    }
  }
}
