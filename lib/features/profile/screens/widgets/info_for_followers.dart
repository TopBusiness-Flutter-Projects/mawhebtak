import 'package:easy_localization/easy_localization.dart';

import '../../../../config/routes/app_routes.dart';
import '../../../../core/exports.dart';

class InfoForFollowers extends StatelessWidget {
  const InfoForFollowers({super.key});

  @override
  Widget build(BuildContext context) {
    return  Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Column(children: [
          Text("20 K",style: getRegularStyle(fontSize: 14.sp,color: AppColors.green),),
          InkWell(
            onTap: (){
              Navigator.pushNamed(context, Routes.followersScreen);
            },
              child: Text("followers".tr(),style: getUnderLine(fontSize: 14.sp,color: AppColors.green),))
        ],) ,   Column(children: [
          Text("20 K",style: getRegularStyle(fontSize: 14.sp,color: AppColors.green),),
          Text("following".tr(),style: getUnderLine(fontSize: 14.sp,color: AppColors.green),)
        ],) ,   Column(children: [
          Text("20 K",style: getRegularStyle(fontSize: 14.sp,color: AppColors.green),),
          Text("post".tr(),style: getUnderLine(fontSize: 14.sp,color: AppColors.green),)
        ],)],);
  }
}
