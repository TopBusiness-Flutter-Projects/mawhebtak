import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:mawhebtak/features/home/data/models/top_events_model.dart';
import '../../../../core/api/base_api_consumer.dart';
import '../../../../core/api/end_points.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/models/default_model.dart';
import '../model/event_details_model.dart';

class EventRepo {
  final BaseApiConsumer dio;
  EventRepo(this.dio);
  Future<Either<Failure, TopEventsModel>> seeAllEventData() async {
    try {
      var response = await dio.get(
        EndPoints.getDataBaseUrl,
      );
      return Right(TopEventsModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, GetMainEvenDetailsModel>> getEventDetailsById(
      String id) async {
    try {
      var response =
          await dio.get(EndPoints.getDetailsDataUrl, queryParameters: {
        "model": "Event",
        "id": id,
      });
      return Right(GetMainEvenDetailsModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, DefaultMainModel>> followUnfollowEvent({
   required String eventId,
    int? paymentMethod,
  }) async {
    try {
      var response = await dio.post(EndPoints.followUnfollowEventUrl, body: {
        "event_id": eventId,
        if(paymentMethod != null)
        "payment_method":paymentMethod,
      });
      return Right(DefaultMainModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, DefaultMainModel>> scanQrCode({
    String? eventFollowerId,
  }) async {
    try {
      var response = await dio.post(EndPoints.scanEventQrCode, body: {
        if(eventFollowerId != null)
        "event_follower_id": eventFollowerId,
      });
      return Right(DefaultMainModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, DefaultMainModel>> applyToEvent(
      String eventId, String price, String eventRequirementId, String note,
      {required List<File> files}) async {
    try {
      var response = await dio
          .post(EndPoints.applyToEventUrl, formDataIsEnabled: true, body: {
        "key": "applyToEvent",
        "event_id": eventId,
        "price": price,
        "event_requirement_id": eventRequirementId,
        "note": note,
        for (int i = 0; i < files.length; i++)
          "media[$i]": MultipartFile.fromFileSync(files[i].path,
              filename: files[i].path.split('/').last)
      });
      return Right(DefaultMainModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, DefaultMainModel>> deleteEvent(String eventId) async {
    try {
      var response =
          await dio.post(EndPoints.deleteData, formDataIsEnabled: true, body: {
        "model": "Event",
        "id": eventId,
      });
      return Right(DefaultMainModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, DefaultMainModel>> actionEventRequest(
      {required String eventId, required String status}) async {
    try {
      var response = await dio.post(EndPoints.actionEventRequestUrl + eventId,
          formDataIsEnabled: true,
          body: {"key": "actionEvent", "status": status});
      return Right(DefaultMainModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
