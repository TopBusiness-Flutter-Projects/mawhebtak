import 'package:mawhebtak/core/widgets/show_loading_indicator.dart';
import 'package:mawhebtak/features/home/cubits/home_cubit/home_cubit.dart';
import 'package:mawhebtak/features/home/cubits/home_cubit/home_state.dart';
import 'package:mawhebtak/features/home/cubits/top_talents_cubit/top_talents_cubit.dart';
import 'package:mawhebtak/features/home/screens/widgets/custom_announcement_widget.dart';
import 'package:mawhebtak/features/home/screens/widgets/custom_list.dart';
import 'package:mawhebtak/features/home/screens/widgets/custom_row.dart';
import 'package:mawhebtak/features/home/screens/widgets/custom_top_event.dart';
import 'package:mawhebtak/features/home/screens/widgets/custom_top_talents_list.dart';
import 'package:mawhebtak/features/home/screens/widgets/local_video_player.dart';
import 'package:mawhebtak/features/home/screens/widgets/under_custom_row.dart';
import 'package:mawhebtak/features/home/screens/widgets/custom_app_bar_row.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../config/routes/app_routes.dart';
import '../../../core/exports.dart';
import '../../main/cubit/cubit.dart';

class HomeItem {
  final String icon;
  final String label;
  final String title;
  Color? colorIcon;
  HomeItem({
    required this.icon,
    required this.label,
    this.colorIcon,
    required this.title,
  });
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late PageController userController;
  int userCount = 0;

