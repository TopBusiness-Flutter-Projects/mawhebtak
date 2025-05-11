import 'package:dartz/dartz.dart';
import 'package:mawhebtak/core/api/base_api_consumer.dart';

import '../../../../../core/api/end_points.dart';
import '../../../../../core/error/exceptions.dart';
import '../../../../../core/error/failures.dart';
import '../model/validate_data.dart';

class VerificationRepo {
  BaseApiConsumer dio;
  VerificationRepo(this.dio);

  // validate-data

  //registerUrl
  Future<Either<Failure, ValidateDataMainModel>> validateData(String email,
      String name, String password, String phone, String? userTypeId) async {
    try {
      var response = await dio.post(
        EndPoints.validateDataUrl,
        body: {
          'key': 'validateData',
          'email': email,
          'name': name,
          'phone': phone,
          'user_type_id': userTypeId,
          'password': password
        },
      );
      return Right(ValidateDataMainModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
