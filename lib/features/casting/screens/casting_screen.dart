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
import '../../home/screens/widgets/custom_request_gigs.dart';

class CastingScreen extends StatefulWidget {
  const CastingScreen({super.key, required this.isFromHome});
  final bool isFromHome;
  @override
  State<CastingScreen> createState() => _CastingScreenState();
}

class _CastingScreenState extends State<CastingScreen> {
  int selectedIndex = 0;

  final List<String> roles = ["talents".tr(), "gigs".tr()];
  @override
  void initState() {
    context.read<RequestGigsCubit>().requestGigsData(page: '1');
    context.read<TopTalentsCubit>().topTalentsData(page: '1');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<CastingCubit>();
    return Scaffold(
      body: Column(
        children: [
          if (widget.isFromHome != true)
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
          BlocBuilder<CastingCubit, CastingState>
            (builder: (context, state) {
            return Expanded(
              child: Stack(
                children: [
                  Container(
                      decoration: BoxDecoration(
                        color: AppColors.grayLite,
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(top: 2.r),
                        child: Column(
                          children: [
                            Padding(
                                padding: EdgeInsets.only(
                                    top: 20.h,
                                    left: 55.w,
                                    right: 55.w,
                                    bottom: 20.h),
                                child: Container(
                                  height: 50.h,
                                  decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    borderRadius: BorderRadius.circular(12.r),
                                  ),
                                  child: Center(
                                      child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: List.generate(
                                            roles.length,
                                            (index) {
                                              bool isSelected =
                                                  selectedIndex == index;
                                              return Expanded(
                                                child: GestureDetector(
                                                  onTap: () => setState(() =>
                                                      selectedIndex = index),
                                                  child: AnimatedContainer(
                                                    duration: const Duration(
                                                        milliseconds: 300),
                                                    curve: Curves.easeInOut,
                                                    margin:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 0.w),
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8.r),
                                                      color: isSelected
                                                          ? AppColors
                                                              .secondPrimary
                                                          : Colors.transparent,
                                                      boxShadow: isSelected
                                                          ? [
                                                              BoxShadow(
                                                                color: AppColors
                                                                    .primary
                                                                    .withOpacity(
                                                                        0.2),
                                                                blurRadius: 6,
                                                                offset:
                                                                    const Offset(
                                                                        0, 2),
                                                              )
                                                            ]
                                                          : null,
                                                    ),
                                                    child: Center(
                                                      child: Text(
                                                        roles[index],
                                                        style: TextStyle(
                                                          fontSize: 16.sp,
                                                          fontWeight: isSelected
                                                              ? FontWeight.w600
                                                              : FontWeight.w500,
                                                          color: isSelected
                                                              ? AppColors.white
                                                              : AppColors
                                                                  .grayDark
                                                                  .withOpacity(
                                                                      0.5),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              );
                                            },
                                          ))),
                                )),
                            Expanded(
                              child: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [

                                    if (selectedIndex == 0)
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            height: 145.w,
                                            child: (state
                                            is RequestGigsStateLoading)
                                                ? const CustomLoadingIndicator()
                                                :ListView.builder(
                                              scrollDirection: Axis.horizontal,
                                              physics:
                                              const AlwaysScrollableScrollPhysics(),
                                              itemCount: context
                                                  .read<TopTalentsCubit>()
                                                  .topTalents
                                                  ?.data
                                                  ?.length ??
                                                  0,
                                              shrinkWrap: true,
                                              itemBuilder:
                                                  (BuildContext context, int index) {
                                                var cubit = context.read<TopTalentsCubit>();
                                                return BlocBuilder<TopTalentsCubit,TopTalentsState>(
                                                    builder: (context, state) {
                                                      return GestureDetector(
                                                        onTap: () {
                                                          Navigator.pushNamed(context, Routes.detailsOfMainCategoryGigsRoute,arguments: 'talents');

                                                        },
                                                        child: Padding(
                                                          padding: EdgeInsetsDirectional.only(
                                                            start:  10.w,
                                                            end:  10.0.w,
                                                          ),
                                                          child: InkWell(
                                                            onTap: () {
                                                              // Navigator.pushNamed(context, Routes.detailsOfMainCategoryGigsRoute);
                                                            },
                                                            child: Container(
                                                              decoration: BoxDecoration(
                                                                borderRadius: BorderRadius.circular(16.r),
                                                                image: DecorationImage(
                                                                  image: cubit.topTalents?.data?[index].image != null &&
                                                                      cubit.topTalents!.data![index].image!.isNotEmpty
                                                                      ? NetworkImage(cubit.topTalents!.data![index].image!)
                                                                      : const AssetImage(ImageAssets.tasweerPhoto) as ImageProvider,
                                                                  fit: BoxFit.cover,
                                                                ),
                                                              ),
                                                              child: Container(
                                                                padding:  EdgeInsets.all(8.0.r),
                                                                decoration: BoxDecoration(
                                                                  borderRadius: BorderRadius.circular(16.r),
                                                                  gradient: LinearGradient(
                                                                    colors: [
                                                                      Colors.black.withOpacity(0.6),
                                                                      Colors.transparent,
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
                                                                        padding:  EdgeInsets.only(bottom: 10.h,left: 10.w,right: 10.w),
                                                                        child: Text.rich(

                                                                          TextSpan(
                                                                            children: [
                                                                              WidgetSpan(
                                                                                child: Container(
                                                                                  decoration: BoxDecoration(
                                                                                    color:AppColors.secondPrimary,
                                                                                  ),
                                                                                  child: Text(
                                                                                    (cubit.topTalents!.data![index].name ?? "").substring(0,
                                                                                        (cubit.topTalents!.data![index].name?.length ?? 0) >= 5 ? 5 :
                                                                                        (cubit.topTalents!.data![index].name?.length ?? 0)
                                                                                    ),
                                                                                    style: getMediumStyle(
                                                                                      color: Colors.white,
                                                                                      fontSize: 16.sp,
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                              TextSpan(
                                                                                text: (cubit.topTalents!.data![index].name?.length ?? 0) > 5
                                                                                    ? (cubit.topTalents!.data![index].name ?? "").substring(5)
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
                                                                        )


                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      );
                                                    });
                                              },
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(top: 10.h,right: 20.w,left: 20.w),
                                            child: Text(
                                              "talents".tr(),
                                              style: TextStyle(
                                                  color: AppColors.blackLite,
                                                  fontSize: 16.sp),
                                            ),
                                          ),
                                          BlocBuilder<TopTalentsCubit,
                                                  TopTalentsState>(
                                              builder: (context, state) {
                                            return Padding(
                                              padding: EdgeInsets.only(
                                                  left: 10.w, right: 10.w),
                                              child: (state
                                                      is TopTalentsStateLoading)
                                                  ? const Center(
                                                      child:
                                                          CustomLoadingIndicator())
                                                  : GridView.builder(
                                                      gridDelegate:
                                                          SliverGridDelegateWithFixedCrossAxisCount(
                                                        crossAxisCount: 2,
                                                        mainAxisSpacing: 4.h,
                                                        crossAxisSpacing: 16.w,
                                                        childAspectRatio:
                                                            0.95,
                                                      ),
                                                      scrollDirection:
                                                          Axis.vertical,
                                                      physics:
                                                          const BouncingScrollPhysics(),
                                                      itemCount: context
                                                              .read<
                                                                  TopTalentsCubit>()
                                                              .topTalents
                                                              ?.data
                                                              ?.length ??
                                                          0,
                                                      shrinkWrap: true,
                                                      itemBuilder:
                                                          (BuildContext context,
                                                              int index) {
                                                        return CustomTopTalentsList(
                                                          topTalentsCubit:
                                                              context.read<
                                                                  TopTalentsCubit>(),
                                                          topTalentsData: context
                                                              .read<
                                                                  TopTalentsCubit>()
                                                              .topTalents
                                                              ?.data?[index],
                                                        );
                                                      },
                                                    ),
                                            );
                                          }),
                                        ],
                                      )
                                    else
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            height: 145.w,
                                            child: (state
                                            is RequestGigsStateLoading)
                                                ? const CustomLoadingIndicator()
                                                :ListView.builder(
                                              scrollDirection: Axis.horizontal,
                                              physics:
                                              const AlwaysScrollableScrollPhysics(),
                                              itemCount: context
                                                  .read<RequestGigsCubit>()
                                                  .requestGigs
                                                  ?.data
                                                  ?.length ??
                                                  0,
                                              shrinkWrap: true,
                                              itemBuilder:
                                                  (BuildContext context, int index) {
                                                return BlocBuilder<RequestGigsCubit,RequestGigsState>(
                                                    builder: (context, state) {
                                                      return  CustomRequestGigsList(
                                                        requestGigs: context
                                                            .read<
                                                            RequestGigsCubit>()
                                                            .requestGigs
                                                            ?.data?[index],
                                                        isLeftPadding: index == 0
                                                            ? true
                                                            : false,
                                                        isRightPadding: false,
                                                      );
                                                    });
                                              },
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 20.w,
                                                vertical: 10.h),
                                            child: Text(
                                              "gigs_list".tr(),
                                              style: TextStyle(
                                                  color: AppColors.blackLite,
                                                  fontSize: 16.sp),
                                            ),
                                          ),
                                          BlocBuilder<RequestGigsCubit,RequestGigsState>(
                                            builder: (context,state) {
                                              return ListView.builder(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 12.w),
                                                physics:
                                                    const NeverScrollableScrollPhysics(),
                                                itemCount: context
                                                    .read<RequestGigsCubit>()
                                                    .requestGigs
                                                    ?.data
                                                    ?.length, // Replace with your actual item count
                                                shrinkWrap: true,
                                                itemBuilder: (BuildContext context,
                                                    int index) {
                                                  return GigsWidget(
                                                    eventAndGigsModel: context
                                                        .read<RequestGigsCubit>()
                                                        .requestGigs
                                                        ?.data?[index],
                                                    isWithButton: true,
                                                  );
                                                },
                                              );
                                            }
                                          ),
                                        ],
                                      )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      )),
                  Positioned(
                    bottom: 10.h,
                    right: 20.w,
                    child: GestureDetector(
                      onTap: () {
                        print("Category Data Length: ${cubit.categoryModel?.data?[0].id}");
                        Navigator.pushNamed(context, Routes.newGigsRoute);
                      },
                      child: Container(
                        width: 60.w,
                        height: 60.h,
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          shape: BoxShape.circle,
                        ),
                        child: const Center(
                          child: Icon(Icons.add, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
          if (widget.isFromHome != false) 100.h.verticalSpace,
        ],
      ),
    );
  }
}
