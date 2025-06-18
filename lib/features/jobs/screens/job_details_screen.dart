import 'package:flutter_svg/flutter_svg.dart';
import 'package:mawhebtak/config/routes/app_routes.dart';
import 'package:mawhebtak/core/exports.dart';
import 'package:mawhebtak/core/widgets/custom_button.dart';
import 'package:mawhebtak/features/events/screens/details_event_screen.dart';
import 'package:mawhebtak/features/jobs/cubit/jobs_cubit.dart';
import 'package:mawhebtak/features/jobs/cubit/jobs_state.dart';

import '../../../core/preferences/preferences.dart';
import '../../../core/utils/check_login.dart';
import '../../chat/screens/message_screen.dart';
import '../../events/screens/widgets/custom_media_view.dart';

class JobDetailsScreen extends StatefulWidget {
  const JobDetailsScreen(
      {super.key, required this.userJopId, required this.index});
  final String userJopId;
  final int index;

  @override
  State<JobDetailsScreen> createState() => _JobDetailsScreenState();
}

class _JobDetailsScreenState extends State<JobDetailsScreen> {
  @override
  void initState() {
    context
        .read<JobsCubit>()
        .getUserJopDetailsData(userJopId: widget.userJopId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var jobDetailsCubit = context.read<JobsCubit>();

    return BlocBuilder<JobsCubit, JobsState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColors.grayLite,
          body: Column(
            children: [
              Expanded(
                child: ListView(
                  children: [
                    CustomSimpleAppbar(
                      title: 'job_details'.tr(),
                      isActionButton: false,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        (jobDetailsCubit.userJobDetailsModel?.data?.media ==
                                    null ||
                                jobDetailsCubit
                                    .userJobDetailsModel!.data!.media!.isEmpty)
                            ? Container()
                            : MediaCarousel(
                                mediaList: jobDetailsCubit
                                        .userJobDetailsModel?.data?.media ??
                                    []),
                        20.h.verticalSpace,
                        _buildJobInfoCard(),
                        20.h.verticalSpace,
                        _buildPostedByCard(cubit: jobDetailsCubit),
                        20.h.verticalSpace,
                        _buildJobDescriptionCard(cubit: jobDetailsCubit),
                        30.h.verticalSpace,
                      ],
                    ), // Extra space before button
                  ],
                ),
              ),
              // Button fixed at the bottom
              jobDetailsCubit.userJobDetailsModel?.data?.isMine == true
                  ? Container()
                  : CustomButton(
                      onTap: () async {
                        final user = await Preferences.instance.getUserModel();
                        if (user.data?.token == null) {
                          checkLogin(context);
                        } else {
                          Navigator.pushNamed(context, Routes.messageRoute,
                              arguments: MainUserAndRoomChatModel(
                                receiverId: jobDetailsCubit
                                    .userJobDetailsModel?.data?.poster?.id
                                    ?.toString(),
                                chatName: jobDetailsCubit
                                    .userJobDetailsModel?.data?.poster?.name
                                    ?.toString(),
                              ));
                        }
                      },
                      title: "apply_for_this_job".tr()),
            ],
          ),
        );
      },
    );
  }

  Widget _buildJobInfoCard() {
    return _buildWhiteCard(
      child: BlocBuilder<JobsCubit, JobsState>(builder: (context, state) {
        var cubit = context.read<JobsCubit>();
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Icon alone on the left
            SvgPicture.asset(
              AppIcons.bagIcon,
              width: 40.w,
              height: 40.h,
            ),
            10.w.horizontalSpace,
            // Everything else in one column
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Job title and fav icon
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Text(
                          cubit.userJobDetailsModel?.data?.title ?? "",
                          style: getMediumStyle(fontSize: 14.sp),
                        ),
                      ),
                      InkWell(
                          onTap: () async {
                            final user =
                                await Preferences.instance.getUserModel();
                            if (user.data?.token == null) {
                              checkLogin(context);
                            } else {
                              print(
                                  "the is fav ${cubit.userJobDetailsModel?.data?.isFav}");
                              cubit.toggleFavorite(
                                  context: context,
                                  index: widget.index,
                                  userJopId: widget.userJopId.toString() ?? "");
                            }
                          },
                          child: Icon(
                            cubit.userJobDetailsModel?.data?.isFav == true
                                ? Icons.favorite
                                : Icons.favorite_border,
                            size: 20.sp,
                            color:
                                cubit.userJobDetailsModel?.data?.isFav == true
                                    ? AppColors.primary
                                    : AppColors.darkGray.withOpacity(0.5),
                          )),
                    ],
                  ),
                  6.h.verticalSpace,

                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Text(
                          cubit.userJobDetailsModel?.data?.location ?? "",
                          style: getMediumStyle(
                            fontSize: 13.sp,
                            color: AppColors.grayDate,
                          ),
                        ),
                      ),
                      Text(
                        cubit.userJobDetailsModel?.data?.deadline ?? "",
                        style: getMediumStyle(
                          fontSize: 13.sp,
                          color: AppColors.grayDate,
                        ),
                      ),
                    ],
                  ),
                  10.h.verticalSpace,

                  // Price range title
                  Text(
                    "price_range".tr(),
                    style: getMediumStyle(fontSize: 14.sp),
                  ),
                  8.h.verticalSpace,

                  // Price range values
                  Row(
                    children: [
                      Text(
                        cubit.userJobDetailsModel?.data?.priceStartAt ?? "",
                        style: getMediumStyle(
                          fontSize: 14.sp,
                          color: AppColors.secondPrimary,
                        ),
                      ),
                      5.w.horizontalSpace,
                      Icon(Icons.arrow_forward,
                          size: 20.sp, color: AppColors.blackLite),
                      5.w.horizontalSpace,
                      Text(
                        cubit.userJobDetailsModel?.data?.priceEndAt ?? "",
                        style: getMediumStyle(
                          fontSize: 14.sp,
                          color: AppColors.secondPrimary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }

  Widget _buildPostedByCard({required JobsCubit cubit}) {
    return _buildWhiteCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "posted_by".tr(),
            style: getMediumStyle(
              fontSize: 14.sp,
              color: AppColors.grayDate,
            ),
          ),
          10.h.verticalSpace,
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(
                  context,
                  Routes.profileRoute,
                  arguments: DeepLinkDataModel(
                  id: widget.userJopId,
              isDeepLink: false));
            },
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                (cubit.userJobDetailsModel?.data?.poster?.image == null)
                    ? CircleAvatar(
                        radius: 25.r,
                        backgroundImage:
                            const AssetImage(ImageAssets.profileImage))
                    : CircleAvatar(
                        radius: 25.r,
                        backgroundImage: NetworkImage(
                          cubit.userJobDetailsModel?.data?.poster?.image ?? "",
                        )),
                10.w.horizontalSpace,
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        cubit.userJobDetailsModel?.data?.poster?.name ?? "",
                        style: getMediumStyle(fontSize: 14.sp),
                      ),
                      5.h.verticalSpace,
                      Text(
                        cubit.userJobDetailsModel?.data?.poster?.headline ?? "-",
                        maxLines: 1,
                        style: getMediumStyle(
                          fontSize: 13.sp,
                          color: AppColors.grayDate,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildJobDescriptionCard({required JobsCubit cubit}) {
    return _buildWhiteCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "job_description".tr(),
            style: getMediumStyle(
              fontSize: 14.sp,
              color: AppColors.blackLite,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 10.h),
            child: Text(
              cubit.userJobDetailsModel?.data?.description ?? "",
              style: getMediumStyle(
                fontSize: 13.sp,
                color: AppColors.blackLite.withOpacity(0.7),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWhiteCard({required Widget child}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(10.r),
        ),
        padding: EdgeInsets.all(15.sp),
        child: child,
      ),
    );
  }
}
