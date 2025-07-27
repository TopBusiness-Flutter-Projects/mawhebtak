import 'package:mawhebtak/core/exports.dart';
import 'package:mawhebtak/core/models/default_model.dart';
import 'package:mawhebtak/core/preferences/preferences.dart';
import 'package:mawhebtak/features/casting/data/model/request_gigs_model.dart';
import 'package:mawhebtak/features/jobs/data/model/user_jop_model.dart';
import 'package:mawhebtak/features/more/data/model/announcement_favourite_model.dart';
import 'package:mawhebtak/features/more/data/model/setting_model.dart';

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
  Future<Either<Failure, RequestGigsModel>> getMyEventData() async {
    try {
      var response = await api.get(EndPoints.getMyEventUrl);
      return Right(RequestGigsModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }
  Future<Either<Failure, AnnouncementFavouriteModel>>
      announcementFavourite() async {
    try {
      var response = await api.get(EndPoints.favouritesUrl, queryParameters: {
        'favouriteable_type': 'Announce',
      });
      return Right(AnnouncementFavouriteModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, UserJobModel>> userJobFavourite() async {
    try {
      var response = await api.get(EndPoints.favouritesUrl, queryParameters: {
        'favouriteable_type': 'UserJob',
      });
      return Right(UserJobModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, DefaultMainModel>> changePassword({
    required String oldPassword,
    required String newPassword,
  }) async {
    try {
      var response = await api.post(EndPoints.changePasswordUrl, body: {
        'key': 'changePassword',
        'old_password': oldPassword,
        'new_password': newPassword,
      });
      return Right(DefaultMainModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, DefaultMainModel>> logout() async {
    try {
      final deviceToken = await Preferences.instance.getDeviceToken();
      var response = await api.post(EndPoints.logoutUrl, body: {
        'key': 'logout',
        'device_token': deviceToken,
      });
      print('5555555555555555$deviceToken');
      return Right(DefaultMainModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, DefaultMainModel>> deleteAccount() async {
    try {
      var response = await api.get(EndPoints.toggleDeleteAccount);
      return Right(DefaultMainModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, DefaultMainModel>> contactUs(
      {required String message,
      required String subject,
      required String type,
      required String phone}) async {
    try {
      final user = await Preferences.instance.getUserModel();
      var response = await api.post(EndPoints.storeDataUrl, body: {
        'model': 'ContactUs',
        'user_id': user.data?.id,
        'message': message,
        'subject': subject,
        'type': type,
        'phone': phone,
      });
      return Right(DefaultMainModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
