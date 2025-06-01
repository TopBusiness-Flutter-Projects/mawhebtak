import 'package:mawhebtak/core/exports.dart';
import 'package:mawhebtak/core/preferences/preferences.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import '../../config/routes/app_routes.dart';

checkLogin(BuildContext context) async {
  final user = await Preferences.instance.getUserModel();
  if (user.data?.token == null) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.warning,
      animType: AnimType.bottomSlide,
      title: "alert".tr(),
      desc: "must_login".tr(),
      btnCancelText: "cancel".tr(),
      btnOkText: "login".tr(),
      btnCancelOnPress: () {},
      btnOkOnPress: () {
        Navigator.of(context)
            .pushNamedAndRemoveUntil(Routes.loginRoute, (route) => false);
      },
    ).show();
  }
}
