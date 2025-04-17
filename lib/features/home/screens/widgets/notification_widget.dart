import '../../../../core/exports.dart';
import '../../../../core/widgets/custom_container_with_shadow.dart';

class NotificationWidget extends StatelessWidget {
  const NotificationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return       Padding(
      padding:  EdgeInsets.symmetric(horizontal: 8.0.w),
      child: CustomContainerWithShadow(
          child: Padding(
        padding:  EdgeInsets.all(10.0.w),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
                width:35.w,
                height:35.w,
                child: Image.asset(ImageAssets.notificationImage)),
            SizedBox(width: 10.w,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text("Ahmed Omar cancels the request made direct to you for a job",style: getMediumStyle(fontSize: 14.sp),),
                Text("10 march, 2022",style: getMediumStyle(fontSize: 13.sp,color: AppColors.grayDate),)
              ],)
          ],),
      )),
    )
    ;
  }
}
