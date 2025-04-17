import 'package:flutter_svg/svg.dart';

import '../../../../../core/exports.dart';

class CustomRowSection extends StatelessWidget {
  const CustomRowSection({super.key,required this.title});
final String title;
  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding:  EdgeInsets.only(left: 16.0.w,right: 16.w),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title,
            style: getMediumStyle(fontSize: 14.sp,color: AppColors.darkGray),
          ),
          SvgPicture.asset(AppIcons.bioIcon),
        ],),
    );
  }
}
