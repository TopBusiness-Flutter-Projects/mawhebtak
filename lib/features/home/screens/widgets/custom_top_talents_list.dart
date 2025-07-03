import 'package:flutter_svg/flutter_svg.dart';
import 'package:mawhebtak/config/routes/app_routes.dart';
import 'package:mawhebtak/features/events/screens/details_event_screen.dart';
import 'package:mawhebtak/features/home/cubits/home_cubit/home_cubit.dart';
import 'package:mawhebtak/features/home/cubits/home_cubit/home_state.dart';
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
    return BlocBuilder<HomeCubit,HomeState>(
      builder: (context,state) {
        return BlocBuilder<TopTalentsCubit, TopTalentsState>(
            builder: (context, state) {
          return GestureDetector(
             onTap: () {
               Navigator.pushNamed(context, Routes.profileRoute,
                 arguments: DeepLinkDataModel(
               id: widget.topTalentsData?.id.toString() ??
                   '',
               isDeepLink: false),
               );
             },
            child: Padding(
              padding: EdgeInsetsDirectional.only(start: 10.w, end: 5.w),
              child:  Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(16.r),
                  child: Stack(
                    children: [
                      // صورة الشبكة
                      SizedBox(
                        height: 200.h,
                        width: 198.w,
                        child: Image.network(
                          widget.topTalentsData?.image ?? "your_default_base64_image",
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              Image.asset(ImageAssets.imagePicked, fit: BoxFit.cover),
                        ),
                      ),

                      // زر الإزالة
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
                                context: context,
                                index: widget.index,
                                unwantedUserId: widget.topTalentsData?.id.toString() ?? "0",
                              );
                            }
                          },
                          child: SvgPicture.asset(AppIcons.removeIcon),
                        ),
                      ),

                      // ✅ النص فوق الصورة في الأسفل
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(8.w),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Colors.black.withOpacity(0.7),
                                Colors.transparent,
                              ],
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                            ),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                widget.topTalentsData?.name ?? "",
                                style: getSemiBoldStyle(color: Colors.white, fontSize: 12.sp),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.center,
                              ),
                              if (widget.topTalentsData?.headline != null)
                                Text(
                                  widget.topTalentsData?.headline ?? "-",
                                  style: getRegularStyle(color: Colors.white70, fontSize: 11.sp),
                                  maxLines: 1,
                                  textAlign: TextAlign.center,
                                ),
                              SizedBox(height: 4.h),
                              Text(
                                "${widget.topTalentsData?.followersCount ?? 0} ${'followers'.tr()}",
                                style: getMediumStyle(color: Colors.white70, fontSize: 11.sp),
                              ),
                              SizedBox(height: 4.h),
                              CustomContainerButton(
                                onTap: () async {
                                  final user = await Preferences.instance.getUserModel();
                                  if (user.data?.token == null) {
                                    checkLogin(context);
                                  } else {
                                    widget.topTalentsCubit?.followAndUnFollow(
                                      context,
                                      item: widget.topTalentsData,
                                      followedId: widget.topTalentsData?.id.toString() ?? "",
                                    );
                                  }
                                },
                                height: 30.h,
                                title: widget.topTalentsData?.isIFollow == true
                                    ? "un_follow".tr()
                                    : "follow".tr(),
                                color: widget.topTalentsData?.isIFollow == true
                                    ? AppColors.primary
                                    : AppColors.white,
                                textColor: widget.topTalentsData?.isIFollow == true
                                    ? Colors.white
                                    : AppColors.primary,
                                width: 120.w,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

          ),
          );
        });
      }
    );
  }
}
