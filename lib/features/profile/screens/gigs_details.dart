import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:mawhebtak/core/widgets/custom_container_with_shadow.dart';
import 'package:mawhebtak/core/widgets/custom_simple_appbar.dart';
import 'package:mawhebtak/features/home/screens/widgets/follow_button.dart';
import 'package:mawhebtak/features/profile/screens/widgets/my_gigs/requst_gigs_request.dart';

import '../../../core/exports.dart';
import '../../casting/screens/widgets/gigs_widgets.dart';

class GigsDetailsScreen extends StatelessWidget {
  const GigsDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body:
    SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [

        CustomSimpleAppbar(title: "gig_details".tr()),
        SizedBox(height: 15.h,),
        //gigs widget
        GigsWidget(),
        SizedBox(height: 10.h,),
        //gig requests
        Column(
        crossAxisAlignment: CrossAxisAlignment.start,
          children: [
        Padding(
          padding:  EdgeInsets.only(left: 20.0.w),
          child: Text("gig_requests".tr(),style: getMediumStyle(fontSize: 14.sp,color: AppColors.darkGray),),
        ),
            SizedBox(height: 1.h,),
            //list of requests
            ListView.separated(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
               itemCount: 5,
              itemBuilder: (BuildContext context, int index) {
              return RequstGigsRequest() ;
              },
              separatorBuilder: (BuildContext context, int index) {
              return SizedBox(height: 10.h,);
              },)
      
      
          ],)
      
      ],),
    ),);
  }
}
