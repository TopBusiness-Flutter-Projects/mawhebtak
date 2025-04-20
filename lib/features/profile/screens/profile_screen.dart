import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mawhebtak/features/profile/cubit/profile_cubit.dart';
import 'package:mawhebtak/features/profile/screens/widgets/about_widgets/about_widget.dart';
import 'package:mawhebtak/features/profile/screens/widgets/info_for_followers.dart';
import 'package:mawhebtak/features/profile/screens/widgets/my_gigs/gigs_widget.dart';
import 'package:mawhebtak/features/profile/screens/widgets/profile_app_bar.dart';
import 'package:mawhebtak/features/profile/screens/widgets/profile_taps.dart';
import 'package:mawhebtak/features/profile/screens/widgets/time_line_widget/time_line_widget.dart';

import '../../../core/exports.dart';
import '../../../core/widgets/custom_simple_appbar.dart';
import '../../casting/screens/widgets/gigs_widgets.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit=context.read<ProfileCubit>();
    return BlocBuilder<ProfileCubit,ProfileState>(
      builder: (BuildContext context, state) {
        return  AnnotatedRegion<SystemUiOverlayStyle>(
            value: SystemUiOverlayStyle.light.copyWith(
            statusBarColor: Colors.transparent, // الشفافية
            statusBarIconBrightness: Brightness.light, // لون الأيقونات (أبيض)
        ),child: Scaffold(body:
    SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ProfileAppBar(),
      SizedBox(height: 35.h,),
      Padding(
        padding:  EdgeInsets.only(left: 16.0.w),
        child: Text("Ahmed Mokhtar",style: getMediumStyle(fontSize: 14.sp,color: AppColors.primary),),
      ),
          Padding(
            padding:  EdgeInsets.only(left: 16.0.w),
            child: RichText(text:
            TextSpan(
                text: "Talent / Actor Expert at studion masr",style: getRegularStyle(fontSize: 14.sp),
              children: <TextSpan>[
                TextSpan(text: '(Amateur)', style: getRegularStyle(fontSize: 14.sp,color: AppColors.primary),),
              ],
            ),
            ),
          ),
          Padding(
            padding:  EdgeInsets.only(left: 16.0.w),
            child: Text("Egypt, Cairo, Nasr City",style: getRegularStyle(fontSize: 14.sp,color: AppColors.grayMedium),),
          ),
          SizedBox(height: 20.h,),
          //info for followers
          InfoForFollowers(),
          SizedBox(height: 5.h,),
          // SizedBox(height: 10.h,),
          Container(height: 8.h,color: AppColors.grayLite,),
          Container(height: 20.h,color: AppColors.white),
          ProfileTabs(),
      SizedBox(height: 5.h,),
      if(cubit.selectedIndex==0)...[
        AboutWidget()
      ]else if(cubit.selectedIndex==1)...[
        TimeLineWidget()
      ]  else if(cubit.selectedIndex==2)...[
        GigsWidget()
      ]else if(cubit.selectedIndex==3)...[
        GigsWidget()
      ]
         // SizedBox(height: 100,)
        ],
      ),
    ),)); },);
  }
}
