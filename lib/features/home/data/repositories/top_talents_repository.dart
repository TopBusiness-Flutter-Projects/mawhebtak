import 'package:dartz/dartz.dart';
import 'package:mawhebtak/core/api/end_points.dart';
import 'package:mawhebtak/core/error/exceptions.dart';
import 'package:mawhebtak/core/error/failures.dart';
import 'package:mawhebtak/core/models/default_model.dart';
import 'package:mawhebtak/features/auth/new_account/data/model/user_types.dart';
import 'package:mawhebtak/features/home/data/models/followers_model.dart';
import 'package:mawhebtak/features/home/data/models/top_talents_model.dart';
import '../../../../core/api/base_api_consumer.dart';

class TopTalentsRepository {
  final BaseApiConsumer dio;
  TopTalentsRepository(this.dio);

  Future<Either<Failure, TopTalentsModel>> topTalentsData({
    required String page,
    String? orderBy,
    String? userSubTypeId,
  }) async {
    try {
      var response = await dio.get(EndPoints.getDataBaseUrl, queryParameters: {
        "model": "User",
        "where[0]": "status,1",
        "paginate": "true",
        if (userSubTypeId != null)
          "where[1]": "user_sub_type_id,$userSubTypeId",
        "orderBy": orderBy,
        "page": page
      });
      return Right(TopTalentsModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, FollowerAndFollowingModel>> getFollowersData({
    required String pageName,
    String? followedId,
    String? paginate,
    String? orderBy,
    String? page,
  }) async {
    try {
      final queryParams = {
        'model': 'Follower',
        'paginate': paginate,
        'orderBy': orderBy,
        'page': page,
      };

      // Add the correct where condition based on pageName
      if (pageName == 'followers') {
        queryParams['where[1]'] = 'followed_id,$followedId';
      } else {
        queryParams['where[1]'] = 'follower_id,$followedId';
      }

      final response = await dio.get(
        EndPoints.getDataBaseUrl,
        queryParameters: queryParams,
      );

      return Right(FollowerAndFollowingModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }


  Future<Either<Failure, MainRegisterUserTypes>> getDataUserType({
    String? paginate,
    String? orderBy,
  }) async {
    try {
      var response = await dio.get(EndPoints.getDataBaseUrl, queryParameters: {
        'model': "UserType",
        'where[0]': 'status,1',
        'paginate': paginate,
        'orderBy': orderBy,
      });
      return Right(MainRegisterUserTypes.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, MainRegisterUserTypes>> getDataUserSubType(
      {String? paginate, String? orderBy, required String userTypeId}) async {
    try {
      var response = await dio.get(EndPoints.getDataBaseUrl, queryParameters: {
        'model': 'UserSubType',
        'where[0]': 'status,1',
        'where[1]': 'user_type_id,$userTypeId',
        'paginate': paginate,
        'orderBy': orderBy,
      });
      return Right(MainRegisterUserTypes.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, DefaultMainModel>> hideTopTalents(
      {required String unwantedUserId}) async {
    try {
      var response = await dio.post(EndPoints.unWantedUserUrl, body: {
        "unwanted_user_id": unwantedUserId,
      });
      return Right(DefaultMainModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, DefaultMainModel>> followAndUnFollow(
      {required String followedId}) async {
    try {
      var response = await dio.post(
        EndPoints.followAndUnFollow,
        body: {
          "followed_id": followedId,
        },
      );
      return Right(DefaultMainModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
