import 'package:easy_localization/easy_localization.dart';

import '../../../../../config/routes/app_routes.dart';
import '../../../../../core/exports.dart';

class WhatDoYouWant extends StatelessWidget {
  const WhatDoYouWant({super.key});

  @override
  Widget build(BuildContext context) {
    return
    InkWell(
      onTap: (){
        Navigator.pushNamed(context, Routes.writePostScreen);
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
                  fontSize: 14.sp,
                  color: AppColors.grayMedium,
                ),
              ),
              SizedBox(
                child: Icon(
                  Icons.arrow_right,
                  color: AppColors.primary,
                  size: 24.sp,
                ),
              ),
            ],
                    ),
                  ),
          ),
        SizedBox(height: 8.h,),
        Container(
          height: 8.h,
          color: AppColors.grayLite,
        ),
        SizedBox(height: 10.h),]
        ,),
    );
  }
}