  @override
  void initState() {
    super.initState();
    userController = PageController();
    context.read<HomeCubit>().homeData();
    context.read<MainCubit>().getUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          var homeData = context.read<HomeCubit>().homeModel?.data;
          if (state is HomeStateLoading && homeData == null) {
            return const Center(child: CustomLoadingIndicator());
          } else if (state is HomeStateError) {
            return Center(
              child: Text(
                state.errorMessage.toString(),
                style: TextStyle(fontSize: 15.sp, color: AppColors.primary),
              ),
            );
          } else {
            return Container(
                width: getWidthSize(context),
                color: AppColors.homeColor,
                child: RefreshIndicator(
                  onRefresh: () async {
                    await context.read<HomeCubit>().homeData();
                  },
                  child: ListView(
                    children: [
                      Stack(
                        children: [
                          GestureDetector(
                            onTap: () async {
                              final slider = homeData?.sliders?[0];

                              if (slider == null || slider.url == null) return;

                              if (slider.urlType?.toLowerCase() == "youtube") {
                                final url = Uri.parse(slider.url!);
                                if (await canLaunchUrl(url)) {
                                  await launchUrl(url, mode: LaunchMode.externalApplication);
                                } else {
                                  debugPrint("❌ Can't launch URL: $url");
                                }
                              } else if (slider.urlType?.toLowerCase() == "video") {
                                // افتح شاشة فيديو داخل التطبيق
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => LocalVideoPlayerScreen(videoUrl: slider.url!),
                                  ),
                                );
                              } else {
                                debugPrint("⚠️ Unknown url_type: ${slider.urlType}");
                              }
                            },
                            child: SizedBox(
                              height: getHeightSize(context) / 1.6,
                              width: getWidthSize(context),
                              child: Stack(
                                fit: StackFit.expand,
                                children: [
                                  Image.network(
                                    homeData?.sliders?[0].image ?? "",
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Image.asset(
                                        ImageAssets.imagePicked,
                                        fit: BoxFit.contain,
                                      );
                                    },
                                  ),
                                  Container(
                                    color: Colors.black.withOpacity(0.5),
                                  ),
                                ],
                              ),
                            ),
                          )
,
                          Positioned(
                            bottom: 5.h,
                            left: 0,
                            right: 0,
                            height: getHeightSize(context) / 2,
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                if ((homeData?.userSliders ?? []).isNotEmpty)
                                  Flexible(
                                    child: SizedBox(
                                      height: 360.h,
                                      child: PageView.builder(
                                        scrollDirection: Axis.horizontal,
                                        controller: userController,
                                        itemCount:
                                            homeData!.userSliders!.length,
                                        onPageChanged: (userIndex) {
                                          setState(() {
                                            userCount = userIndex;
                                          });
                                        },
                                        itemBuilder: (context, index) {
                                          final userTalent =
                                              homeData.userSliders![index];
                                          return UnderCustomRow(
                                              userTalent: userTalent);
                                        },
                                      ),
                                    ),
                                  ),
                                const CustomList(),
                                5.h.verticalSpace,
                              ],
                            ),
                          ),
                          Align(
                              alignment: Alignment.topCenter,
                              child: Padding(
                                padding: EdgeInsets.only(top: 5.h),
                                child: CustomAppBarRow(
                                    readNotification:
                                        homeData?.seeAllNotification,
                                    color: AppColors.transparent),
                              )),
                        ],
                      ),
                      SizedBox(height: 10.h),
                      BlocBuilder<TopTalentsCubit, TopTalentsState>(
                          builder: (context, state) {
                        var cubit = context.read<TopTalentsCubit>();
                        if (cubit.topTalents?.data?.length == 0) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomRow(
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, Routes.topTalentsRoute);
                                },
                                text: 'top_talent'.tr(),
                              ),
                              8.h.verticalSpace,
                              Container(
                                height: 184.h,
                                alignment: AlignmentDirectional.centerStart,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount:
                                      cubit.topTalents?.data?.length ?? 0,
                                  itemBuilder: (context, index) {
                                    return CustomTopTalentsList(
                                      topTalentsCubit: cubit,
                                      topTalentsData: cubit.topTalents?.data?[index],
                                      index: index,
                                    );
                                  },
                                ),
                              ),
                            ],
                          );
                        } else {
                          return const SizedBox();
                        }
                      }),
                      if (homeData?.topEvents?.isNotEmpty ?? false)
                        Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(bottom: 4.h),
                              child: CustomRow(
                                text: 'top_events',
                                onTap: () => Navigator.pushNamed(
                                    context, Routes.topEventsRoute),
                              ),
                            ),
                            Container(
                              height: 215.h,
                              alignment: AlignmentDirectional.centerStart,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: homeData?.topEvents?.length ?? 0,
                                itemBuilder: (context, index) {
                                  return CustomTopEventList(
                                    topEvent: homeData?.topEvents?[index],
                                    isLeftPadding: index == 0,
                                    isRightPadding: index ==
                                        (homeData?.topEvents?.length ?? 1) - 1,
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Image.asset(ImageAssets.banner),
                      ),
                      if (homeData?.topGigs?.isNotEmpty ?? false)
                        Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(bottom: 4.h),
                              child: CustomRow(
                                onTap: () => Navigator.pushNamed(
                                    context, Routes.requestGigsRoute),
                                text: 'request_gigs'.tr(),
                              ),
                            ),
                            Container(
                              height: 145.w,
                              alignment: AlignmentDirectional.centerStart,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                physics: const AlwaysScrollableScrollPhysics(),
                                itemCount: homeData?.topGigs?.length,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  var gigs = homeData?.topGigs?[index];
                                  return Padding(
                                    padding: EdgeInsetsDirectional.only(
                                        start: 10.w, end: 10.w),
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.pushNamed(
                                            context,
                                            Routes
                                                .detailsOfMainCategoryFromGigsRoute,
                                            arguments: gigs?.id.toString());
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: AppColors.white,
                                          borderRadius:
                                              BorderRadius.circular(16.r),
                                          image: const DecorationImage(
                                            image: AssetImage(
                                                ImageAssets.tasweerPhoto),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        child: Container(
                                          padding: EdgeInsets.all(8.r),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(16.r),
                                            gradient: LinearGradient(
                                              colors: [
                                                Colors.black.withOpacity(0.6),
                                                Colors.transparent
                                              ],
                                              begin: Alignment.bottomCenter,
                                              end: Alignment.topCenter,
                                            ),
                                          ),
                                          child: Align(
                                            alignment: Alignment.bottomLeft,
                                            child: SizedBox(
                                              width: 130.w,
                                              child: Padding(
                                                padding: EdgeInsets.only(
                                                    bottom: 10.h,
                                                    left: 10.w,
                                                    right: 10.w),
                                                child: Text.rich(
                                                  TextSpan(
                                                    children: [
                                                      WidgetSpan(
                                                        child: Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            color: AppColors
                                                                .secondPrimary,
                                                          ),
                                                          child: Text(
                                                            (gigs?.name ?? "").substring(
                                                                0,
                                                                (gigs?.name?.length ??
                                                                            0) >=
                                                                        5
                                                                    ? 5
                                                                    : (gigs?.name
                                                                            ?.length ??
                                                                        0)),
                                                            style:
                                                                getMediumStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 16.sp,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      TextSpan(
                                                        text:
                                                            (gigs?.name?.length ??
                                                                        0) >
                                                                    5
                                                                ? (gigs?.name ??
                                                                        "")
                                                                    .substring(
                                                                        5)
                                                                : "",
                                                        style: getMediumStyle(
                                                          color:
                                                              AppColors.white,
                                                          fontSize: 16.sp,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      if (homeData?.announcements?.isNotEmpty ?? false)
                        Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(bottom: 10.h),
                              child: CustomRow(
                                text: 'announcements'.tr(),
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, Routes.allAnnouncementsRoute);
                                },
                              ),
                            ),
                            Container(
                              height: getHeightSize(context) / 2,
                              alignment: AlignmentDirectional.centerStart,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: homeData?.announcements?.length ?? 0,
                                itemBuilder: (context, index) {
                                  return CustomAnnouncementWidget(
                                    index: index,
                                    isMainWidget: false,
                                    announcement:
                                        homeData?.announcements?[index],
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      70.h.verticalSpace,
                    ],
                  ),
                ));
          }
        },
      ),
    );
  }
}
