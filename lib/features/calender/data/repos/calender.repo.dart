import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:mawhebtak/core/api/base_api_consumer.dart';
import 'package:mawhebtak/core/models/default_model.dart';
import 'package:mawhebtak/core/preferences/preferences.dart';
import '../../../../core/api/end_points.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../model/countries_model.dart';
import '../model/selected_talends.dart';
import 'model/calender_model.dart';
import 'model/event_model.dart';

class CalenderRepo {
  BaseApiConsumer dio;
  CalenderRepo(this.dio);
  //! get all countries
  Future<Either<Failure, GetCountriesMainModel>> mainGetData(
      {Map<String, dynamic>? queryParameters}) async {
    try {
      var response = await dio.get(EndPoints.getDataBaseUrl,
          queryParameters: queryParameters);
      return Right(GetCountriesMainModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, MainCalendarEvent>> eventCalendar() async {
    try {
      var response = await dio.get(EndPoints.eventCalendarUrl);
      return Right(MainCalendarEvent.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  //!get my events
  Future<Either<Failure, GetMainEventModel>> getmyEvents() async {
    try {
      final userModel = await Preferences.instance.getUserModel();
      var response = await dio.get(EndPoints.getDataBaseUrl, queryParameters: {
        "model": "Event",
        "where[1]": "user_id,${userModel.data?.id?.toString()}",
      });
      return Right(GetMainEventModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, DefaultMainModel>> storeEvent({
    required List<SelectedTalends> selectedTalents,
    required List<File> files,
    required String title,
    required String description,
    required String from,
    required String to,
    required String location,
    required String lat,
    required String long,
    required String isPublic,
    required String categoryId,
    required String eventLimit,
    required String eventPrice,
    required String discountValue,
    String? currencyId,
  }) async {
    try {
      var response = await dio
          .post(EndPoints.storeEventUrl,
          formDataIsEnabled: true, body: {
        "key": "storeEvent",
        "title": title,
        "description": description,
        "from": from,
        "to": to,
        "location": location,
        "lat": lat,
        "long": long,
        "is_public": isPublic,
        "category_id": categoryId,
        "event_limit": eventLimit,
        "event_price": eventPrice,
        "currency_id": currencyId,
        "discount": discountValue,
        for (int i = 0; i < selectedTalents.length; i++)
          "sub_category_ids[$i]":
              selectedTalents[i].subCategoryIds.id?.toString() ?? '',
        for (int i = 0; i < selectedTalents.length; i++)
          "prices[$i]": selectedTalents[i].prices.toString(),
        for (int i = 0; i < selectedTalents.length; i++)
          "currency_ids[$i]":
              selectedTalents[i].countryCurrencies.id?.toString() ?? '',
        for (int i = 0; i < files.length; i++)
          "media[$i]": MultipartFile.fromFileSync(files[i].path,
              filename: files[i].path.split('/').last)
      });
      return Right(DefaultMainModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
