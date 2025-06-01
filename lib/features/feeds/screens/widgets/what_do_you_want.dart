import 'package:mawhebtak/core/utils/check_login.dart';
import '../../../../config/routes/app_routes.dart';
import '../../../../core/exports.dart';
import '../../../../core/preferences/preferences.dart';

class WhatDoYouWant extends StatelessWidget {
  const WhatDoYouWant({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        final user = await Preferences.instance.getUserModel();
        if (user.data?.token == null) {
          checkLogin(context);
        } else {
          Navigator.pushNamed(context, Routes.writePostScreen);
        }
      },
      child: Column(
        children: [
          Container(
            color: AppColors.white,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'what_do_you_want_to_write'.tr(),
                    style: getRegularStyle(
                      fontSize: 18.sp,
                      color: AppColors.grayMedium,
                    ),
                  ),
                  SizedBox(
                    child: Icon(
                      Icons.arrow_right,
                      color: AppColors.primary,
                      size: 30.sp,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 8.h,
          ),
          Container(
            height: 8.h,
            color: AppColors.grayLite,
          ),
          SizedBox(height: 10.h),
        ],
      ),
    );
  }
}
