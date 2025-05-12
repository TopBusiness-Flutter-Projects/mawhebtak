import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mawhebtak/features/auth/forget_password/cubit/forget_password_cubit.dart';
import 'package:mawhebtak/features/auth/new_password/cubit/new_password_state.dart';
import '../../../../config/routes/app_routes.dart';
import '../../../../core/utils/dialogs.dart';
import '../../../../core/utils/widget_from_application.dart';
import '../data/repos/new_password_repo.dart';

class NewPasswordCubit extends Cubit<NewPasswordState> {
  NewPasswordCubit(this.api) : super(NewPasswordInitial());
  NewPasswordRepo api;
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  resetPassword(BuildContext context) async {
    AppWidgets.createProgressDialog(context: context, msg: 'loading'.tr());
    emit(ResetPasswordStateLoading());
    try {
      final res = await api.resetPassword(
          context.read<ForgetPasswordCubit>().emailController.text,
          passwordController.text,
          confirmPasswordController.text);
      res.fold((l) {
        emit(ResetPasswordStateError());
      }, (r) {
        if (r.status == 200) {
          Navigator.pop(context);
          Navigator.pushNamed(context, Routes.loginRoute, arguments: false);
          passwordController.clear();
          confirmPasswordController.clear();
          successGetBar(r.msg);
          emit(ResetPasswordStateLoaded());
        } else {
          errorGetBar(r.msg ?? '');
          Navigator.pop(context);
          emit(ResetPasswordStateError());
        }
      });
    } catch (e) {
      emit(ResetPasswordStateError());

      return null;
    }
    //!
  }
}
