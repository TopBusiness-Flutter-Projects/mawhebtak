import 'package:dartz/dartz.dart';
import 'package:mawhebtak/core/api/end_points.dart';
import 'package:mawhebtak/core/error/exceptions.dart';
import 'package:mawhebtak/core/error/failures.dart';
import 'package:mawhebtak/features/home/data/models/top_events_model.dart';
import '../../../../core/api/base_api_consumer.dart';

class TopEventsRepository {
  final BaseApiConsumer dio;
  TopEventsRepository(this.dio);
  Future<Either<Failure, TopEventsModel>> topEventsData(
      {required String page}) async {
    try {
      var response = await dio.get(EndPoints.getDataBaseUrl, queryParameters: {
        "model": "Event",
        "where[0]": "status,1",
        "where[1]": "is_end,0",
        "paginate": "true",
        "page": page
      });
      return Right(TopEventsModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
