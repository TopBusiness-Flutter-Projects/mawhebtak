import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mawhebtak/features/auth/forget_password/cubit/forget_password_state.dart';
import 'package:mawhebtak/features/auth/forget_password/data/repos/forget_password_repo.dart';
import 'package:mawhebtak/features/auth/verification/cubit/verification_cubit.dart';

import '../../../../config/routes/app_routes.dart';
import '../../../../core/utils/dialogs.dart';
import '../../../../core/utils/widget_from_application.dart';

class ForgetPasswordCubit extends Cubit<ForgetPasswordState> {
  ForgetPasswordCubit(this.api) : super(ForgetPasswordInitial());
  ForgetPasswordRepo api;
  TextEditingController emailController = TextEditingController();

  forgetPassword(BuildContext context) async {
    AppWidgets.createProgressDialog(context: context, msg: 'loading'.tr());
    emit(ForgetPasswordStateLoading());
    try {
      final res = await api.forgetPassword(
        emailController.text,
      );
      res.fold((l) {
        emit(ForgetPasswordStateError());
      }, (r) {
        if (r.status == 200) {
          Navigator.pop(context);
          Navigator.pushNamed(context, Routes.verificationRoute,
              arguments: false);
          context.read<VerificationCubit>().correctOTP = r.data?.otp.toString();

          emit(ForgetPasswordStateLoaded());
        } else {
          errorGetBar(r.msg ?? '');
          Navigator.pop(context);
          emit(ForgetPasswordStateError());
        }
      });
    } catch (e) {
      emit(ForgetPasswordStateError());

      return null;
    }
    //!
  }
}
