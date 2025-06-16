import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
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
    context.read<ProfileCubit>().loadUserFromPreferences();
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
            body: (state is GetProfileStateLoading &&
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
                            id: widget.model.id,
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
                                      Container(
                                        height: 40.h,
                                        width: 40.w,
                                        decoration: BoxDecoration(
                                          color: AppColors.white,
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          border: Border.all(
                                            color: AppColors.secondPrimary,
                                          ),
                                        ),
                                        child: Icon(
                                          Icons.more_vert_sharp,
                                          color: AppColors.secondPrimary,
                                        ),
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
                                  child: (castingCubit
                                              .allGigsModel?.data?.length ==
                                          0)
                                      ? Center(
                                          child: Text("no_data".tr()),
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
                          ] else if (cubit.selectedIndex == 3)
                            ...[]
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
          ),
        );
      },
    );
  }
}
