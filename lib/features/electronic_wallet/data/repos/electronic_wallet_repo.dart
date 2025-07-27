import 'package:mawhebtak/core/models/default_model.dart';
import 'package:mawhebtak/features/electronic_wallet/data/models/get_wallet_transaction_model.dart';
import '../../../../core/exports.dart';
import '../models/paymob-pay_model.dart';

class ElectronicWalletRepo {
  BaseApiConsumer dio;
  ElectronicWalletRepo(this.dio);

  Future<Either<Failure, PaymobPayModel>> paymobPay({
    required String price,
  }) async {
    try {
      final response =
          await dio.post(EndPoints.paymobPayUrl, body: {'price': price});

      return Right(PaymobPayModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, DefaultMainModel>> paymentCallBack(
      {required String orderId}) async {
    try {
      final response = await dio.post(EndPoints.paymobCallbackUrl, body: {
        'orderId': orderId,
      });

      return Right(DefaultMainModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, DefaultMainModel>> requestWithdraw({
    required String paymentMethod,
    required String amount,
    required String paymentKey,
  }) async {
    try {
      final response = await dio.post(EndPoints.requestWithdrawUrl, body: {
        "payment_method": paymentMethod,
        "amount": amount,
        "payment_key": paymentKey,
      });

      return Right(DefaultMainModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, GetWalletTransactionModel>>
      getWalletTransaction() async {
    try {
      final response = await dio.get(
        EndPoints.getMyTransactionUrl,
      );

      return Right(GetWalletTransactionModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
