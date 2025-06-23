
import 'package:dartz/dartz.dart';
import 'package:mawhebtak/core/api/base_api_consumer.dart';
import 'package:mawhebtak/core/api/end_points.dart';
import 'package:mawhebtak/core/error/exceptions.dart';
import 'package:mawhebtak/core/error/failures.dart';
import 'package:mawhebtak/features/announcement/data/models/announcements_model.dart';
import 'package:mawhebtak/features/casting/data/model/request_gigs_model.dart';
import 'package:mawhebtak/features/feeds/data/models/posts_model.dart';
import 'package:mawhebtak/features/home/data/models/top_events_model.dart';
import 'package:mawhebtak/features/jobs/data/model/user_jop_model.dart';

class SearchRepo {
  BaseApiConsumer api;
  SearchRepo(this.api);
  // search announcment
  Future<Either<Failure, AnnouncementsModel>> getSearchAnnouncmentData(
      {required String search}) async {
    try {
      var response = await api.get(EndPoints.searchRoute,
          queryParameters: {
        "model": "Announce",
        "search": search,
      });
      return Right(AnnouncementsModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }
  // search gig
  Future<Either<Failure, RequestGigsModel>> getSearchGigsData(
      {required String search}) async {
    try {
      var response = await api.get(EndPoints.searchRoute,
          queryParameters: {
        "model": "Gig",
        "search": search,
      });
      return Right(RequestGigsModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }
  // search job
  Future<Either<Failure, UserJobModel>> getSearchJobData(
      {required String search}) async {
    try {
      var response = await api.get(EndPoints.searchRoute,
          queryParameters: {
        "model": "UserJob",
        "search": search,
      });
      return Right(UserJobModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  // search event
  Future<Either<Failure, TopEventsModel>> getSearchEventData(
      {required String search}) async {
    try {
      var response = await api.get(EndPoints.searchRoute,
          queryParameters: {
        "model": "Event",
        "search": search,
      });
      return Right(TopEventsModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }
  // search post
  Future<Either<Failure, PostsModel>> getSearchPostData(
      {required String search}) async {
    try {
      var response = await api.get(EndPoints.searchRoute,
          queryParameters: {
        "model": "Post",
        "search": search,
      });
      return Right(PostsModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }


}
