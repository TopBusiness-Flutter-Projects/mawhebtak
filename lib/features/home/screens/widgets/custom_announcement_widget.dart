import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mawhebtak/core/widgets/custom_container_with_shadow.dart';
import 'package:mawhebtak/features/home/data/models/home_model.dart';

import '../../../../config/routes/app_routes.dart';
import '../../../../core/exports.dart';

class CustomAnnouncementWidget extends StatefulWidget {
  const CustomAnnouncementWidget({
    super.key,
    this.isLeftPadding,
    this.isRightPadding,
    this.isAnnouncements,
    this.isFav, this.announcement,
  });

  final bool? isLeftPadding;
  final bool? isRightPadding;
  final bool? isAnnouncements;
  final bool? isFav;
  final Announcement? announcement;

  @override
  State<CustomAnnouncementWidget> createState() => _CustomAnnouncementWidgetState();
}

class _CustomAnnouncementWidgetState extends State<CustomAnnouncementWidget> {
   bool? isFav=false;

  @override
  void initState() {
    super.initState();
    isFav = widget.isFav ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.only(
        start: widget.isAnnouncements ?? false ? 0.0 : widget.isLeftPadding ?? false ? 16.w : 10.w,
        end: widget.isAnnouncements ?? false ? 0.0 : widget.isRightPadding ?? false ? 16.w : 0.0,
      ),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, Routes.detailsAnnouncementScreen);
        },
        child: CustomContainerWithShadow(
          isShadow: false,
          reduis: widget.isAnnouncements ?? false ? 0.r : 8.r,
          width: widget.isAnnouncements ?? false ? double.infinity : 299.w,
          child: Padding(
            padding: EdgeInsets.all(widget.isAnnouncements ?? false ? 20.0 : 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 40.h,
                      width: 40.w,
                      child: Image.asset(ImageAssets.profileImage),
                    ),
                    SizedBox(width: 8.w),
                    widget.isAnnouncements ?? false
                        ? Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AutoSizeText(widget.announcement?.user?.name ?? "Ahmed Mokhtar", style: getMediumStyle(fontSize: 16.sp)),
                              AutoSizeText(
                                widget.announcement?.user?.headline ?? "Talent / Actor Expert",
                                style: getRegularStyle(fontSize: 14.sp, color: AppColors.grayLight),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    isFav = !isFav!;
                                  });
                                },
                                child: Icon(
                                  isFav! ? Icons.favorite : Icons.favorite_border,
                                  size: 20.sp,
                                  color: isFav! ? AppColors.primary : AppColors.lbny.withOpacity(0.5),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SvgPicture.asset(AppIcons.settingIcon),
                              ),
                            ],
                          )
                        ],
                      ),
                    )
                        : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AutoSizeText(widget.announcement?.user?.name ?? "Ahmed Mokhtar", style: getMediumStyle(fontSize: 16.sp)),
                        AutoSizeText(
                          widget.announcement?.user?.headline ?? "Talent / Actor Expert",
                          style: getRegularStyle(fontSize: 14.sp, color: AppColors.grayLight),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 10.h),
                (widget.announcement?.image == null)?

                ClipRRect(
                  borderRadius: BorderRadius.circular(16.r),
                  child: SizedBox(
                    child: Image.asset(
                      ImageAssets.tasweerPhoto,
                      fit: BoxFit.contain,
                    ),
                  ),
                ):
                ClipRRect(
                  borderRadius: BorderRadius.circular(16.r),
                  child: SizedBox(

                    child: Image.network(
                      widget.announcement?.image ?? "",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(height: 8.h),
                AutoSizeText(widget.announcement?.title ?? "Offer 20% on accessories photographs", style: getSemiBoldStyle(fontSize: 14.sp, color: AppColors.grayDark)),
                SizedBox(height: 5.h),
                Row(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          SvgPicture.asset(AppIcons.locationIcon),
                          SizedBox(width: 3.w),
                          Expanded(
                            child: Text(
                              widget.announcement?.location ?? "Cairo, Nasr City",
                              style: getRegularStyle(color: AppColors.grayLight, fontSize: 14.sp),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        SvgPicture.asset(AppIcons.dollarSign),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: AutoSizeText(
                            "${widget.announcement?.price} L.E",
                            style: getRegularStyle(fontSize: 14.sp, color: AppColors.blueLight),
                          ),
                        )
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
