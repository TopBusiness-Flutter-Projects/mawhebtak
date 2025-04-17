
import 'package:flutter_svg/svg.dart';

import '../exports.dart';

class CustomSimpleAppbar extends StatelessWidget {
  const CustomSimpleAppbar({super.key, this.actionIcon,required this.title, this.isActionButton,this.colorButton,this.color,this.titleColor});
final String title;
final bool ?isActionButton;
final Color ?color;
final Color ?titleColor;
final Color ?colorButton;
final String ?actionIcon;
  @override
  Widget build(BuildContext context) {
    return
      Container(
      height: getSize(context)/6,
      decoration: BoxDecoration(color: color??AppColors.white, boxShadow: [
        BoxShadow(
          color:color?? AppColors.grayLite,
          blurStyle: BlurStyle.inner,
         // offset: const Offset(0, 1),
        )
      ]),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Padding(
              padding:  EdgeInsets.only(left: 10.w,right: 10.w),
              child: Container(
                decoration: BoxDecoration(
                    color: colorButton??AppColors.grayLite,
                    borderRadius: BorderRadius.circular(8.r)),
                padding: EdgeInsets.only(left: 5.w, right: 5.w,bottom: 5.h,top: 5.h),
                child:  Padding(
                  padding:  EdgeInsets.all(6.r),
                  child: Icon(
                    Icons.arrow_back,
                    color: AppColors.darkGray,
                    size: 16.sp,),
                ),
              ),
            ),
          ),
          Expanded(
            child: Text(
              textAlign: TextAlign.center,
              title,
              style: TextStyle(fontSize: 16.sp, color: titleColor??AppColors.black),
            ),
          ),
          if(isActionButton??false)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SvgPicture.asset(actionIcon??AppIcons.eventIcon),
            )        ],
      ),
    );
  }
}
