import 'package:dartz/dartz.dart';
import 'package:mawhebtak/features/events/data/models/sell_all_event_model.dart';
import '../../../../core/api/base_api_consumer.dart';
import '../../../../core/api/end_points.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';


class EventRepo {
  final BaseApiConsumer dio;
  EventRepo(this.dio);
  Future<Either<Failure, SeeAllEventModel>> seeAllEventData()async {
    try {
      var response = await dio.get(
        EndPoints.seeAllEventUrl,

      );
      return Right(SeeAllEventModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

}
