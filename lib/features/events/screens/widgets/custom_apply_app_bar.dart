import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/exports.dart';
import '../../../../core/utils/app_colors.dart';

class CustomApplyAppBar extends StatelessWidget {
  const CustomApplyAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return    Container(
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
                padding: const EdgeInsets.all(10.0),
                child: Text("apply_for_event".tr()),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: InkWell(
                  onTap: (){
                    Navigator.pop(context);
                  },
                    child: SvgPicture.asset(AppIcons.xIcon)),
              ),
            ],
          ),
          SizedBox(height: getHeightSize(context)/80,),
          Container(
            color: AppColors.grayLite,
            width: double.infinity,height: 2.h,)
        ],
      ),);
  }
}
