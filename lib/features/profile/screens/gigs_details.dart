import 'package:easy_localization/easy_localization.dart';
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

        Padding(
          padding:  EdgeInsets.only(top: 20.h,bottom: 15.h),
          child: CustomSimpleAppbar(title: "gig_details".tr()),
        ),
        GigsWidget(),
        SizedBox(height: 10.h,),
        Column(
        crossAxisAlignment: CrossAxisAlignment.start,
          children: [
        Padding(
          padding:  EdgeInsets.only(left: 20.0.w),
          child: Text("gig_requests".tr(),style: getMediumStyle(fontSize: 20.sp,color: AppColors.darkGray),),
        ),
            SizedBox(height: 1.h,),
            //list of requests
            ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
               itemCount: 5,
              itemBuilder: (BuildContext context, int index) {
              return const RequstGigsRequest() ;
              },
              separatorBuilder: (BuildContext context, int index) {
              return SizedBox(height: 10.h,);
              },)
      
      
          ],)
      
      ],),
    ),);
  }
}
