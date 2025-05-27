import 'package:easy_localization/easy_localization.dart';
import 'package:mawhebtak/config/routes/app_routes.dart';
import 'package:mawhebtak/core/widgets/show_loading_indicator.dart';
import 'package:mawhebtak/features/casting/cubit/casting_cubit.dart';
import 'package:mawhebtak/features/casting/cubit/casting_state.dart';
import 'package:mawhebtak/features/casting/screens/widgets/gigs_widgets.dart';
import 'package:mawhebtak/features/home/cubits/request_gigs_cubit/request_gigs_cubit.dart';
import 'package:mawhebtak/features/home/cubits/top_talents_cubit/top_talents_cubit.dart';
import 'package:mawhebtak/features/home/screens/widgets/custom_app_bar_row.dart';
import 'package:mawhebtak/features/home/screens/widgets/custom_top_talents_list.dart';
import '../../../core/exports.dart';

class CastingScreen extends StatefulWidget {
  const CastingScreen({super.key, required this.isFromHome});
  final bool isFromHome;

  @override
  State<CastingScreen> createState() => _CastingScreenState();
}

class _CastingScreenState extends State<CastingScreen> {
  int selectedIndex = 0;
  late List<String> tabs;

  @override
  void initState() {
    super.initState();
    tabs = ["talents".tr(), "gigs".tr()];
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<CastingCubit>().getCategoryFromGigs();
    });
    context.read<RequestGigsCubit>().requestGigsData(page: '1');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          if (!widget.isFromHome)
            CustomSimpleAppbar(
              title: 'casting'.tr(),
              isActionButton: true,
            ),
          Padding(
            padding: EdgeInsets.only(top: 40.h),
            child: CustomAppBarRow(
              colorTextFromSearchTextField: AppColors.darkGray.withOpacity(0.3),
              backgroundColorTextFieldSearch: AppColors.grayLite,
              isMore: true,
              colorSearchIcon: AppColors.secondPrimary,
              backgroundNotification: AppColors.primary,
            ),
          ),
          SizedBox(height: 5.h),
          Expanded(
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(color: AppColors.grayLite),
                  child: Padding(
                    padding: EdgeInsets.only(top: 2.r),
                    child: Column(
                      children: [
                        _buildTabBar(),
                        Expanded(
                          child: selectedIndex == 0
                              ? _buildTalentsContent(context)
                              : _buildGigsContent(context),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: 10.h,
                  right: 20.w,
                  child: _buildAddButton(context),
                ),
              ],
            ),
          ),
          if (widget.isFromHome) 100.h.verticalSpace,
        ],
      ),
    );
  }

  // Tab Bar UI
  Widget _buildTabBar() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 55.w, vertical: 20.h),
      child: Container(
        height: 50.h,
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: List.generate(
            tabs.length,
            (index) => _buildTabItem(index),
          ),
        ),
      ),
    );
  }

  Widget _buildTabItem(int index) {
    final isSelected = selectedIndex == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => selectedIndex = index),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          margin: EdgeInsets.symmetric(horizontal: 0.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.r),
            color: isSelected ? AppColors.secondPrimary : Colors.transparent,
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: AppColors.primary.withOpacity(0.2),
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    )
                  ]
                : null,
          ),
          child: Center(
            child: Text(
              tabs[index],
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                color: isSelected
                    ? AppColors.white
                    : AppColors.grayDark.withOpacity(0.5),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Talent Content UI
  Widget _buildTalentsContent(BuildContext context) {
    final cubit = context.read<TopTalentsCubit>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTopTalentsHorizontalList(context),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
          child: Text(
            "talents".tr(),
            style: TextStyle(color: AppColors.blackLite, fontSize: 16.sp),
          ),
        ),
        BlocBuilder<TopTalentsCubit, TopTalentsState>(
          builder: (context, state) {
            if (state is TopTalentsStateLoading) {
              return const Center(child: CustomLoadingIndicator());
            } else if (state is TopTalentsStateLoaded) {
              final talents = state.topTalents?.data ?? [];
              return Expanded(
                child: SafeArea(
                  bottom: true,
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 4.h,
                      crossAxisSpacing: 16.w,
                      childAspectRatio: 0.95,
                    ),
                    itemCount: talents.length,
                    itemBuilder: (context, index) => CustomTopTalentsList(
                      topTalentsCubit: cubit,
                      topTalentsData: talents[index],
                    ),
                  ),
                ),
              );
            } else if (state is TopTalentsStateError) {
              return Center(child: Text("error_loading_data".tr()));
            }
            return const SizedBox.shrink();
          },
        ),
      ],
    );
  }

  Widget _buildTopTalentsHorizontalList(BuildContext context) {
    final castingCubit = context.read<CastingCubit>();
    final categoryTopTalent = castingCubit.categoryModel?.data ?? [];

    return BlocBuilder<CastingCubit, CastingState>(
      builder: (context, state) {
        if (state is CategoryFromGigsStateLoading) {
          return const Center(child: CustomLoadingIndicator());
        } else if (state is CategoryFromGigsStateLoaded) {
          return SizedBox(
            height: 145.w,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: categoryTopTalent.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                var talent = categoryTopTalent[index];
                return Padding(
                  padding: EdgeInsetsDirectional.only(start: 10.w, end: 10.w),
                  child: GestureDetector(
                    onTap: () {
                      print('sadasd');
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16.r),
                        image: const DecorationImage(
                          image: AssetImage(ImageAssets.tasweerPhoto),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Container(
                        padding: EdgeInsets.all(8.r),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16.r),
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
                                  bottom: 10.h, left: 10.w, right: 10.w),
                              child: Text.rich(
                                TextSpan(
                                  children: [
                                    WidgetSpan(
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: AppColors.secondPrimary,
                                        ),
                                        child: Text(
                                          (talent.name ?? "").substring(
                                              0,
                                              (talent.name?.length ?? 0) >= 5
                                                  ? 5
                                                  : (talent.name?.length ?? 0)),
                                          style: getMediumStyle(
                                            color: Colors.white,
                                            fontSize: 16.sp,
                                          ),
                                        ),
                                      ),
                                    ),
                                    TextSpan(
                                      text: (talent.name?.length ?? 0) > 5
                                          ? (talent.name ?? "").substring(5)
                                          : "",
                                      style: getMediumStyle(
                                        color: AppColors.white,
                                        fontSize: 16.sp,
                                      ),
                                    ),
                                  ],
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
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
          );
        } else if (state is TopTalentsStateError) {
          return Center(child: Text("error_loading_data".tr()));
        }
        return const SizedBox.shrink();
      },
    );
  }

  // Gigs Content UI
  Widget _buildGigsContent(BuildContext context) {
    final cubit = context.read<RequestGigsCubit>();
    final gigs = cubit.requestGigs?.data ?? [];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildGigsHorizontalList(context),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
          child: Text(
            "gigs_list".tr(),
            style: TextStyle(color: AppColors.blackLite, fontSize: 16.sp),
          ),
        ),
        BlocBuilder<RequestGigsCubit, RequestGigsState>(
          builder: (context, state) {
            if (state is RequestGigsStateLoading) {
              return const Center(child: CustomLoadingIndicator());
            }
            return Expanded(
              child: RefreshIndicator(
                onRefresh: () async {
                  await cubit.requestGigsData(page: '1');
                },
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemCount: gigs.length,
                  padding: EdgeInsets.symmetric(horizontal: 12.w),
                  itemBuilder: (context, index) => GigsWidget(
                    eventAndGigsModel: gigs[index],
                    isWithButton: true,
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildGigsHorizontalList(BuildContext context) {
    final castingCubit = context.read<CastingCubit>();
    final categoryGigs = castingCubit.categoryModel?.data ?? [];

    return SizedBox(
      height: 145.w,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const AlwaysScrollableScrollPhysics(),
        itemCount: categoryGigs.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          var gigs = categoryGigs[index];
          return Padding(
            padding: EdgeInsetsDirectional.only(start: 10.w, end: 10.w),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                    context, Routes.detailsOfMainCategoryFromGigsRoute,
                    arguments: gigs.id.toString());
              },
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(16.r),
                  image: const DecorationImage(
                    image: AssetImage(ImageAssets.tasweerPhoto),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Container(
                  padding: EdgeInsets.all(8.r),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.r),
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
                            bottom: 10.h, left: 10.w, right: 10.w),
                        child: Text.rich(
                          TextSpan(
                            children: [
                              WidgetSpan(
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: AppColors.secondPrimary,
                                  ),
                                  child: Text(
                                    (gigs.name ?? "").substring(
                                        0,
                                        (gigs.name?.length ?? 0) >= 5
                                            ? 5
                                            : (gigs.name?.length ?? 0)),
                                    style: getMediumStyle(
                                      color: Colors.white,
                                      fontSize: 16.sp,
                                    ),
                                  ),
                                ),
                              ),
                              TextSpan(
                                text: (gigs.name?.length ?? 0) > 5
                                    ? (gigs.name ?? "").substring(5)
                                    : "",
                                style: getMediumStyle(
                                  color: AppColors.white,
                                  fontSize: 16.sp,
                                ),
                              ),
                            ],
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
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
    );
  }

  // Floating Action Button
  Widget _buildAddButton(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, Routes.newGigsRoute),
      child: Container(
        width: 60.w,
        height: 60.h,
        decoration: BoxDecoration(
          color: AppColors.primary,
          shape: BoxShape.circle,
        ),
        child: const Center(child: Icon(Icons.add, color: Colors.white)),
      ),
    );
  }
}
