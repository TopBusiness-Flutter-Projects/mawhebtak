import 'package:dartz/dartz.dart';
import 'package:mawhebtak/core/api/base_api_consumer.dart';

import '../../../../core/api/end_points.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../model/countries_model.dart';

class CalenderRepo {
  BaseApiConsumer dio;
  CalenderRepo(this.dio);
  //! get all countries
  Future<Either<Failure, GetCountriesMainModel>> mainGetData(
      {Map<String, dynamic>? queryParameters}) async {
    try {
      var response = await dio.get(EndPoints.getDataBaseUrl,
          queryParameters: queryParameters);
      return Right(GetCountriesMainModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
