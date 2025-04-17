import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:mawhebtak/features/profile/cubit/profile_cubit.dart';

import '../../../../core/exports.dart';
import '../../../../core/widgets/custom_container_with_shadow.dart';
import '../../../home/screens/widgets/follow_button.dart';

class FollowersWidget extends StatelessWidget {
  const FollowersWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit=context.read<ProfileCubit>();
   return BlocBuilder<ProfileCubit,ProfileState>(builder: (BuildContext context, state) {
     return  Padding(
     padding: const EdgeInsets.all(8.0),
     child: CustomContainerWithShadow(
       reduis: 8.r,
       child: Padding(
         padding: const EdgeInsets.all(8.0),
         child: Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           crossAxisAlignment: CrossAxisAlignment.start,
           children: [

             Row(
               crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                 SizedBox(
                   height: 40.h,
                   width: 40.w,
                   child: Image.asset(ImageAssets.profileImage),
                 ),
                 SizedBox(width: 8.w),
                 Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                     AutoSizeText("Ahmed Mokhtar", style: getMediumStyle(fontSize: 16.sp)),
                     AutoSizeText(
                       "Talent / Actor Expert",
                       style: getRegularStyle(fontSize: 14.sp, color: AppColors.grayLight),
                     ),
                   ],
                 ),
               ],
             ),
             CustomContainerButton(

               onTap: (){
                 cubit.toggleButton();
               },
               textColor: cubit.isFollowing? AppColors.primary:AppColors.white,
               title: cubit.isFollowing?'follow'.tr():"un_follow".tr(),
               borderColor:cubit.isFollowing? AppColors.primary:AppColors.transparent ,
               color:cubit.isFollowing? AppColors.transparent:AppColors.primary,)

           ],
         ),
       ) ,),
   ); },);
  }
}
