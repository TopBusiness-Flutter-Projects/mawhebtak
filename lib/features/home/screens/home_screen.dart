import 'package:easy_localization/easy_localization.dart';
import 'package:mawhebtak/core/widgets/show_loading_indicator.dart';
import 'package:mawhebtak/features/home/cubits/announcements_cubit/announcements_cubit.dart';
import 'package:mawhebtak/features/home/cubits/home_cubit/home_cubit.dart';
import 'package:mawhebtak/features/home/cubits/home_cubit/home_state.dart';
import 'package:mawhebtak/features/home/cubits/top_talents_cubit/top_talents_cubit.dart';
import 'package:mawhebtak/features/home/screens/announcements_screen.dart';
import 'package:mawhebtak/features/home/screens/top_talents_screen.dart';
import 'package:mawhebtak/features/home/screens/widgets/custom_announcement_widget.dart';
import 'package:mawhebtak/features/home/screens/widgets/custom_list.dart';
import 'package:mawhebtak/features/home/screens/widgets/custom_request_gigs.dart';
import 'package:mawhebtak/features/home/screens/widgets/custom_row.dart';
import 'package:mawhebtak/features/home/screens/widgets/custom_top_event.dart';
import 'package:mawhebtak/features/home/screens/widgets/custom_top_talents_list.dart';
import 'package:mawhebtak/features/home/screens/widgets/local_video_player.dart';
import 'package:mawhebtak/features/home/screens/widgets/under_custom_row.dart';
import 'package:mawhebtak/features/home/screens/widgets/custom_app_bar_row.dart';
import 'package:mawhebtak/features/home/screens/widgets/youtube_player_screen.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../../../config/routes/app_routes.dart';
import '../../../core/exports.dart';

class HomeItem {
  final String icon;
  final String label;
  Color? colorIcon;
  HomeItem({required this.icon, required this.label, this.colorIcon});
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late PageController _pageController;
  late PageController _userController;
  int _currentPage = 0;
  int _userCount = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _userController = PageController();
    context.read<HomeCubit>().homeData();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        var homeDataCubit = context.watch<HomeCubit>();
        var homeData = context.watch<HomeCubit>().homeModel?.data;

        if (state is HomeStateLoading) {
          return const Scaffold(
            body: Center(child: CustomLoadingIndicator()),
          );
        } else if (state is HomeStateError) {
          return Scaffold(
            body: Center(
              child: Text(
                state.errorMessage.toString(),
                style: TextStyle(fontSize: 15.sp, color: AppColors.primary),
              ),
            ),
          );
        } else if (state is HomeStateLoaded) {
          return Scaffold(
            body: Container(
              width: getWidthSize(context),
              color: AppColors.homeColor,
              child: ListView(
                children: [
                  // Stack(
                  //   children: [
                  //     SizedBox(
                  //       height: getHeightSize(context) / 1.5,
                  //       width: getWidthSize(context),
                  //       child: PageView.builder(
                  //         controller: _pageController,
                  //         itemCount: homeData?.sliders?.length ?? 0,
                  //         onPageChanged: (index) {
                  //           setState(() {
                  //             _currentPage = index;
                  //           });
                  //         },
                  //         itemBuilder: (context, index) {
                  //           final sliderItem = homeData?.sliders?[index];
                  //           final imageUrl = sliderItem?.image ?? "";
                  //           final videoUrl = sliderItem?.url ?? "";
                  //           final typeUrl = sliderItem?.urlType ?? "";
                  //
                  //           return GestureDetector(
                  //             onTap: () {
                  //               if (typeUrl == "youtube") {
                  //                 final videoId = YoutubePlayer.convertUrlToId(videoUrl);
                  //                 if (videoId != null) {
                  //                   Navigator.push(
                  //                     context,
                  //                     MaterialPageRoute(
                  //                       builder: (context) => YoutubePlayerScreen(videoId: videoId),
                  //                     ),
                  //                   );
                  //                 }
                  //               } else if (videoUrl.endsWith(".mp4")) {
                  //                 Navigator.push(
                  //                   context,
                  //                   MaterialPageRoute(
                  //                     builder: (context) => LocalVideoPlayerScreen(videoUrl: videoUrl),
                  //                   ),
                  //                 );
                  //               }
                  //             },
                  //             child: Image.network(
                  //               imageUrl,
                  //               fit: BoxFit.fill,
                  //             ),
                  //           );
                  //         },
                  //       ),
                  //     ),
                  //     if (homeData?.userSliders?.isNotEmpty ?? false)
                  //       PageView.builder(
                  //         controller: _userController,
                  //         itemCount: homeData?.userSliders?.length ?? 0,
                  //         onPageChanged: (userIndex) {
                  //           setState(() {
                  //             _userCount = userIndex;
                  //           });
                  //         },
                  //         itemBuilder: (context, index) {
                  //           return homeData?.userSliders != null
                  //               ? UnderCustomRow(userTalent: homeData?.userSliders?[index])
                  //               : const Center(child: CircularProgressIndicator());
                  //         },
                  //       ),
                  //     const CustomList(),
                  //     Positioned(
                  //       top: 35,
                  //       left: 16,
                  //       right: 16,
                  //       child: CustomAppBarRow(color: AppColors.transparent),
                  //     ),
                  //   ],
                  // ),
                  SizedBox(height: 10.h),
                  if (homeData?.topTalents?.isNotEmpty ?? false)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomRow(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const TopTalentsScreen(),
                              ),
                            );
                          },
                          text: 'top_talents',
                        ),
                        8.h.verticalSpace,
                        SizedBox(
                          height: 184.h,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: homeData?.topTalents?.length ?? 0,
                            itemBuilder: (context, index) {
                              return CustomTopTalentsList(
                                // topTalentsCubit: context.read<TopTalentsCubit>(),
                                topTalentsData: homeData?.topTalents?[index],
                                isLeftPadding: index == 0,
                                isRightPadding:
                                    index == homeDataCubit.items.length - 1,
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  if (homeData?.topEvents?.isNotEmpty ?? false)
                    Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(bottom: 4.h),
                          child: CustomRow(
                            text: 'top_events',
                            onTap: () => Navigator.pushNamed(
                                context, Routes.topEventsScreen),
                          ),
                        ),
                        SizedBox(
                          height: 215.h,
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
                        SizedBox(
                          height: 145.w,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: homeData?.topGigs?.length ?? 0,
                            itemBuilder: (context, index) {
                              return CustomRequestGigsList(
                                requestGigs: homeData?.topGigs?[index],
                                isLeftPadding: index == 0,
                                isRightPadding: index ==
                                    (homeData?.topGigs?.length ?? 1) - 1,
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
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => BlocProvider(
                                    create: (context) => AnnouncementsCubit()
                                      ..announcementsData(page: '1'),
                                    child: const AnnouncementsScreen(),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        SizedBox(
                          height: getHeightSize(context) / 2.3,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: homeData?.announcements?.length ?? 0,
                            itemBuilder: (context, index) {
                              return CustomAnnouncementWidget(
                                announcement: homeData?.announcements?[index],
                                isLeftPadding: index == 0,
                                isRightPadding: index ==
                                    (homeData?.announcements?.length ?? 1) - 1,
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  50.h.verticalSpace,
                ],
              ),
            ),
          );
        } else {
          return const SizedBox(); // fallback widget
        }
      },
    );
  }
}
