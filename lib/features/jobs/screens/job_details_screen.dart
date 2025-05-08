import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mawhebtak/core/exports.dart';
import 'package:mawhebtak/core/widgets/custom_button.dart';
import 'package:mawhebtak/features/assistant/cubit/assistant_cubit.dart';
import 'package:mawhebtak/features/assistant/cubit/assistant_state.dart';

class JobDetailsScreen extends StatefulWidget {
  const JobDetailsScreen({super.key});

  @override
  State<JobDetailsScreen> createState() => _JobDetailsScreenState();
}

class _JobDetailsScreenState extends State<JobDetailsScreen> {
  bool isFav = false;

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<AssistantCubit>();
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light.copyWith(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
      child: Scaffold(
        backgroundColor: AppColors.grayLite,
        body: Column(
          children: [
            Expanded(
              child: ListView(
                padding: EdgeInsets.only(top: 10.h),
                children: [
                  CustomSimpleAppbar(
                    title: 'job_details'.tr(),
                    isActionButton: true,
                  ),
                  BlocBuilder<AssistantCubit,AssistantState>(
                    builder: (context,state) {
                      return Column(
                        children: [
                          20.h.verticalSpace,
                          _buildJobInfoCard(),
                          20.h.verticalSpace,
                          _buildPostedByCard(),
                          20.h.verticalSpace,
                          _buildJobDescriptionCard(),
                          30.h.verticalSpace,
                        ],
                      );
                    }
                  ), // Extra space before button
                ],
              ),
            ),
            // Button fixed at the bottom
            CustomButton(title: "apply_for_this_job".tr()),
          ],
        ),
      ),
    );
  }

  Widget _buildJobInfoCard() {
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
                        "job_title_sample".tr(),
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
                Text(
                  "job_company_sample".tr(),
                  style: getMediumStyle(
                    fontSize: 13.sp,
                    color: AppColors.secondPrimary,
                  ),
                ),
                10.h.verticalSpace,

                // Location and date
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "location_sample".tr(),
                      style: getMediumStyle(
                        fontSize: 13.sp,
                        color: AppColors.grayDate,
                      ),
                    ),
                    Text(
                      "job_date_sample".tr(),
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
                      "5000 L.E",
                      style: getMediumStyle(
                        fontSize: 14.sp,
                        color: AppColors.secondPrimary,
                      ),
                    ),
                    5.w.horizontalSpace,
                    Icon(Icons.arrow_forward, size: 20.sp, color: AppColors.blackLite),
                    5.w.horizontalSpace,
                    Text(
                      "7000 L.E",
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


  Widget _buildPostedByCard() {
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
              Image.asset(ImageAssets.profileImage, width: 50, height: 50),
              10.w.horizontalSpace,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "poster_name_sample".tr(), // e.g., "Ahmed Mokhtar"
                    style: getMediumStyle(fontSize: 14.sp),
                  ),
                  5.h.verticalSpace,
                  Text(
                    "poster_role_sample".tr(), // e.g., "Talent / Actor Expert"
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

  Widget _buildJobDescriptionCard() {
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
          10.h.verticalSpace,
          Text(
            "job_description_sample".tr(),
            style: getMediumStyle(
              fontSize: 13.sp,
              color: AppColors.blackLite.withOpacity(0.7),
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