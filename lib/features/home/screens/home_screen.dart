import 'package:easy_localization/easy_localization.dart';
import 'package:mawhebtak/features/home/screens/widgets/custom_announcement_widget.dart';
import 'package:mawhebtak/features/home/screens/widgets/custom_list.dart';
import 'package:mawhebtak/features/home/screens/widgets/custom_request_gigs.dart';
import 'package:mawhebtak/features/home/screens/widgets/custom_row.dart';
import 'package:mawhebtak/features/home/screens/widgets/custom_top_event.dart';
import 'package:mawhebtak/features/home/screens/widgets/custom_top_talents_list.dart';
import 'package:mawhebtak/features/home/screens/widgets/under_custom_row.dart';
import 'package:mawhebtak/features/home/screens/widgets/custom_app_bar_row.dart';
import '../../../config/routes/app_routes.dart';
import '../../../core/exports.dart';
import '../cubit/home_cubit.dart';
import '../cubit/home_state.dart';

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
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  List<String> videoControllers = [
    ImageAssets.testImage,
    ImageAssets.test2Image,
    ImageAssets.testImage,
    ImageAssets.test2Image,
  ];

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<HomeCubit>();
    return BlocBuilder<HomeCubit, HomeState>(builder: (context, state) {
      return Scaffold(
          body: Container(
        width: getWidthSize(context),
        color: AppColors.homeColor,
        child: ListView(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                SizedBox(
                  height: getHeightSize(context) / 1.5,
                  width: getWidthSize(context),
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: videoControllers.length,
                    onPageChanged: (index) {
                      setState(() {
                        _currentPage = index;
                      });
                    },
                    itemBuilder: (context, index) {
                      final controller = videoControllers[index];
                      return controller != null
                          ? Image.asset(
                              controller,
                              fit: BoxFit.cover,
                            )
                          // VideoPlayer(controller)
                          : const Center(child: CircularProgressIndicator());
                    },
                  ),
                ),

                Positioned(
                  top: 35,
                  left: 16,
                  right: 16,
                  child: CustomAppBarRow(
                    color: AppColors.transparent,
                  ),
                ),
                //under custom row
                const UnderCustomRow(),
                //custom list
                const CustomList(),
              ],
            ),
            SizedBox(height: 10.h),
            //top talents
            CustomRow(
              text: 'top_talents',
            ),

            SizedBox(
              height: 8.h,
            ),
            SizedBox(
              height: 184.h,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                physics: const AlwaysScrollableScrollPhysics(),
                itemCount: 5,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  return CustomTopTalentsList(
                    index: index,
                    isLeftPadding: index == 0 ? true : false,
                    isRightPadding:
                        index == cubit.items.length - 1 ? true : false,
                  );
                },
              ),
            ),
            //top events
            CustomRow(
              text: 'top_events',
              onTap: () {
                Navigator.pushNamed(context, Routes.eventScreen);
              },
            ),
            SizedBox(
              height: 4.h,
            ),

            SizedBox(
              height: 215.h,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                physics: const AlwaysScrollableScrollPhysics(),
                itemCount: cubit.items.length,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  return CustomTopEventList(
                    isLeftPadding: index == 0 ? true : false,
                    isRightPadding:
                        index == cubit.items.length - 1 ? true : false,
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Image.asset(ImageAssets.banner),
            ),
            // request_gigs
            CustomRow(
              text: 'request_gigs'.tr(),
            ),
            SizedBox(height: 4.h),
            SizedBox(
              height: 145.w, // Match image width
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                physics: const AlwaysScrollableScrollPhysics(),
                itemCount: cubit.items.length,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  return CustomRequestGigstList(
                    isLeftPadding: index == 0 ? true : false,
                    isRightPadding:
                        index == cubit.items.length - 1 ? true : false,
                  );
                },
              ),
            ),
            CustomRow(
              text: 'announcements'.tr(),
              onTap: () {
                Navigator.pushNamed(context, Routes.announcementScreen);
              },
            ),
            10.h.verticalSpace,
            SizedBox(
              height: getHeightSize(context) / 1.9, // Match image width
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                physics: const AlwaysScrollableScrollPhysics(),
                itemCount: cubit.items.length,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  return CustomAnnouncementWidget(
                    isLeftPadding: index == 0 ? true : false,
                    isRightPadding:
                        index == cubit.items.length - 1 ? true : false,
                  );
                },
              ),
            ),

            const SizedBox(
              height: 100,
            )
          ],
        ),
      ));
    });
  }
}
