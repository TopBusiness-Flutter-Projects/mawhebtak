import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mawhebtak/core/widgets/custom_container_with_shadow.dart';
import 'package:mawhebtak/features/feeds/screens/widgets/image_view_file.dart';
import 'package:mawhebtak/features/feeds/screens/widgets/video_player_widget.dart';
import 'package:mawhebtak/features/home/data/models/home_model.dart';
import '../../../../config/routes/app_routes.dart';
import '../../../../core/exports.dart';

class CustomAnnouncementWidget extends StatefulWidget {
  const CustomAnnouncementWidget({
    super.key,
    this.announcement,
  });
  final Announcement? announcement;

  @override
  State<CustomAnnouncementWidget> createState() =>
      _CustomAnnouncementWidgetState();
}

class _CustomAnnouncementWidgetState extends State<CustomAnnouncementWidget> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, Routes.detailsAnnouncementScreen,arguments:widget.announcement?.id.toString());
      },
      child: Padding(
        padding: EdgeInsetsDirectional.only(
          start: 10.w,
          end:  0.0,
        ),
        child: CustomContainerWithShadow(
          isShadow: false,
          reduis:  8.r,
          width: 299.w,
          child: Padding(
            padding:
                EdgeInsets.all( 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    (widget.announcement?.user?.image == null)?
                    SizedBox(
                      height: 40.h,
                      width: 40.w,
                      child: Image.asset(ImageAssets.profileImage),
                    ):
                    CircleAvatar(
                      backgroundImage: NetworkImage(widget.announcement?.user?.image ?? ""),
                    ),
                    SizedBox(width: 8.w),
                    Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    AutoSizeText(
                                        widget.announcement?.user?.name ??
                                            "",
                                        style: getMediumStyle(fontSize: 16.sp)),
                                    AutoSizeText(
                                      widget.announcement?.user?.headline ??
                                          "",
                                      style: getRegularStyle(
                                          fontSize: 14.sp,
                                          color: AppColors.grayLight),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        setState(() {
                                          widget.announcement?.isFav = !(widget.announcement?.isFav )!;
                                        });
                                      },
                                      child: Icon(
                                       ( widget.announcement?.isFav)!
                                            ? Icons.favorite
                                            : Icons.favorite_border,
                                        size: 20.sp,
                                        color:  ( widget.announcement?.isFav)!
                                            ? AppColors.primary
                                            : AppColors.lbny.withOpacity(0.5),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: SvgPicture.asset(
                                          AppIcons.settingIcon),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          )

                  ],
                ),

                if ((widget.announcement?.media?.isNotEmpty ?? false || widget.announcement?.media == []))
                  SizedBox(
                    height: getHeightSize(context) / 3.7,
                    child: PageView.builder(
                      itemCount: widget.announcement?.media?.length ?? 0,
                      itemBuilder: (context, index) {
                        final media = widget.announcement!.media![index];
                        if (media.extension == 'video') {
                          return VideoPlayerWidget(videoUrl: media.file!);
                        } else {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ImageFileView(
                                          isNetwork: true,
                                          image:
                                          widget.announcement?.media?[index].file ?? "")));
                            },
                            child: Image.network(
                              media.file ?? '',
                              fit: BoxFit.cover,
                              width: double.infinity,
                              errorBuilder: (context, error, stackTrace) =>
                                  Image.asset(ImageAssets.appIconWhite),
                            ),
                          );
                        }
                      },
                    ),
                  ),

                SizedBox(height: 8.h),
                AutoSizeText(
                    widget.announcement?.title ??
                        "",
                    maxLines: 1,
                    style: getSemiBoldStyle(
                        fontSize: 14.sp, color: AppColors.grayDark)),
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
                              widget.announcement?.location ??
                                  "",

                              style: getRegularStyle(
                                  color: AppColors.grayLight, fontSize: 14.sp),
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
                            style: getRegularStyle(
                                fontSize: 14.sp, color: AppColors.blueLight),
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
