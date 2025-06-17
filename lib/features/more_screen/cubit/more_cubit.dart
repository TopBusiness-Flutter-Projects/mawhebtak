

import 'package:mawhebtak/core/exports.dart';
import 'package:mawhebtak/core/preferences/preferences.dart';
import 'package:mawhebtak/core/utils/widget_from_application.dart';
import 'package:mawhebtak/features/auth/login/data/models/login_model.dart';
import 'package:mawhebtak/features/more_screen/cubit/more_state.dart';
import 'package:mawhebtak/features/more_screen/data/model/setting_model.dart';
import 'package:mawhebtak/features/more_screen/data/repos/more.repo.dart';

class MoreCubit extends Cubit<MoreState> {
  MoreCubit(this.api) : super(MoreInitial());
  MoreRepo api ;
  TextEditingController messageController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  Future<LoginModel> getUserFromPreferences() async {
    final user = await Preferences.instance.getUserModel();
    return user;
  }

  LoginModel? user;
  Future<void> loadUserFromPreferences() async {
    user = await Preferences.instance.getUserModel();
  }

 saveData(){
    phoneNumberController.text = user?.data?.phone ?? "";
 }
  SettingModel? settingModel;
  getSettingData() async {
    emit(GetSettingDataStateLoading());
    try {
      final res = await api.settingData();
      res.fold((l) {
        emit(GetSettingDataStateError(l.toString()));
      }, (r) {
        settingModel = r;
        emit(GetSettingDataStateLoaded());
      });
    } catch (e) {
      emit(GetSettingDataStateError(e.toString()));
    }
  }

  contactUs({required bool isComplaining,required BuildContext context}) async {
    AppWidgets.create2ProgressDialog(context);
    emit(ContactUsStateLoading());
    try {
      final res = await api.contactUs(
          message: messageController.text,
          subject: titleController.text,
          type:isComplaining?'complaints':'advertisement',
          phone: phoneNumberController.text,
      );
      res.fold((l) {
        emit(ContactUsStateError(l.toString()));
        Navigator.pop(context);
      }, (r) {

        emit(ContactUsStateLoaded());
        messageController.clear();
        titleController.clear();
        Navigator.pop(context);

      });
    } catch (e) {
      emit(GetSettingDataStateError(e.toString()));
    }
  }

}
