import 'package:dartz/dartz.dart';
import 'package:mawhebtak/core/api/base_api_consumer.dart';

import '../../../../../core/api/end_points.dart';
import '../../../../../core/error/exceptions.dart';
import '../../../../../core/error/failures.dart';
import '../../../verification/data/model/validate_data.dart';

class ForgetPasswordRepo {
  BaseApiConsumer dio;
  ForgetPasswordRepo(this.dio);

//forget-password

  Future<Either<Failure, ValidateDataMainModel>> forgetPassword(
    String email,
  ) async {
    try {
      var response = await dio.post(
        EndPoints.forgetPasswordUrl,
        body: {'key': 'forgetPassword', 'email': email},
      );
      return Right(ValidateDataMainModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
