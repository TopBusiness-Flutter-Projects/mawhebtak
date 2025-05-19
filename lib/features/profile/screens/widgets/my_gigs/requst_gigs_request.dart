import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../../../../core/exports.dart';
import '../../../../home/screens/widgets/follow_button.dart';

class RequstGigsRequest extends StatelessWidget {
  const RequstGigsRequest({super.key});

  @override
  Widget build(BuildContext context) {
    return  Container(
      color: AppColors.white,
      child:
      Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 40.h,
                  width: 40.w,
                  child: Image.asset(ImageAssets.profileImage),
                ),
                SizedBox(width: 8.w),
                Expanded  (
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AutoSizeText("Ahmed Mokhtar", style: getMediumStyle(fontSize: 18.sp)),
                          AutoSizeText(
                            "Talent / Actor Expert",
                            style: getRegularStyle(fontSize: 16.sp, color: AppColors.grayLight),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Text("new".tr(),style: getRegularStyle(fontSize: 18.sp,color: AppColors.red),),
                      ),

                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomContainerButton(title: 'accept'.tr(),
                    color: AppColors.primary,

                  ),
                ), Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomContainerButton(title: 'reject'.tr(),
                    color: AppColors.transparent,
                    borderColor: AppColors.red,
                    textColor: AppColors.red,
                  ),
                ),


              ],
            ),
          )

        ],
      ),
    );
  }
}
