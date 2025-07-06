import 'package:dartz/dartz.dart';
import 'package:mawhebtak/core/api/base_api_consumer.dart';
import 'package:mawhebtak/features/calender/data/model/countries_model.dart';
import '../../../../../core/api/end_points.dart';
import '../../../../../core/error/exceptions.dart';
import '../../../../../core/error/failures.dart';
import '../../../login/data/models/login_model.dart';
import '../model/user_types.dart';
import '../../../../../core/preferences/preferences.dart';

class NewAccount {
  BaseApiConsumer dio;
  NewAccount(this.dio);

  //registerUrl
  Future<Either<Failure, LoginModel>> register({
    required String email,
    required String name,
    required String password,
    required String phone,
    required String? userTypeId,
    required String? countryCode,
    required List<GetCountriesMainModelData> selectedUserSubType,
  }) async {
    try {
      final deviceToken = await Preferences.instance.getDeviceToken();

      var response = await dio.post(
        EndPoints.registerUrl,
        body: {
          'key': 'register',
          'email': email,
          'name': name,
          'phone': phone,
          'country_code': countryCode,
          // 'user_type_id': userTypeId,
          for (int i = 0; i < selectedUserSubType.length; i++)
            "user_sub_type_ids[$i]":
                selectedUserSubType[i].id?.toString() ?? '',
          'password': password,
          "device_token": deviceToken,
        },
      );
      return Right(LoginModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  //registerUrl
  Future<Either<Failure, MainRegisterUserTypes>> getDataUserType({
    String? paginate,
    String? orderBy,
  }) async {
    try {
      var response = await dio.get(EndPoints.getDataBaseUrl, queryParameters: {
        'model': "UserType",
        'where[0]': 'status,1',
        'paginate': paginate,
        'orderBy': orderBy,
      });
      return Right(MainRegisterUserTypes.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, MainRegisterUserTypes>> getDataUserSubType(
      {String? orderBy, String? userTypeId}) async {
    try {
      var response = await dio.get(EndPoints.getDataBaseUrl, queryParameters: {
        'model': 'UserSubType',
        'where[0]': 'status,1',
        if (userTypeId != null) 'where[1]': 'user_type_id,$userTypeId',
        'orderBy': orderBy,
      });
      return Right(MainRegisterUserTypes.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
