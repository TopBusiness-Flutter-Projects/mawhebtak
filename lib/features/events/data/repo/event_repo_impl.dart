import 'package:dartz/dartz.dart';
import 'package:mawhebtak/features/home/data/models/top_events_model.dart';
import '../../../../core/api/base_api_consumer.dart';
import '../../../../core/api/end_points.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';


class EventRepo {
  final BaseApiConsumer dio;
  EventRepo(this.dio);
  Future<Either<Failure, TopEventsModel>> seeAllEventData()async {
    try {
      var response = await dio.get(
        EndPoints.topEventsUrl,

      );
      return Right(TopEventsModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

}
