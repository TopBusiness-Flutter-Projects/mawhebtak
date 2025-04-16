import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mawhebtak/features/events/screens/widgets/custom_apply_app_bar.dart';
import 'package:mawhebtak/core/utils/custom_pick_media.dart';

import '../../../core/exports.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/widgets/custom_text_form_field.dart';
import '../../home/screens/widgets/follow_button.dart';
import '../cubit/event_cubit.dart';

class ApplyForEvent extends StatefulWidget {
  const ApplyForEvent({super.key});

  @override
  State<ApplyForEvent> createState() => _ApplyForEventState();
}

class _ApplyForEventState extends State<ApplyForEvent> {


  @override
  Widget build(BuildContext context) {
    var cubit = context.read<EventCubit>();

    return BlocBuilder<EventCubit, EventState>(
      builder: (BuildContext context, state) {
        return AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.light.copyWith(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.light,
          ),
          child: Scaffold(
            backgroundColor: AppColors.white,
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomApplyAppBar(),
                SizedBox(height: getHeightSize(context) / 33),

                // الصورة والزر
                CustomPickMediaWidget()
                ,

                // باقي النموذج
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0.w, vertical: 3.h),
                  child: Text(
                    'expected_fees'.tr(),
                    style: getMediumStyle(fontSize: 14.sp, color: AppColors.darkGray),
                  ),
                ),




          Padding(
          padding: EdgeInsets.symmetric(horizontal: 21.0.w),
          child: CustomTextField(
            hintText: "selectedCurrency",
            suffixIcon: Padding(
              padding: EdgeInsets.all(10.0.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(cubit.selectedCurrency, style: getMediumStyle(fontSize: 13.sp, color: AppColors.primary)),
                  Icon(Icons.keyboard_arrow_down_sharp, size: 24.sp),
                ],
              ),
            ),
            onTap: () {
              showModalBottomSheet(
                context: context,
                builder: (context) => Container(
                  padding: EdgeInsets.symmetric(vertical: 20.h),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ListTile(
                        title: Text("L.E (Egyptian Pound)", style: getRegularStyle()),
                        onTap: () {
                         cubit.changeCurency("L.E");

                          Navigator.pop(context);
                        },
                      ),
                      ListTile(
                        title: Text("(\$US)", style: getRegularStyle()),
                        onTap: () {
                          cubit.changeCurency("(\$US)");
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0.w, vertical: 3.h),
                  child: Text(
                    'expected_fees'.tr(),
                    style: getMediumStyle(fontSize: 14.sp, color: AppColors.darkGray),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 21.0.w),
                  child: CustomTextField(
                    hintText: "description_here".tr(),
                    isMessage: true,
                  ),
                ),
                Center(
                  child: CustomContainerButton(
                    title: "apply".tr(),
                    color: AppColors.primary,
                    width: 327.w,
                    height: 48.h,
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
