import 'package:flutter_svg/flutter_svg.dart';
import 'package:mawhebtak/config/routes/app_routes.dart';
import 'package:mawhebtak/core/exports.dart';
import 'package:mawhebtak/features/jobs/data/model/user_jop_model.dart';

class JobWidget extends StatefulWidget {
  const JobWidget({
    super.key, this.userJop,
  });
  final UserJopData? userJop;
  @override
  State<JobWidget> createState() => _JobWidgetState();
}

class _JobWidgetState extends State<JobWidget> {
  bool isFav = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, Routes.jobDetailsRoute,arguments: widget.userJop?.id.toString() ?? 0);
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

                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [

                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width:250.w,
                                    child: Text(
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      widget.userJop?.title?? "",
                                      style: getMediumStyle(fontSize: 14.sp),
                                    ),
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
                            ],
                          ),
                          InkWell(
                              onTap: () {
                                setState(() {
                                  isFav =
                                  !isFav; // 👈 This toggles the value correctly
                                  print(isFav);
                                });
                              },
                              child: Icon(
                                isFav == true
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                size: 20.sp,
                                color: isFav ? AppColors.primary : AppColors.darkGray.withOpacity(0.5),
                              )),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              maxLines: 1,
                              widget.userJop?.location??"",
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
