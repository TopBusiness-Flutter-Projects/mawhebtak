
import 'package:mawhebtak/core/models/default_model.dart';

import '../../../../../core/exports.dart';
import '../model/package_model.dart';

class PackagesRepo {
  BaseApiConsumer dio;
  PackagesRepo(this.dio);

  //! getAdOfferPackagesUrl
  Future<Either<Failure, PackagesModel>> getPackagesData() async {
    try {
      final response = await dio.get(EndPoints.getDataBaseUrl,

      queryParameters: {
        'model':'Package',
        'where[0]':'status,1',
      }
      );
      return Right(PackagesModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }
  //! Add AdOfferPackageToLawyer
  Future<Either<Failure, DefaultMainModel>> subscribeToPackage({
    required String packageId,

}) async {
    try {
      final response = await dio.post(EndPoints.subscribeToPackageUrl,
      body: {
        "key":"subscribeToPackage",
        "package_id":packageId,
      });
      return Right(DefaultMainModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
