import 'package:easy_localization/easy_localization.dart';

import '../../../../config/routes/app_routes.dart';
import '../../../../core/exports.dart';

class CustomApplyButton extends StatelessWidget {
  const CustomApplyButton({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, Routes.applyEvent);
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
