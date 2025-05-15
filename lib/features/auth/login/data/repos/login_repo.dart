import 'package:dartz/dartz.dart';
import 'package:mawhebtak/core/api/base_api_consumer.dart';

import '../../../../../core/api/end_points.dart';
import '../../../../../core/error/exceptions.dart';
import '../../../../../core/error/failures.dart';
import '../models/login_model.dart';

class LoginRepo {
  BaseApiConsumer dio;
  LoginRepo(this.dio);

  Future<Either<Failure, LoginModel>> login(
      String email, String password) async {
    try {
      var response = await dio.post(
        EndPoints.loginUrl,
        body: {'email': email, 'password': password, 'key': 'login'},
      );
      return Right(LoginModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, LoginModel>> loginWithSocial(
      {required String email,
      String? phone,
      required String name,
      required String socialType}) async {
    try {
      var response = await dio.post(
        EndPoints.loginWithSocial,
        body: {
          'key': 'loginWithSocial',
          'email': email,
          'name': name,
          'phone': phone,
          'social_type': socialType,
        },
      );
      return Right(LoginModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
