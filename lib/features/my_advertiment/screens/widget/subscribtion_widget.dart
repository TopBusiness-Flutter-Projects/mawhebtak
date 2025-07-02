// import 'package:ataaby/features/lawyer/my_advertiment_screen/data/models/get_lawyer_package_ads_model.dart';
// import '../../../../../core/exports.dart';
// import '../../../packages/screens/widget/custom_container_package.dart';
//
// class CustomSubscribtionWidget extends StatelessWidget {
//   const CustomSubscribtionWidget({
//     super.key, required this.model,
//   });
//
// final  GetLawyerPackageAdsModelData model;
//   @override
//   Widget build(BuildContext context) {
//     return ContainerOfPackage(
//       height: 125.h,
//       widgetOne: Expanded(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisAlignment: MainAxisAlignment.start,
//               children: [
//                 MySvgWidget(
//                     path: ImageAssets.calendarIcon,
//                     imageColor: AppColors.primary,
//                     size: 25.w),
//                 Padding(
//                   padding: EdgeInsetsDirectional.only(
//                     start: 8.0.w,
//                     bottom: 12.h,
//                   ),
//                   child: Text(
//                     'من : ${model.fromDate}',
//                     maxLines: 1,
//                     style: TextStyle(
//                       fontFamily: AppStrings.fontFamily,
//                       color: AppColors.textGreyColor,
//                       fontWeight: FontWeight.w400,
//                       fontSize: 15.sp,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             Flexible(
//               child: Text(
//                 'باقة شهرية',
//                 maxLines: 1,
//                 style: TextStyle(
//                   fontFamily: AppStrings.fontFamily,
//                   fontWeight: FontWeight.w600,
//                   fontSize: 14.sp,
//                 ),
//               ),
//             ),
//             Text(
//               '5 اعلانات فى الشهر',
//               maxLines: 1,
//               style: TextStyle(
//                 fontFamily: AppStrings.fontFamily,
//                 fontWeight: FontWeight.w600,
//                 fontSize: 14.sp,
//                 color: AppColors.textGreyColor,
//               ),
//             ),
//           ],
//         ),
//       ),
//       widgetTwo: Expanded(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisAlignment: MainAxisAlignment.start,
//               children: [
//                 MySvgWidget(
//                     path: ImageAssets.calendarIcon,
//                     imageColor: AppColors.primary,
//                     size: 25.w),
//                 Padding(
//                   padding: EdgeInsetsDirectional.only(
//                     start: 8.0.w,
//                     bottom: 12.h,
//                   ),
//                   child: Text(
//                     'من : 21/1/2025',
//                     maxLines: 1,
//                     style: TextStyle(
//                       fontFamily: AppStrings.fontFamily,
//                       color: AppColors.textGreyColor,
//                       fontWeight: FontWeight.w400,
//                       fontSize: 15.sp,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             Flexible(
//               child: Text(
//                 'الاعلانات المتبقية',
//                 maxLines: 1,
//                 style: TextStyle(
//                   fontFamily: AppStrings.fontFamily,
//                   fontWeight: FontWeight.w600,
//                   fontSize: 14.sp,
//                 ),
//               ),
//             ),
//             Text(
//               "3 اعلانات",
//               maxLines: 1,
//               style: TextStyle(
//                 fontFamily: AppStrings.fontFamily,
//                 fontWeight: FontWeight.w600,
//                 fontSize: 14.sp,
//                 color: AppColors.textGreyColor,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
