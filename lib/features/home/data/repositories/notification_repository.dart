
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
     String? paginate,
     String? page,
}) async {
    final user = await Preferences.instance.getUserModel();
    try {
      var response = await dio.get(EndPoints.getDataBaseUrl,
      queryParameters: {
        'model':'Notification',
        'orderBy':orderBy,
        'paginate':paginate,
        'where[1]':'user_id,${user.data?.id?.toString()}',
        'page':page,
      }
      );

      return Right(NotificationModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
