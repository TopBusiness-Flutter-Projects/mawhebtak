import 'package:dartz/dartz.dart';
import 'package:mawhebtak/core/api/end_points.dart';
import 'package:mawhebtak/core/error/exceptions.dart';
import 'package:mawhebtak/core/error/failures.dart';
import 'package:mawhebtak/features/home/data/models/top_talents_model.dart';
import '../../../../core/api/base_api_consumer.dart';


class TopTalentsRepository {
  final BaseApiConsumer dio ;
  TopTalentsRepository(this.dio);


  Future<Either<Failure, TopTalentsModel>> topTalentsData()async {
    try {
      var response = await dio.get(
        EndPoints.topTalentsUrl,

      );
      return Right(TopTalentsModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

}
