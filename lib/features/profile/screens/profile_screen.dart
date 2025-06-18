import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:mawhebtak/core/widgets/show_loading_indicator.dart';
import 'package:mawhebtak/features/casting/cubit/casting_cubit.dart';
import 'package:mawhebtak/features/casting/cubit/casting_state.dart';
import 'package:mawhebtak/features/feeds/cubit/feeds_cubit.dart';
import 'package:mawhebtak/features/feeds/cubit/feeds_state.dart';
import 'package:mawhebtak/features/feeds/screens/widgets/what_do_you_want.dart';
import 'package:mawhebtak/features/home/cubits/top_talents_cubit/top_talents_cubit.dart';
import 'package:mawhebtak/features/home/screens/widgets/follow_button.dart';
import 'package:mawhebtak/features/profile/cubit/profile_cubit.dart';
import 'package:mawhebtak/features/profile/screens/widgets/about_widgets/about_widget.dart';
import 'package:mawhebtak/features/profile/screens/widgets/info_for_followers.dart';
import 'package:mawhebtak/features/profile/screens/widgets/post_widget_profile.dart';
import 'package:mawhebtak/features/profile/screens/widgets/profile_app_bar.dart';
import 'package:mawhebtak/features/profile/screens/widgets/profile_taps.dart';
import 'package:mawhebtak/config/routes/app_routes.dart';
import 'package:mawhebtak/core/exports.dart';
import 'package:mawhebtak/core/preferences/preferences.dart';
import 'package:mawhebtak/core/utils/check_login.dart';
import 'package:mawhebtak/features/casting/screens/widgets/gigs_widgets.dart';
import 'package:mawhebtak/features/events/screens/details_event_screen.dart';

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
      builder: (context, state) {
        var profileCubit = context.read<ProfileCubit>();
        return (state is GetProfileStateLoading ||
                profileCubit.profileModel == null)
            ? const Center(child: CustomLoadingIndicator())
            : _buildProfileContent(context);
      },
    );
  }

  Widget _buildProfileContent(BuildContext context) {
    final cubit = context.read<ProfileCubit>();
    final profile = cubit.profileModel?.data;
    final user = cubit.user?.data;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light.copyWith(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
      child: Scaffold(
        body: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ProfileAppBar(
                  isEdit: false,
                  id: profile?.id.toString() ?? '',
                  avatar: profile?.avatar ?? "",
                  byCaver: profile?.bgCover ?? "",
                ),
                SizedBox(height: 35.h),
                _buildProfileHeader(profile),
                SizedBox(height: 20.h),
                _buildFollowButtons(context, user, profile),
                SizedBox(height: 5.h),
                Container(height: 8.h, color: AppColors.grayLite),
                Container(height: 20.h, color: AppColors.white),
                ProfileTabs(
                  isMyProfile: user?.id.toString() == widget.model.id,
                ),
                SizedBox(height: 5.h),
                _buildTabContent(cubit, context),
              ],
            ),
            if (cubit.selectedIndex == 2 &&
                user?.id.toString() == widget.model.id)
              _buildAddGigButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader(profile) {
    return Row(
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
                  profile?.name ?? "",
                  style:
                      getMediumStyle(fontSize: 14.sp, color: AppColors.primary),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 16.0.w),
                child: RichText(
                  maxLines: 2,
                  text: TextSpan(
                    text: profile?.headline ?? "",
                    style: getRegularStyle(fontSize: 14.sp),
                    children: <TextSpan>[
                      TextSpan(
                        text: profile?.userType?.name == null
                            ? ""
                            : '(${profile?.userType?.name})',
                        style: getRegularStyle(
                            fontSize: 14.sp, color: AppColors.primary),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        if (context.read<ProfileCubit>().user?.data?.id.toString() ==
            widget.model.id)
          GestureDetector(
            onTap: () {
              context.read<ProfileCubit>().saveData(context);
              Navigator.pushNamed(context, Routes.editProfileRoute,
                  arguments: widget.model);
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SvgPicture.asset(AppIcons.bioIcon),
            ),
          ),
      ],
    );
  }

  Widget _buildFollowButtons(BuildContext context, userData, profileData) {
    final cubit = context.read<ProfileCubit>();
    final isMyProfile = userData?.id.toString() == widget.model.id;

    if (isMyProfile) {
      return InfoForFollowers(
        followersCount: profileData?.followersCount.toString() ?? "0",
        followingCount: profileData?.followingCount.toString() ?? "0",
        postsCount: profileData?.postsCount.toString() ?? "0",
      );
    }

    return Padding(
      padding: EdgeInsets.only(left: 10.w, right: 10.w),
      child: Row(
        children: [
          Expanded(
            child: BlocBuilder<TopTalentsCubit, TopTalentsState>(
              builder: (context, state) {
                var topTalentCubit = context.read<TopTalentsCubit>();
                return CustomContainerButton(
                  onTap: () async {
                    final user = await Preferences.instance.getUserModel();
                    if (user.data?.token == null) {
                      checkLogin(context);
                    } else {
                      if (cubit.profileModel?.data?.isIFollow != null) {
                        cubit.profileModel?.data?.isIFollow =
                            !(cubit.profileModel?.data?.isIFollow)!;
                      }
                      topTalentCubit.followAndUnFollow(
                        context,
                        followedId:
                            cubit.profileModel?.data?.id.toString() ?? "",
                      );
                    }
                  },
                  height: 35.h,
                  title: cubit.profileModel?.data?.isIFollow == true
                      ? "un_follow".tr()
                      : "follow".tr(),
                  color: cubit.profileModel?.data?.isIFollow == true
                      ? AppColors.primary
                      : AppColors.white,
                  borderColor: cubit.profileModel?.data?.isIFollow == true
                      ? AppColors.grayLite
                      : AppColors.primary,
                  textColor: cubit.profileModel?.data?.isIFollow == true
                      ? AppColors.grayLite
                      : AppColors.primary,
                  width: 138.w,
                );
              },
            ),
          ),
          SizedBox(width: 10.w),
          PopupMenuButton<String>(
            icon: SvgPicture.asset(
              AppIcons.settingIcon,
              width: 35.w,
              height: 35.h,
            ),
            onSelected: (value) {
              if (value == 'rate') {
                if (cubit.profileModel?.data?.isIReviewed == true) {
                  _showRatingDialog(context, cubit);
                } else {
                  errorGetBar('you_do_review_in_this_user'.tr());
                }
              }
            },
            color: AppColors.white,
            itemBuilder: (_) => [
              PopupMenuItem(value: 'rate', child: Text('rate'.tr())),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTabContent(ProfileCubit cubit, BuildContext context) {
    final isMyProfile = cubit.user?.data?.id.toString() == widget.model.id;

    switch (cubit.selectedIndex) {
      case 0:
        return AboutWidget(profileModel: cubit.profileModel);

      case 1:
        return BlocBuilder<FeedsCubit,FeedsState>(
          builder: (context,state) {
            return _buildPostsSection(cubit);
          }
        );

      case 2:
        if (isMyProfile) {
          return BlocBuilder<CastingCubit,CastingState>(
            builder: (context,state) {
              return _buildGigsSection(context);
            }
          );
        } else {
          return _buildReviewsSection(cubit);
        }

      case 3:
        return _buildReviewsSection(cubit);

      default:
        return const SizedBox();
    }
  }

  Widget _buildPostsSection(ProfileCubit cubit) {
    final timeline = cubit.profileModel?.data?.timeline ?? [];

    return Expanded(
      child: ListView.builder(
        itemCount: timeline.isEmpty ? 2 : timeline.length + 1,
        itemBuilder: (context, index) {
          if (index == 0) {
            return const WhatDoYouWant();
          }
          if (timeline.isEmpty) {
            return Center(
              child: Text(
                "no_data".tr(),
                style: TextStyle(color: AppColors.black),
              ),
            );
          }
          final post = timeline[index - 1];
          return PostProfileWidget(
            profileCubit: cubit,
            postId: post.id.toString(),
            post: post,
            index: index - 1,
          );
        },
      ),
    );
  }

  Widget _buildGigsSection(BuildContext context) {
    final castingCubit = context.read<CastingCubit>();
    final gigs = context.read<ProfileCubit>().profileModel?.data?.myGigs ?? [];

    if (gigs.isEmpty) {
      return Center(
          child:
              Text("no_data".tr(), style: TextStyle(color: AppColors.black)));
    }

    return Expanded(
      child: SingleChildScrollView(
        child: ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: gigs.length,
          itemBuilder: (context, index) {
            return GigsWidget(
              index: index,
              isFromDetails: false,
              eventAndGigsModel: gigs[index],
              castingCubit: castingCubit,
            );
          },
        ),
      ),
    );
  }

  Widget _buildReviewsSection(ProfileCubit cubit) {
    final reviews = cubit.profileModel?.data?.reviews ?? [];

    if (reviews.isEmpty) {
      return Center(
          child:
              Text("no_data".tr(), style: TextStyle(color: AppColors.black)));
    }

    return Expanded(
      child: Container(
        decoration: BoxDecoration(color: AppColors.grayLite),
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: reviews.length,
          itemBuilder: (context, index) {
            final review = reviews[index];
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(color: AppColors.white),
                child: Padding(
                  padding: EdgeInsets.only(
                      bottom: 10.h, top: 10.h, right: 10.w, left: 10.w),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                children: [
                                  SizedBox(
                                    height: 40.h,
                                    width: 40.w,
                                    child:
                                        Image.asset(ImageAssets.profileImage),
                                  ),
                                ],
                              ),
                              SizedBox(width: 8.w),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  AutoSizeText(review.user?.name ?? "",
                                      style: getMediumStyle(fontSize: 18.sp)),
                                  AutoSizeText(review.user?.headline ?? "",
                                      style: getRegularStyle(
                                          fontSize: 16.sp,
                                          color: AppColors.grayLight)),
                                ],
                              ),
                            ],
                          ),
                          RatingStars(
                            maxValueVisibility: false,
                            valueLabelVisibility: false,
                            axis: Axis.horizontal,
                            value: double.tryParse(review.review.toString()) ??
                                0.0,
                            starCount: 5,
                            starSize: 20,
                            starOffColor: const Color(0xffe7e8ea),
                            starColor: Colors.yellow,
                          ),
                        ],
                      ),
                      Text(
                        review.comment ?? "",
                        style:
                            TextStyle(color: AppColors.black.withOpacity(0.5)),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildAddGigButton(BuildContext context) {
    return Positioned(
      bottom: 20.h,
      right: 16.w,
      child: InkWell(
        onTap: () async {
          final user = await Preferences.instance.getUserModel();
          if (user.data?.token == null) {
            checkLogin(context);
          } else {
            Navigator.pushNamed(context, Routes.newGigsRoute);
          }
        },
        child: SvgPicture.asset(AppIcons.addIcon),
      ),
    );
  }

  void _showRatingDialog(BuildContext context, ProfileCubit cubit) {
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, dialogSetState) {
            return AlertDialog(
              title: Text('enter_your_rating_and_comment'.tr()),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  RatingStars(
                    axis: Axis.horizontal,
                    value: cubit.review ?? 0.0,
                    onValueChanged: (v) {
                      dialogSetState(() {
                        cubit.review = v;
                      });
                    },
                    maxValueVisibility: false,
                    valueLabelVisibility: false,
                    starCount: 5,
                    starSize: 30,
                    maxValue: 5,
                    starSpacing: 4,
                    starOffColor: AppColors.gray,
                    starColor: Colors.yellow,
                  ),
                  const SizedBox(height: 16),
                  CustomTextField(
                    controller: cubit.commentController,
                    hintText: 'write_comment_here'.tr(),
                    maxLines: 3,
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: Navigator.of(context).pop,
                  child: Text('cancel'.tr()),
                ),
                TextButton(
                  onPressed: () {
                    if ((cubit.review ?? 0) <= 0) {
                      errorGetBar('please_enter_rating'.tr());
                      return;
                    } else if (cubit.commentController.text == '') {
                      errorGetBar('please_enter_comment'.tr());
                      return;
                    }
                    cubit.addReview(
                      context: context,
                      userId: cubit.profileModel?.data?.id.toString() ?? "",
                    );
                    Navigator.of(context).pop();
                  },
                  child: Text('send'.tr()),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void setState(VoidCallback fn) {
    if (mounted) {
      fn();
    }
  }
}
