import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mawhebtak/features/feeds/screens/widgets/image_view_file.dart';
import 'package:mawhebtak/features/feeds/screens/widgets/video_player_widget.dart';
import 'package:mawhebtak/features/home/data/models/request_gigs_model.dart';

import '../../../../config/routes/app_routes.dart';
import '../../../../core/exports.dart';
import '../../../../core/widgets/custom_button.dart';

class GigsWidget extends StatelessWidget {
  GigsWidget({
    super.key,
    this.isWithButton,
    this.eventAndGigsModel,
  });
  bool? isWithButton = false;
  final EventAndGigsModel? eventAndGigsModel;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, Routes.gigsDetailsScreen);
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, Routes.gigsDetailsScreen);
                },
                child: ((eventAndGigsModel?.media?.isNotEmpty ?? false))
                    ? SizedBox(
                        height: getHeightSize(context) / 3.7,
                        child: PageView.builder(
                          itemCount: eventAndGigsModel?.media?.length ?? 0,
                          itemBuilder: (context, index) {
                            final media = eventAndGigsModel?.media?[index];
                            if (media?.extension == 'video') {
                              return VideoPlayerWidget(
                                  videoUrl: media?.file ?? "");
                            } else {
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => ImageFileView(
                                              isNetwork: true,
                                              image: eventAndGigsModel
                                                      ?.media?[index].file ??
                                                  "")));
                                },
                                child: Image.network(
                                  eventAndGigsModel?.media?[index].file ?? '',
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                  errorBuilder: (context, error, stackTrace) =>
                                      Image.asset(ImageAssets.appIconWhite),
                                ),
                              );
                            }
                          },
                        ),
                      )
                    : const SizedBox(),
              )
            ],
          ),
          5.h.verticalSpace,
          Padding(
            padding: EdgeInsets.only(left: 15.0.w, right: 15.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  eventAndGigsModel?.title ?? "",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 20.sp,
                  ),
                ),
                5.h.verticalSpace,
                Text(
                  eventAndGigsModel?.description ?? "",
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 18.sp,
                    color: AppColors.blackLite,
                  ),
                ),
                10.h.verticalSpace,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        SvgPicture.asset(AppIcons.locationIcon),
                        5.w.horizontalSpace,
                        Text(
                          eventAndGigsModel?.location ?? "",
                          style: TextStyle(
                              color: AppColors.grayDarkkk,
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w400),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        SvgPicture.asset(AppIcons.dollar),
                        5.w.horizontalSpace,
                        Text(
                          eventAndGigsModel?.price.toString() ?? "",
                          style: TextStyle(
                              color: AppColors.primary,
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w400),
                        )
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          10.verticalSpace,
          if (isWithButton ?? false)
            Padding(
                padding: EdgeInsets.only(bottom: 10.h),
                child: CustomButton(
                  title: "request_this_gigs".tr(),
                )),
        ],
      ),
    );
  }
}
