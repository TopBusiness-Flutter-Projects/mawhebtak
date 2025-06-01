import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mawhebtak/core/exports.dart';
import 'package:mawhebtak/core/widgets/custom_button.dart';
import 'package:mawhebtak/features/jobs/cubit/jobs_cubit.dart';
import 'package:mawhebtak/features/jobs/cubit/jobs_state.dart';

class JobDetailsScreen extends StatefulWidget {
  const JobDetailsScreen({super.key, required this.userJopId});
  final String userJopId;
  @override
  State<JobDetailsScreen> createState() => _JobDetailsScreenState();
}

class _JobDetailsScreenState extends State<JobDetailsScreen> {
  bool isFav = false;
  @override
  void initState() {
    context
        .read<JobsCubit>()
        .getUserJopDetailsData(userJopId: widget.userJopId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.grayLite,
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                CustomSimpleAppbar(
                  title: 'job_details'.tr(),
                  isActionButton: true,
                ),
                BlocBuilder<JobsCubit, JobsState>(builder: (context, state) {
                  var jobDetailsCubit = context.read<JobsCubit>();
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      20.h.verticalSpace,
                      _buildJobInfoCard(job: jobDetailsCubit),
                      20.h.verticalSpace,
                      _buildPostedByCard(job: jobDetailsCubit),
                      20.h.verticalSpace,
                      _buildJobDescriptionCard(job: jobDetailsCubit),
                      30.h.verticalSpace,
                    ],
                  );
                }), // Extra space before button
              ],
            ),
          ),
          // Button fixed at the bottom
          CustomButton(title: "apply_for_this_job".tr()),
        ],
      ),
    );
  }

  Widget _buildJobInfoCard({required JobsCubit job}) {
    return _buildWhiteCard(
      child: Row(
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
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Job title and fav icon
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        job.userJopDetailsModel?.data?.title ?? "",
                        style: getMediumStyle(fontSize: 14.sp),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    InkWell(
                      onTap: () => setState(() => isFav = !isFav),
                      child: Icon(
                        isFav ? Icons.favorite : Icons.favorite_border,
                        size: 20.sp,
                        color: isFav
                            ? AppColors.primary
                            : AppColors.darkGray.withOpacity(0.5),
                      ),
                    ),
                  ],
                ),
                6.h.verticalSpace,

                // Company name
                // Text(
                //   "job_company_sample".tr(),
                //   style: getMediumStyle(
                //     fontSize: 13.sp,
                //     color: AppColors.secondPrimary,
                //   ),
                // ),
                // 10.h.verticalSpace,

                // Location and date
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      job.userJopDetailsModel?.data?.location ?? "",
                      style: getMediumStyle(
                        fontSize: 13.sp,
                        color: AppColors.grayDate,
                      ),
                    ),
                    Text(
                      job.userJopDetailsModel?.data?.deadline ?? "",
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
                      job.userJopDetailsModel?.data?.priceStartAt ?? "",
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
                      job.userJopDetailsModel?.data?.priceEndAt ?? "",
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
      ),
    );
  }

  Widget _buildPostedByCard({required JobsCubit job}) {
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
          Row(
            children: [
              (job.userJopDetailsModel?.data?.poster?.image == null)
                  ? CircleAvatar(
                      radius: 25.r,
                      backgroundImage:
                          const AssetImage(ImageAssets.profileImage))
                  : CircleAvatar(
                      radius: 25.r,
                      backgroundImage: NetworkImage(
                        job.userJopDetailsModel?.data?.poster?.image ?? "",
                      )),
              10.w.horizontalSpace,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    job.userJopDetailsModel?.data?.poster?.name ?? "",
                    style: getMediumStyle(fontSize: 14.sp),
                  ),
                  5.h.verticalSpace,
                  Text(
                    job.userJopDetailsModel?.data?.poster?.headline ?? "",
                    style: getMediumStyle(
                      fontSize: 13.sp,
                      color: AppColors.grayDate,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildJobDescriptionCard({required JobsCubit job}) {
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
          Row(
            children: [
              Padding(
                padding:  EdgeInsets.only(top: 10.h),
                child: SizedBox(
                  width: 350.w,
                  child: Text(
                    job.userJopDetailsModel?.data?.description ?? "",
                    maxLines: 5,
                    overflow: TextOverflow.ellipsis,
                    style: getMediumStyle(
                      fontSize: 13.sp,
                      color: AppColors.blackLite.withOpacity(0.7),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildWhiteCard({required Widget child}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Container(
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
