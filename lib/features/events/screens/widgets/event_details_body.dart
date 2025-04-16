import 'package:easy_localization/easy_localization.dart';
import 'package:mawhebtak/features/events/screens/widgets/statics_cards.dart';

import '../../../../core/exports.dart';
import 'custom_apply_button.dart';
import 'custom_row_event.dart';

class EventDetailsBody extends StatelessWidget {
  const EventDetailsBody({super.key});

  @override
  Widget build(BuildContext context) {
    return  Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
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
        const CustomRowEvent(text: '', text2: '',isSecound: true,),
        Padding(
          padding:  EdgeInsets.symmetric(horizontal: 20.0.w,vertical: 10.h),
          child: Text('statistics'.tr(),style: getMediumStyle(fontSize: 14.sp,color: AppColors.darkGray),),
        ),
        StaticsCards(),
        SizedBox(height: 10.h,),

        const CustomRowEvent(text: '', text2: '',isSecound: true,),

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
      ],
    );
  }
}
