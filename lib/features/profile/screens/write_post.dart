import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mawhebtak/core/widgets/custom_container_with_shadow.dart';
import 'package:mawhebtak/core/widgets/custom_text_form_field.dart';
import 'package:mawhebtak/features/home/screens/widgets/follow_button.dart';
import 'package:mawhebtak/features/profile/cubit/profile_cubit.dart';

import '../../../core/exports.dart';
import '../../events/screens/widgets/custom_apply_app_bar.dart';

class WritePost extends StatelessWidget {
  const WritePost({super.key});

  @override
  Widget build(BuildContext context) {
   return  BlocBuilder<ProfileCubit,ProfileState>(
     builder: (BuildContext context, state) {
       return
         Scaffold(body:
   Column(children: [
     //app bar
     CustomAppBarWithClearWidget(title:  "share_post".tr(),),
     //body
     Padding(
       padding:  EdgeInsets.only(top: 10.0.h,left: 20.w,right: 20.w),
       child: Column(children: [
         Row(
           crossAxisAlignment: CrossAxisAlignment.center,
           children: [
             SizedBox(
               height: 40.h,
               width: 40.w,
               child: Image.asset(ImageAssets.profileImage),
             ),
             SizedBox(width: 8.w),
             Column(
               crossAxisAlignment: CrossAxisAlignment.center,
               mainAxisAlignment: MainAxisAlignment.center,
               children: [
                 AutoSizeText("Ahmed Mokhtar", style: getMediumStyle(fontSize: 16.sp)),
               ],
             ),

           ],
         ),
         5.verticalSpace,
         //text fiels
         CustomTextField(

           //  controller: cubit.emailController,
           hintText: "what_do_you_want_to_write".tr(),
           maxLines: 6,
           isMessage: true,
         ),
//upload photo
         SizedBox(height: getHeightSize(context)/25),
         CustomContainerWithShadow(child: Padding(
           padding:  EdgeInsets.all(20.0.w),
           child: Row(
             crossAxisAlignment: CrossAxisAlignment.start,
             mainAxisAlignment: MainAxisAlignment.start,
             children: [
               SvgPicture.asset(AppIcons.photoIcon),
               SizedBox(width: 10.w,),
               Text("upload_video".tr(),style: getMediumStyle(fontSize: 14.sp),),
             ],),
         ),),
         SizedBox(height: 20.h,),
         CustomContainerWithShadow(child: Padding(
           padding:  EdgeInsets.all(20.0.w),
           child: Row(
             crossAxisAlignment: CrossAxisAlignment.center,
             mainAxisAlignment: MainAxisAlignment.start,
             children: [
               SvgPicture.asset(AppIcons.videoUploadIcon),
               SizedBox(width: 10.w,),
               Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 mainAxisAlignment: MainAxisAlignment.start,
                 children: [
                   Text("upload_video".tr(),style: getMediumStyle(fontSize: 14.sp),),
                   Text("The video should be max 4 MB".tr(),style: getRegularStyle(fontSize: 14.sp,color: AppColors.grayAfaf),),
                 ],
               ),
             ],),

         ),),
         SizedBox(height: getHeightSize(context)/25),
         CustomContainerButton(title: "post".tr(),color: AppColors.primary,height: 48.h,)
       ],),
     )

   ],),); },);
  }
}
