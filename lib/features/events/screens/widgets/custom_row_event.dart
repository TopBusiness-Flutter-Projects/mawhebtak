import 'package:easy_localization/easy_localization.dart';

import '../../../../core/exports.dart';

class CustomRowEvent extends StatelessWidget {
  const CustomRowEvent({super.key,required this.text,required this.text2,this.isSecound,this.isRequiredTalent});
final String text;
final String text2;
final bool?isSecound;
final bool?isRequiredTalent;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: isSecound??false?AppColors.grayLite2:AppColors.white,
      child: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 20.0.w,vertical: 6.h),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(text.tr(),style: getRegularStyle(fontSize: 14.sp,color:isRequiredTalent??false?AppColors.primary: AppColors.grayText2),),
            Text(text2,style: getRegularStyle(fontSize: 13.sp,color: isRequiredTalent??false?AppColors.green:AppColors.black))
          ],),
      ),
    );
  }
}
