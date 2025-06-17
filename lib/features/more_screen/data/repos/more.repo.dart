import 'package:mawhebtak/core/api/base_api_consumer.dart';
import 'package:mawhebtak/core/exports.dart';
import 'package:mawhebtak/core/models/default_model.dart';
import 'package:mawhebtak/core/preferences/preferences.dart';
import 'package:mawhebtak/features/more_screen/data/model/setting_model.dart';

class MoreRepo {
  BaseApiConsumer api;
  MoreRepo(this.api);
  Future<Either<Failure, SettingModel>> settingData() async {
    try {
      var response = await api.get(
        EndPoints.settingUrl,
      );
      return Right(SettingModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, DefaultMainModel>> contactUs({required String message,
  required String subject,
    required String type,
    required String phone
  }) async {
    try {
      final user = await Preferences.instance.getUserModel();
      var response = await api.post(EndPoints.storeDataUrl, body: {
        'model': 'ContactUs',
        'user_id':user.data?.id,
        'message':message,
        'subject':subject,
        'type':type,
        'phone':phone,
      });
      return Right(DefaultMainModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
