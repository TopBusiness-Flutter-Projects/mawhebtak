import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/services.dart';
import 'package:mawhebtak/features/events/screens/widgets/custom_apply_button.dart';
import 'package:mawhebtak/features/events/screens/widgets/custom_event_details_widget.dart';
import 'package:mawhebtak/features/events/screens/widgets/custom_row_event.dart';
import '../../../config/routes/app_routes.dart';
import '../../../core/exports.dart';


class DetailsEventScreen extends StatelessWidget {
  const DetailsEventScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light.copyWith(
          statusBarColor: Colors.transparent, // الشفافية
          statusBarIconBrightness: Brightness.light, // لون الأيقونات (أبيض)
        ),child:
      Scaffold(
      //backgroundColor: AppColors.grayDark,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
        
          CustomEventDetailsWidget(onTap: (){

              Navigator.pushNamed(context, Routes.secondDetailsSecond);

          },),
        //
        Padding(
          padding:  EdgeInsets.symmetric(horizontal: 20.0.w,vertical: 16.h),
          child: Text('events_details'.tr(),style: getMediumStyle(fontSize: 14.sp,color: AppColors.darkGray),),
        ),
            const CustomRowEvent(text: 'location', text2: 'Egypt, Cairo',),
            const CustomRowEvent(text: 'type', text2: 'Egypt, Cairo',isSecound: true,),
            const CustomRowEvent(text: 'privacy', text2: 'Egypt, Cairo',),
            const CustomRowEvent(text: 'event_date', text2: 'Egypt, Cairo',isSecound: true,),
            const CustomRowEvent(text: 'Description', text2: '',),
            Padding(
              padding:  EdgeInsets.symmetric(horizontal: 20.0.w,vertical: 10.h),
              child: Text('Mawahbtak big platform connects all artists in all fields to make large community bettwen artists in Egypt.'.tr(),style: getRegularStyle(fontSize: 13.sp,color: AppColors.darkGray),),
            ),
            Padding(
              padding:  EdgeInsets.symmetric(horizontal: 20.0.w,vertical: 16.h),
              child: Text('Required Talents'.tr(),style: getMediumStyle(fontSize: 14.sp,color: AppColors.darkGray),),
            ),
            const CustomRowEvent(text: 'location', text2: '3000 L.E',isRequiredTalent: true,),
            const CustomRowEvent(text: 'type', text2: '3000 L.E',isSecound: true,isRequiredTalent: true,),
            const CustomRowEvent(text: 'location', text2: '3000 L.E',isRequiredTalent: true),
            const CustomRowEvent(text: 'location', text2: '3000 L.E',isSecound: true,isRequiredTalent: true),
            const CustomRowEvent(text: 'location', text2: '3000 L.E',isRequiredTalent: true),
            SizedBox(height: 5.h,),
            //
            CustomApplyButton(),
            SizedBox(height: 20.h,)
          ],),
      ),
    ));
  }
}
