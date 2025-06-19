
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mawhebtak/config/routes/app_routes.dart';
import 'package:mawhebtak/core/utils/dialogs.dart';
import 'package:mawhebtak/core/utils/widget_from_application.dart';
import 'package:mawhebtak/features/referral_code/cubit/referral_code_state.dart';
import '../data/repos/referral_code_repo.dart';


class ReferralCodeCubit extends Cubit<ReferralCodeState> {
  ReferralCodeCubit(this.api) : super(ReferralCodeInitial());
  ReferralCodeRepo api;
   TextEditingController codeController = TextEditingController();
  changeCode(String value) {
    codeController.text = value;
    emit(ChangeCodeState());
  }
  addReferralCode(BuildContext context) async {
    AppWidgets.create2ProgressDialog(context
    );
    emit(AddReferralStateLoading());
    try {
      final res = await api.addReferralCode(
         codeController.text,
      );
      res.fold((l) {
        emit(AddReferralStateError());
      }, (r) {
        if (r.status == 200) {
          Navigator.pop(context);     
          codeController.clear();
          successGetBar(r.msg);
         Navigator.pushNamedAndRemoveUntil(
            context, Routes.mainRoute, (route) => false);
          emit(AddReferralStateLoaded());
        } else {
          errorGetBar(r.msg ?? '');
          Navigator.pop(context);
          emit(AddReferralStateError());
        }
      });
    } catch (e) {
      emit(AddReferralStateError());

      return null;
    }
    //!
  }
}
