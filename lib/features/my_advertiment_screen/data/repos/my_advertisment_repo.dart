
import 'package:mawhebtak/core/exports.dart';
import 'package:mawhebtak/core/preferences/preferences.dart';
import '../models/user_package_model.dart';

class MyAdvertismentRepo {
  BaseApiConsumer dio;
  MyAdvertismentRepo(this.dio);

  // // الاشتراكات
  Future<Either<Failure, UserPackageModel>>
  getUserPackageData() async {
    final userModel = await Preferences.instance.getUserModel();
    try {
      final response = await dio.get(
        EndPoints.getDataBaseUrl,
        queryParameters: {
          'model':'UserPackage',
          'where[0]':'status,1',
          "where[1]": "user_id,${userModel.data?.id?.toString()}",
        }
      );
      return Right(UserPackageModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  // // تفاصيل الاشتراك
  //
  // Future<Either<Failure, GetLawyerPackageAdsModel>> getLawyerPackageAdsDetails(
  //     {required String idFromPackage}) async {
  //   try {
  //     final response = await dio.get(
  //       EndPoints.getLawyerPackageAdsUrl + idFromPackage,
  //     );
  //     return Right(GetLawyerPackageAdsModel.fromJson(response));
  //   } on ServerException {
  //     return Left(ServerFailure());
  //   }
  // }
  //
  // // اضافة اعلان
  // Future<Either<Failure, DefaultMainModel>> addAdsToLawyerPackage(
  //     {required String id,
  //     required String fromDate,
  //     required String toDate,
  //     required File image}) async {
  //   try {
  //     final response = await dio.post(EndPoints.addAdsToLawyerPackageUrl,
  //         formDataIsEnabled: true,
  //         body: {
  //           'id': id,
  //           'from_date': fromDate,
  //           'to_date': toDate,
  //           'image': MultipartFile.fromFileSync(image.path,
  //               filename: image.path.split('/').last),
  //         });
  //     return Right(DefaultMainModel.fromJson(response));
  //   } on ServerException {
  //     return Left(ServerFailure());
  //   }
  // }
}
