import 'package:dartz/dartz.dart';
import 'package:mawhebtak/core/api/base_api_consumer.dart';

import '../../../../../core/api/end_points.dart';
import '../../../../../core/error/exceptions.dart';
import '../../../../../core/error/failures.dart';
import '../../../../../core/models/default_model.dart';

class NewPasswordRepo {
  BaseApiConsumer dio;
  NewPasswordRepo(this.dio);

  Future<Either<Failure, DefaultMainModel>> resetPassword(
      String email, String password, String passwordConfirmation) async {
    try {
      var response = await dio.post(
        EndPoints.updatePasswordUrl,
        body: {
          'key': 'updatePassword',
          'email': email,
          'password': password,
          'password_confirmation': passwordConfirmation,
        },
      );
      return Right(DefaultMainModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
