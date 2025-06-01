import 'package:mawhebtak/core/exports.dart';
import 'package:mawhebtak/core/preferences/preferences.dart';

import '../../config/routes/app_routes.dart';

checkLogin(BuildContext context) async {
  final user = await Preferences.instance.getUserModel();
  if (user.data?.token == null) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("alert".tr()),
        content: Text("must_login".tr()),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context)
                  .pushNamedAndRemoveUntil(Routes.loginRoute, (route) => false);
            },
            child: Text("login".tr()),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text("cancel".tr()),
          ),
        ],
      ),
    );
  }
}
