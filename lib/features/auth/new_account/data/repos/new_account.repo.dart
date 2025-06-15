import 'package:dartz/dartz.dart';
import 'package:mawhebtak/core/api/base_api_consumer.dart';

import '../../../../../core/api/end_points.dart';
import '../../../../../core/error/exceptions.dart';
import '../../../../../core/error/failures.dart';
import '../../../login/data/models/login_model.dart';
import '../model/user_types.dart';

class NewAccount {
  BaseApiConsumer dio;
  NewAccount(this.dio);

  //registerUrl
  Future<Either<Failure, LoginModel>> register(String email, String name,
      String password, String phone, String? userTypeId) async {
    try {
      var response = await dio.post(
        EndPoints.registerUrl,
        body: {
          'key': 'register',
          'email': email,
          'name': name,
          'phone': phone,
          'user_type_id': userTypeId,
          'password': password
        },
      );
      return Right(LoginModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  //registerUrl
  Future<Either<Failure, MainRegisterUserTypes>> getDataUserType() async {
    try {
      var response = await dio.get(
        EndPoints.getDataUserTypeUrl,
      );
      return Right(MainRegisterUserTypes.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }
  Future<Either<Failure, MainRegisterUserTypes>> getDataUserSubType({required String userTypeId}) async {
    try {
      var response = await dio.get(
        EndPoints.getDataUserSubTypeUrl+userTypeId,
      );
      return Right(MainRegisterUserTypes.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
