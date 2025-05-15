import 'package:dartz/dartz.dart';
import 'package:mawhebtak/core/api/end_points.dart';
import 'package:mawhebtak/core/error/exceptions.dart';
import 'package:mawhebtak/core/error/failures.dart';
import 'package:mawhebtak/features/feeds/data/models/posts_model.dart';
import '../../../../core/api/base_api_consumer.dart';

class FeedsRepository {
  final BaseApiConsumer dio ;
  FeedsRepository(this.dio);

  Future<Either<Failure, PostsModel>> feedsData({required String page})async {
    try {
      var response = await dio.get(
          EndPoints.feedsUrl,
          queryParameters: {
            "model" :"Post",
            "where[0]":"status,1",
            "paginate":"true",
            "page":page

          }
      );
      return Right(PostsModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

}
