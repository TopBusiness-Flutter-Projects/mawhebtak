import 'package:easy_localization/easy_localization.dart';
import 'package:mawhebtak/features/events/cubit/event_cubit.dart';
import '../exports.dart';
import '../../features/home/screens/widgets/follow_button.dart';

class CustomPickMediaWidget extends StatelessWidget {
  const CustomPickMediaWidget({super.key, required this.onTap});
  final Function ()onTap;
  @override
  Widget build(BuildContext context) {
    var cubit=context.read<EventCubit>();
   return  BlocBuilder<EventCubit,EventState>
     (builder: (BuildContext context, state) {
     return Container(
     color: AppColors.grayLite,
     width: double.infinity,
     child: Column(
       children: [
         SizedBox(height: 10.h),
         if (cubit.selectedImage != null)
           Image.file(cubit.selectedImage!, height: 150.h, fit: BoxFit.fill)
         else if (cubit.selectedVideo != null)
           Icon(Icons.videocam, size: 100.sp, color: AppColors.primary)
         else
           Image.asset(ImageAssets.imagePicked, height: 150.h),

         SizedBox(height: 10.h),
         SizedBox(
           width: 239.w,
           height: 30.h,
           child: GestureDetector(
             onTap: onTap,
             child: CustomContainerButton(
               title: "add_photo_video".tr(),
               color: AppColors.blueveryLight,
               textColor: AppColors.primary,
             ),
           ),
         ),
         10.verticalSpace
       ],
     ),
   ); },)
    ;
  }
}
