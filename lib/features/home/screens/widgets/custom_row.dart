import 'package:easy_localization/easy_localization.dart';

import '../../../../core/exports.dart';

class CustomRow extends StatelessWidget {
  const CustomRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [

          Text("top_talents".tr(),style: getMediumStyle(fontSize: 14.sp,color: AppColors.white),),
          Text("see_all".tr(),style: getUnderLine(fontSize: 14.sp,color: AppColors.lbny),),

        ],),
    );
  }
}
