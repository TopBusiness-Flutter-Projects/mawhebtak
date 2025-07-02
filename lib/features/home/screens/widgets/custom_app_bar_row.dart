import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mawhebtak/features/events/screens/details_event_screen.dart';
import 'package:mawhebtak/features/main/cubit/cubit.dart';
import '../../../../config/routes/app_routes.dart';
import '../../../../core/exports.dart';
import '../../../../core/preferences/preferences.dart';
import '../../../../core/utils/check_login.dart';
import '../../../main/cubit/state.dart';

class CustomAppBarRow extends StatefulWidget {
  CustomAppBarRow(
      {super.key,
      this.color,
      this.backgroundNotification,
      this.isMore,
      this.colorSearchIcon,
      this.backgroundColorTextFieldSearch,
      this.colorTextFromSearchTextField});
  bool? isMore;
  Color? colorSearchIcon;
  Color? backgroundColorTextFieldSearch;
  Color? colorTextFromSearchTextField;
  Color? backgroundNotification;
  Color? color;

  @override
  State<CustomAppBarRow> createState() => _CustomAppBarRowState();
}

class _CustomAppBarRowState extends State<CustomAppBarRow> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainCubit, MainState>(
      builder: (context, state) {
        var cubit = context.read<MainCubit>();
        return Container(
          width: double.infinity,
          color: widget.color ?? AppColors.white,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      print(
                          'the id from user ${cubit.loginModel?.data?.id?.toString()}');
                      Navigator.pushNamed(
                        context,
                        Routes.profileRoute,
                        arguments: DeepLinkDataModel(
                            id: cubit.loginModel?.data?.id?.toString() ?? "",
                            isDeepLink: false),
                      );
                    },
                    child: SizedBox(
                      height: 40.h,
                      width: 40.w,
                      child: cubit.loginModel?.data?.image == null
                          ? Image.asset(ImageAssets.profileImage)
                          : ClipOval(
                              child: CachedNetworkImage(
                                imageUrl: cubit.loginModel!.data!.image!,
                                fit: BoxFit.cover,
                                placeholder: (context, url) =>
                                    const CircularProgressIndicator(
                                        strokeWidth: 2),
                                errorWidget: (context, url, error) =>
                                    Image.asset(ImageAssets.profileImage),
                              ),
                            ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, Routes.searchRoute);
                      },
                      child: Container(
                          height: 40.h,
                          width: 171.w,
                          decoration: BoxDecoration(
                            color: widget.backgroundColorTextFieldSearch ??
                                AppColors.blackLite,
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          margin: const EdgeInsets.only(left: 10),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("search".tr(),
                                    style: getRegularStyle(
                                        fontSize: 13.sp,
                                        color: widget
                                                .colorTextFromSearchTextField ??
                                            AppColors.white)),
                                const Spacer(),
                                SvgPicture.asset(
                                  AppIcons.searchIcon,
                                  color:
                                      widget.colorSearchIcon ?? AppColors.white,
                                ),
                              ],
                            ),
                          )),
                    ),
                  ),
                  10.w.horizontalSpace,
                  widget.isMore == true
                      ? Container()
                      : Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.0.w),
                          child: InkWell(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, Routes.videoScreenRoute);
                            },
                            child: Container(
                              height: 40.h,
                              width: 40.w,
                              decoration: BoxDecoration(
                                color: AppColors.primary,
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SvgPicture.asset(AppIcons.videoIcon),
                              ),
                            ),
                          ),
                        ),
                  GestureDetector(
                    onTap: () async {
                      final user = await Preferences.instance.getUserModel();
                      if (user.data?.token == null) {
                        checkLogin(context);
                      } else {
                        Navigator.pushNamed(context, Routes.notificationRoute);
                      }
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 1.0.w),
                      child: Container(
                        height: 40.h,
                        width: 40.w,
                        decoration: BoxDecoration(
                          color: widget.backgroundNotification ??
                              AppColors.grayDark,
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SvgPicture.asset(
                              height: 21.h,
                              width: 18.w,
                              widget.isMore == true
                                  ? AppIcons.notificationWithBlueContainer
                                  : AppIcons.notificationIcon),
                        ),
                      ),
                    ),
                  ),
                ]),
          ),
        );
      },
    );
  }
}
