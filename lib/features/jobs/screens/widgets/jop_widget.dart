import 'package:flutter_svg/flutter_svg.dart';
import 'package:mawhebtak/config/routes/app_routes.dart';
import 'package:mawhebtak/core/exports.dart';
import 'package:mawhebtak/features/jobs/cubit/jobs_cubit.dart';
import 'package:mawhebtak/features/jobs/data/model/user_jop_model.dart';

import '../../../../core/preferences/preferences.dart';
import '../../../../core/utils/check_login.dart';

class JobWidget extends StatefulWidget {
  const JobWidget({
    super.key,
    this.userJop,
    required this.jobsCubit,
    required this.index,
  });
  final UserJobModelData? userJop;
  final JobsCubit jobsCubit;
  final int index;
  @override
  State<JobWidget> createState() => _JobWidgetState();
}

class _JobWidgetState extends State<JobWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, Routes.jobDetailsRoute, arguments: {
          'userJopId': widget.userJop?.id.toString() ?? 0,
          'index': widget.index,
          "isDeepLink": false
        });
      },
      child: Padding(
        padding: EdgeInsets.only(bottom: 10.h),
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.white,
          ),
          child: Padding(
            padding: EdgeInsets.only(
              bottom: 10.h,
              left: 20.w,
              right: 20.w,
              top: 10.h,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SvgPicture.asset(AppIcons.bagIcon),
                10.w.horizontalSpace,
                Expanded(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Flexible(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        widget.userJop?.title ?? "",
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: getMediumStyle(fontSize: 14.sp),
                                      ),
                                      10.h.verticalSpace,
                                      // Text(
                                      //   widget.userJop?.,
                                      //   style: getMediumStyle(
                                      //       fontSize: 13.sp,
                                      //       color: AppColors.secondPrimary),
                                      // ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          InkWell(
                              onTap: () async {
                                final user =
                                    await Preferences.instance.getUserModel();
                                if (user.data?.token == null) {
                                  checkLogin(context);
                                } else {
                                  widget.jobsCubit.toggleFavorite(
                                      context: context,
                                      index: widget.index,
                                      userJopId:
                                          widget.userJop?.id.toString() ?? "");
                                }
                              },
                              child: Icon(
                                widget.userJop?.isFav == true
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                size: 20.sp,
                                color: widget.userJop?.isFav == true
                                    ? AppColors.primary
                                    : AppColors.darkGray.withOpacity(0.5),
                              )),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Text(
                              widget.userJop?.location ?? "",
                              maxLines: 1,
                              style: getMediumStyle(
                                  fontSize: 13.sp, color: AppColors.grayDate),
                            ),
                          ),
                          Text(
                            widget.userJop?.deadline ?? "",
                            style: getMediumStyle(
                                fontSize: 13.sp, color: AppColors.grayDate),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
