import 'package:mawhebtak/config/routes/app_routes.dart';
import 'package:mawhebtak/core/exports.dart';
import 'package:mawhebtak/core/preferences/preferences.dart';
import 'package:mawhebtak/core/utils/widget_from_application.dart';
import 'package:mawhebtak/features/auth/login/data/models/login_model.dart';
import 'package:mawhebtak/features/more_screen/cubit/more_state.dart';
import 'package:mawhebtak/features/more_screen/data/model/setting_model.dart';
import 'package:mawhebtak/features/more_screen/data/repos/more.repo.dart';

class MoreCubit extends Cubit<MoreState> {
  MoreCubit(this.api) : super(MoreInitial());
  MoreRepo api;

  TextEditingController messageController = TextEditingController();
  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
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

  saveData() {
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

  contactUs(
      {required bool isComplaining, required BuildContext context}) async {
    AppWidgets.create2ProgressDialog(context);
    emit(ContactUsStateLoading());
    try {
      final res = await api.contactUs(
        message: messageController.text,
        subject: titleController.text,
        type: isComplaining ? 'complaints' : 'advertisement',
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

  logout({required BuildContext context}) async {
    emit(LogoutStateLoading());
    try {
      final res = await api.logout();
      res.fold((l) {
        emit(LogoutStateError(l.toString()));
      }, (r) {
        if(r.status == 200){
          successGetBar('logout_successfully'.tr());
          Navigator.pushNamed(context, Routes.loginRoute);
        }else{
          errorGetBar(r.errors.toString());
        }
        emit(LogoutStateLoaded());
      });
    } catch (e) {
      emit(LogoutStateError(e.toString()));
    }
  }

  changePassword({required BuildContext context}) async {
    AppWidgets.create2ProgressDialog(context);
    try {
      final res = await api.changePassword(
          oldPassword: oldPasswordController.text,
          newPassword: newPasswordController.text);
      res.fold((l) {
        emit(ChangePasswordStateError(l.toString()));
        Navigator.pop(context);
      }, (r) {
        if(r.status == 200){
          successGetBar('change_password_successfully'.tr());
          emit(ChangePasswordStateLoaded());
          Navigator.pop(context);

        }
        else{
          errorGetBar(r.msg.toString());
          Navigator.pop(context);
        }

      });
    } catch (e) {
      emit(ChangePasswordStateError(e.toString()));
    }
  }
}
