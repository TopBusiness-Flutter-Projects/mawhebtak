import 'package:dartz/dartz.dart';
import 'package:mawhebtak/core/api/base_api_consumer.dart';
import 'package:mawhebtak/features/calender/data/model/countries_model.dart';

import '../../../../../core/api/end_points.dart';
import '../../../../../core/error/exceptions.dart';
import '../../../../../core/error/failures.dart';
import '../model/validate_data.dart';

class VerificationRepo {
  BaseApiConsumer dio;
  VerificationRepo(this.dio);

  // validate-data

  //registerUrl
  Future<Either<Failure, ValidateDataMainModel>> validateData({
   required String email,
    required String name,
    required  String password,
    required  String phone,
    required  String? userTypeId,
    required  String? userSubTypeId,
    required   String? countryCode,
    required List<GetCountriesMainModelData> selectedUserSubType,
  }) async {
    try {
      var response = await dio.post(
        EndPoints.validateDataUrl,
        formDataIsEnabled: true,
        body: {
          'key': 'validateData',
          'email': email,
          'name': name,
          'country_code':countryCode,
          'phone': phone,
          for (int i = 0; i < selectedUserSubType.length; i++)
            "user_sub_type_ids[$i]":
            selectedUserSubType[i].id?.toString() ?? '',
          'password': password
        },
      );
      return Right(ValidateDataMainModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
