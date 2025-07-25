import 'package:mawhebtak/core/exports.dart';
import 'package:mawhebtak/core/utils/widget_from_application.dart';
import 'package:mawhebtak/features/auth/new_account/cubit/new_account_cubit.dart';
import 'package:mawhebtak/features/auth/verification/data/repos/verification.repo.dart';
import 'package:mawhebtak/features/calender/data/model/countries_model.dart';
import '../../../../config/routes/app_routes.dart';
import 'verification_state.dart';

class VerificationCubit extends Cubit<VerificationState> {
  VerificationCubit(this.api) : super(VerificationInitial());
  VerificationRepo api;
  String? correctOTP = "";
  DateTime? timerDate;
  TextEditingController pinController = TextEditingController();

  void resetTimerAndOTP() {
    timerDate = null;
    correctOTP = '';
    emit(VerificationStateUpdated());
  }

  validateOTP(bool isRegister, BuildContext context) {
    if (pinController.text != correctOTP) {
      emit(state.copyWith(errorMessage: "Invalid Code, Enter Correct One"));
      errorGetBar('Invalid Code, Enter Correct One');
    } else {
      if (isRegister) {
        context.read<NewAccountCubit>().register(context);
      } else {
        Navigator.pushNamed(context, Routes.newPasswordRoute);
      }
      emit(state.copyWith(errorMessage: null));
      timerDate = null;
    }
  }

  void clearError() {
    emit(state.copyWith(errorMessage: null));
  }

  validateData(
    BuildContext context, {
    required String email,
    required String countryCode,
    required String name,
    required String password,
    required List<GetCountriesMainModelData> selectedUserSubType,
  }) async {
    AppWidgets.create2ProgressDialog(context);
    emit(ValidateDataStateLoading());

    try {
      final newAccountCubit = context.read<NewAccountCubit>();

      String fullPhone = newAccountCubit.fullPhoneFromWidget ??
          '${newAccountCubit.countryCode}${newAccountCubit.mobileNumberController.text.trim()}';
      final res = await api.validateData(
        countryCode: countryCode,
        selectedUserSubType: selectedUserSubType,
        email: email,
        name: name,
        password: password,
        phone: fullPhone, // هنا التغيير المهم
      );

      res.fold((l) {
        emit(ValidateDataStateError());
      }, (r) {
        if (r.status == 200) {
          Navigator.pop(context);
          Navigator.pushNamed(context, Routes.verificationRoute,
              arguments: true);
          correctOTP = r.data?.otp.toString();
          timerDate = r.data?.otpExpired;
          emit(ValidateDataStateLoaded());
        } else {
          errorGetBar(r.msg ?? '');
          Navigator.pop(context);
          emit(ValidateDataStateError());
        }
      });
    } catch (e) {
      emit(ValidateDataStateError());
      return null;
    }
  }
}
