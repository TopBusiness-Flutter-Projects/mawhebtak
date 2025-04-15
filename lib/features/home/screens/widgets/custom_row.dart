import 'package:easy_localization/easy_localization.dart';

import '../../../../core/exports.dart';

class CustomRow extends StatelessWidget {
   CustomRow({super.key,required this.text});
String text;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: 16.0.w),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [

          Text(text.tr(),style: getMediumStyle(fontSize: 14.sp,color: AppColors.white),),
          Text("see_all".tr(),style: getUnderLine(fontSize: 14.sp,color: AppColors.lbny),),

        ],),
    );
  }
}
