import '../../../../../core/exports.dart';

class ExperinceWidget extends StatelessWidget {
  const ExperinceWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(height: 10.h,),
      Padding(
        padding:  EdgeInsets.only(left: 16.0.w,right: 16.w),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset(ImageAssets.experience),
            SizedBox(width: 5.w,),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("Al King Film",style: getMediumStyle(fontSize: 13.sp),),
                  Text("November 2021 Till June 2022",style: getRegularStyle(color: AppColors.grayMedium,fontSize: 14.sp),),
                  Text(
                    "Mawahbtak big platform connects all artists in all fields to make large community bettwen artists in Egypt",
                    style:
                    getRegularStyle(
                      color: AppColors.grayText3,
                      fontSize: 14.sp,

                    ),),
                ],
              ),
            )
          ],),

      ),
      SizedBox(height: 4.h,),

      Container(height: 2.h,color: AppColors.grayLite,width: double.infinity,),
    ],);
  }
}
