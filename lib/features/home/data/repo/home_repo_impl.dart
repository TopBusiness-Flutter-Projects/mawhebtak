import 'package:dartz/dartz.dart';
import 'package:mawhebtak/core/api/end_points.dart';
import 'package:mawhebtak/core/error/exceptions.dart';
import 'package:mawhebtak/core/error/failures.dart';

import '../../../../core/api/base_api_consumer.dart';


class HomeRepo {
  final BaseApiConsumer dio;
  HomeRepo(this.dio);
  // Future<Either<Failure, LoginModel>> homeData()async {
  //   try {
  //     var response = await dio.get(
  //       EndPoints.homeUrl,
  //
  //     );
  //     return Right(LoginModel.fromJson(response));
  //   } on ServerException {
  //     return Left(ServerFailure());
  //   }
  // }

}
