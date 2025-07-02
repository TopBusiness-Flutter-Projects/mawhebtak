
import 'package:mawhebtak/core/exports.dart';
import 'package:mawhebtak/core/preferences/preferences.dart';
import 'package:mawhebtak/features/electronic_wallet/cubit/electronic_wallet_state.dart';
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
    emit(LoadingPaymobPayDataState());
    final res = await electronicWalletRepo.paymobPay(
        price: priceController.text);
    res.fold((l) {
      emit(ErrorPaymobPayDataState());
    }, (r) {
      paymobPayModel = r;
      priceController.clear();
      if (r.success == true) {
        Navigator.pop(context);
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return PaymentWebViewScreen(url: r.paymentUrl);
        }));
      } else {
        errorGetBar(r.paymentUrl ?? "");
      }
      emit(LoadedPaymobPayDataState());
    });
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
      } else {
        errorGetBar(r.msg.toString());
      }
      emit(LoadedPaymentCallBackDataState());
    });
  }
}
