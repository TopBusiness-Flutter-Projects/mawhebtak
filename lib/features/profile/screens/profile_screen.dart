import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:mawhebtak/core/widgets/show_loading_indicator.dart';
import 'package:mawhebtak/features/casting/cubit/casting_cubit.dart';
import 'package:mawhebtak/features/casting/cubit/casting_state.dart';
import 'package:mawhebtak/features/home/screens/widgets/follow_button.dart';
import 'package:mawhebtak/features/profile/cubit/profile_cubit.dart';
import 'package:mawhebtak/features/profile/screens/widgets/about_widgets/about_widget.dart';
import 'package:mawhebtak/features/profile/screens/widgets/info_for_followers.dart';
import 'package:mawhebtak/features/profile/screens/widgets/post_widget_profile.dart';
import 'package:mawhebtak/features/profile/screens/widgets/profile_app_bar.dart';
import 'package:mawhebtak/features/profile/screens/widgets/profile_taps.dart';
import '../../../config/routes/app_routes.dart';
import '../../../core/exports.dart';
import '../../../core/preferences/preferences.dart';
import '../../../core/utils/check_login.dart';
import '../../casting/screens/widgets/gigs_widgets.dart';
import '../../events/screens/details_event_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key, required this.model});
  final DeepLinkDataModel model;
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    context
        .read<ProfileCubit>()
        .getProfileData(id: widget.model.id, context: context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
        builder: (BuildContext context, state) {
      var cubit = context.read<ProfileCubit>();

      return AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.light.copyWith(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.light,
          ),
          child: Scaffold(
            body: (state is GetProfileStateLoading ||
                    cubit.profileModel == null)
                ? const Center(
                    child: CustomLoadingIndicator(),
                  )
                : Stack(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ProfileAppBar(
                            isEdit: false,
                            id: cubit.profileModel?.data?.id?.toString() ?? '',
                            avatar: cubit.profileModel?.data?.avatar ?? "",
                            byCaver: cubit.profileModel?.data?.bgCover ?? "",
                          ),
                          SizedBox(height: 35.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(left: 16.0.w),
                                      child: Text(
                                        cubit.profileModel?.data?.name ?? "",
                                        style: getMediumStyle(
                                            fontSize: 14.sp,
                                            color: AppColors.primary),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 16.0.w),
                                      child: RichText(
                                        maxLines: 2,
                                        text: TextSpan(
                                          text: cubit.profileModel?.data
                                                  ?.headline ??
                                              "",
                                          style:
                                              getRegularStyle(fontSize: 14.sp),
                                          children: <TextSpan>[
                                            TextSpan(
                                                text: cubit.profileModel?.data
                                                            ?.userType?.name ==
                                                        null
                                                    ? ""
                                                    : '(${cubit.profileModel?.data?.userType?.name})',
                                                style: getRegularStyle(
                                                    fontSize: 14.sp,
                                                    color: AppColors.primary)),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 16.0.w),
                                      child: Text(
                                          cubit.profileModel?.data?.location ??
                                              "",
                                          style: getRegularStyle(
                                              fontSize: 14.sp,
                                              color: AppColors.grayMedium)),
                                    ),
                                  ],
                                ),
                              ),
                              if (cubit.user?.data?.id.toString() ==
                                  widget.model.id)
                                GestureDetector(
                                  onTap: () {
                                    cubit.saveData(context);
                                    Navigator.pushNamed(
                                        context, Routes.editProfileRoute,
                                        arguments: widget.model);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: SvgPicture.asset(AppIcons.bioIcon),
                                  ),
                                ),
                            ],
                          ),
                          SizedBox(height: 20.h),
                          (cubit.user?.data?.id.toString() == widget.model.id)
                              ? InfoForFollowers(
                                  followersCount: cubit
                                          .profileModel?.data?.followersCount
                                          .toString() ??
                                      "0",
                                  followingCount: cubit
                                          .profileModel?.data?.followingCount
                                          .toString() ??
                                      "0",
                                  postsCount: cubit
                                          .profileModel?.data?.postsCount
                                          .toString() ??
                                      "0",
                                )
                              : Padding(
                                  padding:
                                      EdgeInsets.only(left: 10.w, right: 10.w),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: CustomContainerButton(
                                          borderColor: AppColors.primary,
                                          onTap: () async {},
                                          height: 40.h,
                                          title: "follow".tr(),
                                          color: AppColors.white,
                                          textColor: AppColors.primary,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10.w,
                                      ),
                                      PopupMenuButton<String>(
                                        icon: SvgPicture.asset(
                                          AppIcons.settingIcon,
                                          width: 35.w,
                                          height: 35.h,
                                        ),
                                        onSelected: (value) {
                                          if (value == 'rate') {
                                            showDialog(
                                              context: context,
                                              builder: (context) => AlertDialog(
                                                title: const Text(
                                                    'أدخل تقييمك وتعليقك'),
                                                content: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    RatingStars(
                                                      axis: Axis.horizontal,
                                                      value:
                                                          cubit.review ?? 0.0,
                                                      onValueChanged: (v) {
                                                        setState(() {
                                                          cubit.review = v;
                                                        });
                                                      },
                                                      starCount: 5,
                                                      starSize: 20,
                                                      valueLabelColor:
                                                          const Color(
                                                              0xff9b9b9b),
                                                      valueLabelTextStyle:
                                                          const TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              fontStyle:
                                                                  FontStyle
                                                                      .normal,
                                                              fontSize: 12.0),
                                                      valueLabelRadius: 10,
                                                      maxValue: 5,
                                                      starSpacing: 2,
                                                      maxValueVisibility: false,
                                                      valueLabelVisibility:
                                                          false,
                                                      animationDuration:
                                                          const Duration(
                                                              milliseconds:
                                                                  1000),
                                                      valueLabelPadding:
                                                          const EdgeInsets
                                                              .symmetric(
                                                              vertical: 1,
                                                              horizontal: 8),
                                                      valueLabelMargin:
                                                          const EdgeInsets.only(
                                                              right: 8),
                                                      starOffColor: const Color(
                                                          0xffe7e8ea),
                                                      starColor: Colors.yellow,
                                                    ),
                                                    const SizedBox(height: 16),
                                                    TextField(
                                                      controller: cubit
                                                          .commentController,
                                                      decoration:
                                                          const InputDecoration(
                                                        labelText:
                                                            'اكتب تعليقك هنا',
                                                        border:
                                                            OutlineInputBorder(),
                                                      ),
                                                      maxLines: 3,
                                                    ),
                                                  ],
                                                ),
                                                actions: [
                                                  TextButton(
                                                    onPressed: () {
                                                      cubit.addReview(
                                                        context: context,
                                                          userId: cubit
                                                                  .profileModel
                                                                  ?.data
                                                                  ?.id
                                                                  .toString() ??
                                                              "");
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    child: const Text('إرسال'),
                                                  ),
                                                  TextButton(
                                                    onPressed: () =>
                                                        Navigator.of(context)
                                                            .pop(),
                                                    child: const Text('إلغاء'),
                                                  ),
                                                ],
                                              ),
                                            );
                                          }
                                        },
                                        color: AppColors.white,
                                        itemBuilder: (BuildContext context) =>
                                            <PopupMenuEntry<String>>[
                                          PopupMenuItem<String>(
                                            value: 'rate',
                                            child: Text('rate'.tr()),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                          SizedBox(height: 5.h),
                          Container(height: 8.h, color: AppColors.grayLite),
                          Container(height: 20.h, color: AppColors.white),
                          ProfileTabs(
                            isMyProfile: (cubit.user?.data?.id.toString() ==
                                    widget.model.id)
                                ? true
                                : false,
                          ),
                          SizedBox(height: 5.h),
                          if (cubit.selectedIndex == 0) ...[
                            AboutWidget(
                              profileModel: cubit.profileModel,
                            )
                          ] else if (cubit.selectedIndex == 1) ...[
                            Expanded(
                              child: SingleChildScrollView(
                                child: (cubit.profileModel?.data?.timeline ==
                                            [] ||
                                        cubit.profileModel?.data?.timeline
                                                ?.length ==
                                            0)
                                    ? Center(
                                        child: Text(
                                          "no_data".tr(),
                                          style:
                                              TextStyle(color: AppColors.black),
                                        ),
                                      )
                                    : ListView.builder(
                                        shrinkWrap: true,
                                        padding: const EdgeInsets.only(
                                            bottom: kBottomNavigationBarHeight),
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemCount: cubit.profileModel?.data
                                                ?.timeline?.length ??
                                            0,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return PostProfileWidget(
                                              profileCubit: cubit,
                                              postId: cubit.profileModel?.data
                                                      ?.timeline?[index].id
                                                      .toString() ??
                                                  "",
                                              post: cubit.profileModel?.data
                                                  ?.timeline?[index],
                                              index: index);
                                        },
                                      ),
                              ),
                            )
                          ] else if (cubit.selectedIndex == 2 &&
                              cubit.user?.data?.id.toString() ==
                                  widget.model.id) ...[
                            BlocBuilder<CastingCubit, CastingState>(
                                builder: (context, state) {
                              var castingCubit = context.read<CastingCubit>();
                              return Expanded(
                                child: SingleChildScrollView(
                                  child: (cubit.profileModel?.data?.myGigs
                                              ?.length ==
                                          0)
                                      ? Center(
                                          child: Text(
                                            "no_data".tr(),
                                            style: TextStyle(
                                                color: AppColors.black),
                                          ),
                                        )
                                      : ListView.builder(
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          itemCount: cubit.profileModel?.data
                                                  ?.myGigs?.length ??
                                              0,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            return GigsWidget(
                                              index: index,
                                              isFromDetails: false,
                                              eventAndGigsModel: cubit
                                                  .profileModel!
                                                  .data!
                                                  .myGigs![index],
                                              castingCubit: castingCubit,
                                            );
                                          },
                                        ),
                                ),
                              );
                            })
                          ] else if (cubit.selectedIndex == 3 ||
                              cubit.selectedIndex == 2) ...[
                            (cubit.profileModel?.data?.reviews == [] ||
                                    cubit.profileModel?.data?.reviews?.length ==
                                        0)
                                ? Center(
                                    child: Text(
                                      "no_data".tr(),
                                      style: TextStyle(color: AppColors.black),
                                    ),
                                  )
                                : Container(
                                    color: AppColors.grayLite,
                                    child: Expanded(
                                      child: ListView.builder(
                                          shrinkWrap: true,
                                          itemCount: cubit.profileModel?.data
                                              ?.reviews?.length,
                                          itemBuilder:
                                              (context, index) => Container(
                                                    decoration: BoxDecoration(
                                                      color: AppColors.white,
                                                    ),
                                                    child: Padding(
                                                      padding: EdgeInsets.only(
                                                          bottom: 10.h,
                                                          top: 10.h,
                                                          right: 10.w,
                                                          left: 10.w),
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Row(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                Row(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Column(
                                                                      children: [
                                                                        SizedBox(
                                                                          height:
                                                                              40.h,
                                                                          width:
                                                                              40.w,
                                                                          child:
                                                                              Image.asset(ImageAssets.profileImage),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    SizedBox(
                                                                        width: 8
                                                                            .w),
                                                                    Column(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        AutoSizeText(
                                                                          cubit.profileModel?.data?.reviews?[index].user?.name ??
                                                                              "",
                                                                          style:
                                                                              getMediumStyle(fontSize: 18.sp),
                                                                        ),
                                                                        AutoSizeText(
                                                                          cubit.profileModel?.data?.reviews?[index].user?.headline ??
                                                                              "",
                                                                          style:
                                                                              getRegularStyle(
                                                                            fontSize:
                                                                                16.sp,
                                                                            color:
                                                                                AppColors.grayLight,
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ],
                                                                ),
                                                                Row(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    RatingStars(
                                                                      axis: Axis
                                                                          .horizontal,
                                                                      value: (double.parse(cubit
                                                                              .profileModel
                                                                              ?.data
                                                                              ?.reviews?[index]
                                                                              .review
                                                                              .toString() ??
                                                                          "0.0")),
                                                                      onValueChanged:
                                                                          (v) {
                                                                        //
                                                                        setState(
                                                                            () {
                                                                          cubit
                                                                              .profileModel
                                                                              ?.data
                                                                              ?.reviews?[index]
                                                                              .review = v;
                                                                        });
                                                                      },
                                                                      starCount:
                                                                          5,
                                                                      starSize:
                                                                          20,
                                                                      valueLabelColor:
                                                                          const Color(
                                                                              0xff9b9b9b),
                                                                      valueLabelTextStyle: const TextStyle(
                                                                          color: Colors
                                                                              .white,
                                                                          fontWeight: FontWeight
                                                                              .w400,
                                                                          fontStyle: FontStyle
                                                                              .normal,
                                                                          fontSize:
                                                                              12.0),
                                                                      valueLabelRadius:
                                                                          10,
                                                                      maxValue:
                                                                          5,
                                                                      starSpacing:
                                                                          2,
                                                                      maxValueVisibility:
                                                                          false,
                                                                      valueLabelVisibility:
                                                                          false,
                                                                      animationDuration:
                                                                          const Duration(
                                                                              milliseconds: 1000),
                                                                      valueLabelPadding: const EdgeInsets
                                                                          .symmetric(
                                                                          vertical:
                                                                              1,
                                                                          horizontal:
                                                                              8),
                                                                      valueLabelMargin: const EdgeInsets
                                                                          .only(
                                                                          right:
                                                                              8),
                                                                      starOffColor:
                                                                          const Color(
                                                                              0xffe7e8ea),
                                                                      starColor:
                                                                          Colors
                                                                              .yellow,
                                                                    ),
                                                                  ],
                                                                ),
                                                              ]),
                                                          Text(
                                                            cubit
                                                                    .profileModel
                                                                    ?.data
                                                                    ?.reviews?[
                                                                        index]
                                                                    .comment ??
                                                                "",
                                                            style: TextStyle(
                                                                color: AppColors
                                                                    .black
                                                                    .withOpacity(
                                                                        0.5)),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  )),
                                    ),
                                  )
                          ]
                        ],
                      ),
                      cubit.selectedIndex == 2
                          ? Positioned(
                              bottom: 20.h,
                              right: 16.w,
                              child: InkWell(
                                  onTap: () async {
                                    final user = await Preferences.instance
                                        .getUserModel();
                                    if (user.data?.token == null) {
                                      checkLogin(context);
                                    } else {
                                      Navigator.pushNamed(
                                          context, Routes.newGigsRoute);
                                    }
                                  },
                                  child: SvgPicture.asset(AppIcons.addIcon)),
                            )
                          : const SizedBox()
                    ],
                  ),
          ));
    });
  }
}
