import 'package:flutter_svg/flutter_svg.dart';
import 'package:mawhebtak/features/home/cubits/top_talents_cubit/top_talents_cubit.dart';
import 'package:mawhebtak/features/home/data/models/home_model.dart';
import '../../../../core/exports.dart';
import '../../../../core/preferences/preferences.dart';
import '../../../../core/utils/check_login.dart';
import 'follow_button.dart';

class CustomTopTalentsList extends StatefulWidget {
  const CustomTopTalentsList(
      {super.key,
      required this.topTalentsData,
      this.topTalentsCubit,
      required this.index});

  final TopTalent? topTalentsData;
  final TopTalentsCubit? topTalentsCubit;
  final int index;

  @override
  State<CustomTopTalentsList> createState() => _CustomTopTalentsListState();
}

class _CustomTopTalentsListState extends State<CustomTopTalentsList> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TopTalentsCubit, TopTalentsState>(
        builder: (context, state) {
      return Padding(
        padding: EdgeInsetsDirectional.only(start: 10.w, end: 5.w),
        child: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16.r),
              child: Stack(
                children: [
                  SizedBox(
                    height: 200.h,
                    width: 198.w,
                    child: Image.network(
                        widget.topTalentsData?.image ??
                            "data:image/png;base64,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",
                        fit: BoxFit.cover,
                        height: 200.h,
                        width: 198.w,
                        errorBuilder: (context, error, stackTrace) =>
                            Image.asset(
                              ImageAssets.imagePicked,
                              fit: BoxFit.contain,
                              height: 200.h,
                              width: 198.w,
                            )),
                  ),
                  // Now inside the image container
                  Positioned(
                    top: 6.h,
                    right: 8.w,
                    child: GestureDetector(
                      onTap: () async {
                        final user = await Preferences.instance.getUserModel();
                        if (user.data?.token == null) {
                          checkLogin(context);
                        } else {
                          widget.topTalentsCubit?.hideTopTalent(
                              index: widget.index,
                              unwantedUserId:
                                  widget.topTalentsData?.id.toString() ?? "0");
                        }
                      },
                      child: SvgPicture.asset(AppIcons.removeIcon),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 20.h,
              child: Padding(
                padding: EdgeInsets.only(left: 10.w, right: 10.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      widget.topTalentsData?.name ?? "",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: getSemiBoldStyle(
                          color: AppColors.white, fontSize: 12.sp),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      widget.topTalentsData?.headline ??
                          "Talent / Actor Expert",
                      maxLines: 1,
                      style: getRegularStyle(
                          color: AppColors.grayText, fontSize: 13.sp),
                      textAlign: TextAlign.center,
                    ),
                    10.verticalSpace,
                    Text(
                      "${widget.topTalentsData?.followersCount ?? 20}  followers",
                      maxLines: 1,
                      style: getMediumStyle(
                          color: AppColors.grayText, fontSize: 13.sp),
                      textAlign: TextAlign.center,
                    ),
                    5.verticalSpace,
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.0.w),
                        child: CustomContainerButton(
                          onTap: () async {
                            final user =
                                await Preferences.instance.getUserModel();
                            if (user.data?.token == null) {
                              checkLogin(context);
                            } else {
                              widget.topTalentsCubit?.followAndUnFollow(context,
                                  item: widget.topTalentsData,
                                  followedId:
                                      widget.topTalentsData?.id.toString() ??
                                          "");

                              print(
                                  "following${widget.topTalentsData?.isIFollow}");
                            }
                          },
                          height: 35.h,
                          title: widget.topTalentsData?.isIFollow == true
                              ? "un_follow".tr()
                              : "follow".tr(),
                          color: widget.topTalentsData?.isIFollow == true
                              ? AppColors.primary
                              : AppColors.white,
                          textColor: widget.topTalentsData?.isIFollow == true
                              ? AppColors.white
                              : AppColors.primary,
                          width: 138.w,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
