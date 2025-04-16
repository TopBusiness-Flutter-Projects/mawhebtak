import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mawhebtak/core/widgets/custom_button.dart';
import 'package:mawhebtak/features/home/screens/widgets/follow_button.dart';

import '../../../core/exports.dart';

class ApplyForEvent extends StatelessWidget {
  const ApplyForEvent({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light.copyWith(
        statusBarColor: Colors.transparent, // الشفافية
        statusBarIconBrightness: Brightness.light, // لون الأيقونات (أبيض)
      ),
      child: Scaffold(
backgroundColor: AppColors.white,

        body:
        Column(children: [
         // SizedBox(height: getHeightSize(context)/40,),
          //app bar
          Container(
          //  height:  getHeightSize(context)/30,
            color: AppColors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: getHeightSize(context)/100,),

                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                Padding(
                padding: const EdgeInsets.all(8.0),
                  child: Text("Apply for event"),
                ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SvgPicture.asset(AppIcons.xIcon),
                    ),
                  ],
                ),
                SizedBox(height: getHeightSize(context)/80,),
              ],
            ),
          ),
          SizedBox(height: getHeightSize(context)/20,),
          //container pick
          Container(
            color: AppColors.grayLite,
              width: double.infinity,
              height: getHeightSize(context)/3.5,
              child:Column(children: [ 
                Image.asset(ImageAssets.imagePicked),
                SizedBox(width: 239.w,
                  height: 30.h,
                  child:
                CustomContainerButton(title: "add_photo_video".tr(),color: AppColors.blueveryLight,textColor: AppColors.primary,),
                  )
              ],))
        ],),
      ),
    );
  }
}
