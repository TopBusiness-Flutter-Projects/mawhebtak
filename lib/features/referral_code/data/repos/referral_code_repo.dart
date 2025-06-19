import 'package:mawhebtak/core/exports.dart';
import 'package:mawhebtak/core/models/default_model.dart';


class ReferralCodeRepo {
  BaseApiConsumer api;
  ReferralCodeRepo(this.api);

    Future<Either<Failure, DefaultMainModel>> addReferralCode(
      String code) async {
    try {
      var response = await api.post(
        EndPoints.addReferralCodeUrl,
        body: {         
          'referral_code': code,         
        },
      );
      return Right(DefaultMainModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
