import 'package:dartz/dartz.dart';
import 'package:mawhebtak/core/exports.dart';
import 'package:mawhebtak/features/profile/data/models/profile_model.dart';

class ProfileRepo {
  final BaseApiConsumer dio;
  ProfileRepo(this.dio);

  Future<Either<Failure, ProfileModel>> getProfileData({
    required String id,
  }) async {
    try {
      var response = await dio.get(EndPoints.profile+id.toString());
      return Right(ProfileModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}