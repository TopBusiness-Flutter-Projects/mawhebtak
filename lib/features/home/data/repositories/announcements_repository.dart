import 'package:dartz/dartz.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:mawhebtak/core/api/end_points.dart';
import 'package:mawhebtak/core/error/exceptions.dart';
import 'package:mawhebtak/core/error/failures.dart';
import 'package:mawhebtak/features/home/data/models/announcements_model.dart';
import '../../../../core/api/base_api_consumer.dart';

class AnnouncementsRepository {
  final BaseApiConsumer dio ;
  AnnouncementsRepository(this.dio);

  String date = DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());
  Future<Either<Failure, AnnouncementsModel>> announcementsData({required String page})async {
    try {
      var response = await dio.get(
        EndPoints.announcementsUrl,
          queryParameters: {
            "model" :"Announce",
            "where[0]":"expire_in,>=,$date",
            "paginate":"true",
            "page":page

          }
      );
      return Right(AnnouncementsModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

}
