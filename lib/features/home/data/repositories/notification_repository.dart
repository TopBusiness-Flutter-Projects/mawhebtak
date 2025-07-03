
import 'package:dartz/dartz.dart';
import 'package:mawhebtak/core/api/end_points.dart';
import 'package:mawhebtak/core/error/exceptions.dart';
import 'package:mawhebtak/core/error/failures.dart';
import 'package:mawhebtak/core/preferences/preferences.dart';
import 'package:mawhebtak/features/home/data/models/notifications_model.dart';
import '../../../../core/api/base_api_consumer.dart';

class NotificationsRepository {
  final BaseApiConsumer dio;
  NotificationsRepository(this.dio);
  Future<Either<Failure, NotificationModel>> notificationsData({
     String? orderBy,
     String? page,
}) async {
    final user = await Preferences.instance.getUserModel();
    try {
      var response = await dio.get(EndPoints.getNotificationUrl,
      );

      return Right(NotificationModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
