import 'package:dartz/dartz.dart';
import 'package:mawhebtak/core/api/end_points.dart';
import 'package:mawhebtak/core/error/exceptions.dart';
import 'package:mawhebtak/core/error/failures.dart';
import 'package:mawhebtak/core/exports.dart';
import 'package:mawhebtak/features/announcement/data/models/announcements_model.dart';
import 'package:mawhebtak/features/calender/data/model/countries_model.dart';
import '../../../../core/api/base_api_consumer.dart';


class AnnouncementRepo {
  final BaseApiConsumer dio;
  AnnouncementRepo(this.dio);

  Future<Either<Failure, GetCountriesMainModel>> getCategoryFromAnnouncement(
      {
        String ?page,
        String ?orderBy,
      }) async {
    try {
      var response = await dio.get(EndPoints.getDataBaseUrl, queryParameters: {
        "model": "Category",
        "paginate":true,
        "page":page,
        "orderBy":orderBy,
        "where[2]":"type,1"

      });
      return Right(GetCountriesMainModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, AnnouncementsModel>> announcementsData({
    required String page,
    String? orderBy,
  }) async {
    String date = DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());

    try {
      var response = await dio.get(EndPoints.getDataBaseUrl,
          queryParameters: {
        "model": "Announce",
        "where[0]": "expire_in,>=,$date",
        "paginate": "true",
        "orderBy": orderBy,
        "page": page,
      });
      return Right(AnnouncementsModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }


}
