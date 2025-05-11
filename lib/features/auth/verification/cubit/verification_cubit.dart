import 'package:easy_localization/easy_localization.dart';

import 'package:mawhebtak/core/exports.dart';
import 'package:mawhebtak/core/utils/widget_from_application.dart';
import 'package:mawhebtak/features/auth/new_account/cubit/new_account_cubit.dart';

import 'package:mawhebtak/features/auth/verification/data/repos/verification.repo.dart';

import '../../../../config/routes/app_routes.dart';
import 'verification_state.dart';

class VerificationCubit extends Cubit<VerificationState> {
  VerificationCubit(this.api) : super(VerificationInitial());
  VerificationRepo api;

  String? correctOTP = "";
  TextEditingController pinController = TextEditingController();

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

      // Navigate or do something
    }
  }

  void clearError() {
    emit(state.copyWith(errorMessage: null));
  }

  validateData(
    BuildContext context, {
    required String email,
    required String name,
    required String password,
    required String phone,
    required String userTypeId,
  }) async {
    AppWidgets.createProgressDialog(context: context, msg: 'loading'.tr());
    emit(ValidateDataStateLoading());
    try {
      final res =
          await api.validateData(email, name, password, phone, userTypeId);
      res.fold((l) {
        emit(ValidateDataStateError());
      }, (r) {
        if (r.status == 200) {
          Navigator.pop(context);
          Navigator.pushNamed(context, Routes.verificationRoute,
              arguments: true);
          correctOTP = r.data?.otp.toString();

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
    //!
  }
}
