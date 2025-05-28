
import 'package:dartz/dartz.dart';
import 'package:mawhebtak/core/api/end_points.dart';
import 'package:mawhebtak/core/error/exceptions.dart';
import 'package:mawhebtak/core/error/failures.dart';
import 'package:mawhebtak/features/home/data/models/notifications_model.dart';
import '../../../../core/api/base_api_consumer.dart';

class NotificationsRepository {
  final BaseApiConsumer dio;
  NotificationsRepository(this.dio);
  Future<Either<Failure, GetNotificationsModel>> notificationsData() async {
    try {
      var response = await dio.get(EndPoints.notificationUrl);

      return Right(GetNotificationsModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
