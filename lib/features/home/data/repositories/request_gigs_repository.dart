import 'package:dartz/dartz.dart';
import 'package:mawhebtak/core/api/end_points.dart';
import 'package:mawhebtak/core/error/exceptions.dart';
import 'package:mawhebtak/core/error/failures.dart';
import 'package:mawhebtak/features/home/data/models/request_gigs_model.dart';
import '../../../../core/api/base_api_consumer.dart';

class RequestGigsRepository {
  final BaseApiConsumer dio;
  RequestGigsRepository(this.dio);

  Future<Either<Failure, RequestGigsModel>> requestGigsData(
      {required String page}) async {
    try {
      var response = await dio.get(EndPoints.getDataBaseUrl, queryParameters: {
        "model": "Gig",
        "where[0]": "status,1",
        "paginate": "true",
        "page": page
      });

      return Right(RequestGigsModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
