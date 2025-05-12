import 'package:dartz/dartz.dart';
import 'package:mawhebtak/core/api/end_points.dart';
import 'package:mawhebtak/core/error/exceptions.dart';
import 'package:mawhebtak/core/error/failures.dart';
import 'package:mawhebtak/features/home/data/models/home_model.dart';

import '../../../../core/api/base_api_consumer.dart';


class HomeRepo {
  final BaseApiConsumer dio;
  HomeRepo(this.dio);
  Future<Either<Failure, HomeModel>> homeData()async {
    try {
      var response = await dio.get(
        EndPoints.homeUrl,

      );
      return Right(HomeModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

}
