import 'package:flutter_svg/svg.dart';
import 'package:mawhebtak/core/widgets/show_loading_indicator.dart';
import 'package:mawhebtak/features/home/cubits/announcements_cubit/announcements_cubit.dart';
import '../../../config/routes/app_routes.dart';
import '../../../core/exports.dart';
import '../../home/screens/widgets/custom_announcement_widget.dart';

class AnnouncementScreen extends StatefulWidget {
  const AnnouncementScreen({super.key});

  @override
  State<AnnouncementScreen> createState() => _AnnouncementScreenState();
}

class _AnnouncementScreenState extends State<AnnouncementScreen> {
  @override
  initState() {
    context.read<AnnouncementsCubit>().announcementsData(page: '1');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
          Flexible(
            child: BlocBuilder<AnnouncementsCubit, AnnouncementsState>(
                builder: (context, state) {
              var announcementsData =
                  context.read<AnnouncementsCubit>().announcements;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  (state is AnnouncementsStateLoading)
                      ? const Expanded(
                          child: Center(
                            child: CustomLoadingIndicator(),
                          ),
                        )
                      : Expanded(
                          child: Padding(
                          padding: EdgeInsets.only(left: 8.w, right: 8.w),
                          child: GridView.builder(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 1,
                                    mainAxisSpacing: 8.h,
                                    crossAxisSpacing: 8.w,
                                    childAspectRatio: 0.7),
                            shrinkWrap: true,
                            itemBuilder: (context, index) =>
                                CustomAnnouncementWidget(
                              announcement: announcementsData?.data?[index],
                              isLeftPadding: index == 0 ? true : false,
                              isRightPadding: index ==
                                      (announcementsData?.data?.length ?? 1) - 1
                                  ? true
                                  : false,
                            ),
                            itemCount: announcementsData?.data?.length ?? 0,
                          ),
                        )),
                  if (state is AnnouncementsStateLoadingMore)
                    const CustomLoadingIndicator(),
                ],
              );
            }),
          ),
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
  }
}
