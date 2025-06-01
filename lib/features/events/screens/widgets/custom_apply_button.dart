import 'package:easy_localization/easy_localization.dart';

import '../../../../config/routes/app_routes.dart';
import '../../../../core/exports.dart';
import '../../../../core/preferences/preferences.dart';
import '../../../../core/utils/check_login.dart';

class CustomApplyButton extends StatelessWidget {
  const CustomApplyButton({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        final user = await Preferences.instance.getUserModel();
        if (user.data?.token == null) {
          checkLogin(context);
        } else {
          Navigator.pushNamed(context, Routes.applyEvent);
        }
      },
      child: Container(
        color: AppColors.primary,
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.all(10.0.h),
          child: Text(
            "apply_for_this_event".tr(),
            textAlign: TextAlign.center,
            style: getMediumStyle(fontSize: 15.sp, color: AppColors.white),
          ),
        ),
      ),
    );
  }
}
