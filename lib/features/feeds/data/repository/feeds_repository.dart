import 'package:dartz/dartz.dart';
import 'package:mawhebtak/core/api/end_points.dart';
import 'package:mawhebtak/core/error/exceptions.dart';
import 'package:mawhebtak/core/error/failures.dart';
import 'package:mawhebtak/core/models/default_model.dart';
import 'package:mawhebtak/features/feeds/data/models/posts_model.dart';
import '../../../../core/api/base_api_consumer.dart';

class FeedsRepository {
  final BaseApiConsumer dio ;
  FeedsRepository(this.dio);

  Future<Either<Failure, PostsModel>> feedsData({required String page})async {
    try {
      var response = await dio.get(
          EndPoints.feedsUrl + page,

      );
      return Right(PostsModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, DefaultMainModel>> addReaction({required String reaction , required String postId})async {
    try {
      var response = await dio.post(
          EndPoints.addReactionUrl,
        body: {
            "key":reaction,
            "post_id":postId,
            "reaction":"like"
        }
      );
      return Right(DefaultMainModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }


}
