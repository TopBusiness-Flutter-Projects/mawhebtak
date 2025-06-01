import 'package:flutter_svg/svg.dart';
import '../../../config/routes/app_routes.dart';
import '../../../core/exports.dart';
import '../../casting/cubit/casting_cubit.dart';
import '../../casting/screens/widgets/gigs_widgets.dart';
import '../../home/cubits/request_gigs_cubit/request_gigs_cubit.dart';
import '../../home/screens/widgets/custom_announcement_widget.dart';
import '../cubit/announcement_cubit.dart';

class AnnouncementScreen extends StatelessWidget {
  const AnnouncementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<AnnouncementCubit>();
    return BlocBuilder<AnnouncementCubit, AnnouncementState>(
      builder: (BuildContext context, state) {
        return Scaffold(
          body: Column(
            children: [
              SizedBox(
                height: 20.h,
              ),
              CustomSimpleAppbar(
                  filterType: 'announcments',
                  title: "announcments".tr(),
                  isSearchWidget: true),
              SizedBox(height: 4.h),
            //   SizedBox(
            //   height: 145.w,
            //   child: ListView.builder(
            //     scrollDirection: Axis.horizontal,
            //     physics: const AlwaysScrollableScrollPhysics(),
            //     itemCount: context.read<CastingCubit>().categoryModel?.data?.length ?? 0,
            //     shrinkWrap: true,
            //     itemBuilder: (context, index) {
            //       var gigs = context.read<CastingCubit>().categoryModel?.data?[index];
            //       return Padding(
            //         padding: EdgeInsetsDirectional.only(start: 10.w, end: 10.w),
            //         child: InkWell(
            //           onTap: () {
            //             Navigator.pushNamed(
            //                 context, Routes.detailsOfMainCategoryFromGigsRoute,
            //                 arguments: gigs?.id.toString());
            //           },
            //           child: Container(
            //             decoration: BoxDecoration(
            //               color: AppColors.white,
            //               borderRadius: BorderRadius.circular(16.r),
            //               image: const DecorationImage(
            //                 image: AssetImage(ImageAssets.tasweerPhoto),
            //                 fit: BoxFit.cover,
            //               ),
            //             ),
            //             child: Container(
            //               padding: EdgeInsets.all(8.r),
            //               decoration: BoxDecoration(
            //                 borderRadius: BorderRadius.circular(16.r),
            //                 gradient: LinearGradient(
            //                   colors: [
            //                     Colors.black.withOpacity(0.6),
            //                     Colors.transparent
            //                   ],
            //                   begin: Alignment.bottomCenter,
            //                   end: Alignment.topCenter,
            //                 ),
            //               ),
            //               child: Align(
            //                 alignment: Alignment.bottomLeft,
            //                 child: SizedBox(
            //                   width: 130.w,
            //                   child: Padding(
            //                     padding: EdgeInsets.only(
            //                         bottom: 10.h, left: 10.w, right: 10.w),
            //                     child: Text.rich(
            //                       TextSpan(
            //                         children: [
            //                           WidgetSpan(
            //                             child: Container(
            //                               decoration: BoxDecoration(
            //                                 color: AppColors.secondPrimary,
            //                               ),
            //                               child: Text(
            //                                 (gigs?.name ?? "").substring(
            //                                     0,
            //                                     (gigs?.name?.length ?? 0) >= 5
            //                                         ? 5
            //                                         : (gigs?.name?.length ?? 0)),
            //                                 style: getMediumStyle(
            //                                   color: Colors.white,
            //                                   fontSize: 16.sp,
            //                                 ),
            //                               ),
            //                             ),
            //                           ),
            //                           TextSpan(
            //                             text: (gigs?.name?.length ?? 0) > 5
            //                                 ? (gigs?.name ?? "").substring(5)
            //                                 : "",
            //                             style: getMediumStyle(
            //                               color: AppColors.white,
            //                               fontSize: 16.sp,
            //                             ),
            //                           ),
            //                         ],
            //                       ),
            //                       maxLines: 1,
            //                       overflow: TextOverflow.ellipsis,
            //                     ),
            //                   ),
            //                 ),
            //               ),
            //             ),
            //           ),
            //         ),
            //       );
            //     },
            //   ),
            // ),
              SizedBox(
                  height: 500.h,
                  width: double.infinity,
                  child: CustomAnnouncementWidget(isAnnouncements: true)),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.pushNamed(context, Routes.newAnnouncementScreen);
            },
            backgroundColor: Colors.transparent,
            elevation: 0,
            splashColor: Colors.transparent,
            highlightElevation: 0,
            child: SvgPicture.asset(
              AppIcons.addIcon,
              // width: 56, // نفس مقاس الفلوتينج الأصلي
              // height: 56,
            ),
          ),
        );
      },
    );
  }
}
