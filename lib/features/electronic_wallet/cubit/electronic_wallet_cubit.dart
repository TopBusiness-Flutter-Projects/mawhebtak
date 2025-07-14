import 'dart:developer';

import 'package:mawhebtak/core/exports.dart';
import 'package:mawhebtak/core/models/default_model.dart';
import 'package:mawhebtak/core/preferences/preferences.dart';
import 'package:mawhebtak/core/utils/widget_from_application.dart';
import 'package:mawhebtak/features/electronic_wallet/cubit/electronic_wallet_state.dart';
import 'package:mawhebtak/features/electronic_wallet/data/models/get_wallet_transaction_model.dart';
import 'package:mawhebtak/features/electronic_wallet/data/repos/electronic_wallet_repo.dart';
import '../data/models/paymob-pay_model.dart';
import '../screens/payment.dart';

class ElectronicWalletCubit extends Cubit<ElectronicWalletState> {
  ElectronicWalletCubit(this.electronicWalletRepo)
      : super(ElectronicWalletInitial());
  ElectronicWalletRepo electronicWalletRepo;
  TextEditingController amountController = TextEditingController();
  TextEditingController paymentKeyController = TextEditingController();
  TextEditingController paymentMethodController = TextEditingController();
  TextEditingController priceController = TextEditingController();

  PaymobPayModel? paymobPayModel;
  Future<void> paymobPay(BuildContext context) async {
    AppWidgets.create2ProgressDialog(context);
    try {
      emit(LoadingPaymobPayDataState());
      final res =
          await electronicWalletRepo.paymobPay(price: priceController.text);
      res.fold((l) {
        Navigator.pop(context);

        emit(ErrorPaymobPayDataState());
      }, (r) {
        paymobPayModel = r;
        priceController.clear();

        Navigator.pop(context);

        if (r.success == true) {
          Navigator.pop(context);

          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return PaymentWebViewScreen(url: r.paymentUrl);
          }));
        } else {
//

          errorGetBar('valid_phone'.tr());
        }
        emit(LoadedPaymobPayDataState());
      });
    } catch (e) {
      errorGetBar(e.toString());
      Navigator.pop(context);
    }
  }

  Future<void> paymentCallBack(BuildContext context) async {
    emit(LoadingPaymentCallBackDataState());
    final res = await electronicWalletRepo.paymentCallBack(
        orderId: paymobPayModel?.orderId.toString() ?? "");
    res.fold((l) {
      emit(ErrorPaymentCallBackDataState());
    }, (r) {
      if (r.status == 200) {
        Navigator.pop(context);
        successGetBar(r.msg.toString());
        getWalletTransactionData();
      } else {
        errorGetBar(r.msg.toString());
      }
      emit(LoadedPaymentCallBackDataState());
    });
  }

  DefaultMainModel? defaultMainModel;
  Future<void> requestWithdraw() async {
    emit(LoadingRequestWithdrawDataState());
    final res = await electronicWalletRepo.requestWithdraw(
      amount: amountController.text,
      paymentKey: paymentKeyController.text,
      paymentMethod: paymentMethodController.text,
    );

    res.fold((l) {
      emit(ErrorRequestWithdrawDataState());
    }, (r) {
      defaultMainModel = r;
      successGetBar(r.msg ?? "");
      amountController.clear();
      paymentKeyController.clear();
      paymentMethodController.clear();
      emit(LoadedRequestWithdrawDataState());
    });
  }

  GetWalletTransactionModel? getWalletTransactionModel;
  Future<void> getWalletTransactionData() async {
    emit(LoadingGetWalletTransactionDataState());
    final res = await electronicWalletRepo.getWalletTransaction();

    res.fold((l) {
      emit(ErrorGetWalletTransactionDataState());
    }, (r) {
      getWalletTransactionModel = r;

      emit(LoadedGetWalletTransactionDataState());
    });
  }
}
