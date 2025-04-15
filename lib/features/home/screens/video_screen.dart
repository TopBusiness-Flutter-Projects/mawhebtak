import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/exports.dart';
import '../../../core/widgets/custom_simple_appbar.dart';
import '../cubit/home_cubit.dart';
import '../cubit/home_state.dart';

class VideoScreen extends StatelessWidget {
  const VideoScreen({super.key});

  @override
  Widget build(BuildContext context) {
   return BlocBuilder<HomeCubit, HomeState>(builder: (BuildContext context, state) {  return Scaffold(
     body: Column(
       children: [
         SizedBox(height: 20.h,),
         CustomSimpleAppbar(title: 'new_conference'.tr()),
         Expanded(
           child: Column(
             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
             children: [
               Column(
                 children: [
                   SizedBox(
                     height: 109.h,
                     width: 109.h,
                     child: Image.asset(ImageAssets.videoCallImage),
                   ),
                   SizedBox(height: 8.h),
                   Text("start_new_conference".tr(),style: getMediumStyle(fontSize: 13.sp,color: AppColors.grayDark),),
                 ],
               ),
               Column(
                 children: [
                   SizedBox(
                     height: 109.h,
                     width: 109.h,
                     child: Image.asset(ImageAssets.calenderImage),
                   ),
                   SizedBox(height: 8.h),
                   Text("schedule_conference".tr(),style: getMediumStyle(fontSize: 13.sp,color: AppColors.grayDark)),
                 ],
               ),
             ],
           ),
         ),
       ],
     ),
   ); },);
  }
}
