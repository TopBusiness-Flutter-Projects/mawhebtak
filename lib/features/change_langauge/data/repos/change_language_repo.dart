import '../../../../core/exports.dart';
import '../../../../core/models/default_model.dart';

class ChangeLanguageRepo {
  BaseApiConsumer api;
  ChangeLanguageRepo(this.api);

  Future<Either<Failure, DefaultMainModel>> toggleLanguage(
      {String? language}) async {
    try {
      var response = await api.post(EndPoints.toggleLanguage, body: {
        'key': 'toggleLanguage',
        'language': language ?? 'ar',
      });
      return Right(DefaultMainModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
