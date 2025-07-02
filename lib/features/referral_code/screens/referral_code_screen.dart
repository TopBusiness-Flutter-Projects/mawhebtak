import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mawhebtak/core/exports.dart';
import 'package:mawhebtak/features/main/cubit/cubit.dart';
import 'package:mawhebtak/features/main/cubit/state.dart';
import 'package:share_plus/share_plus.dart';

class ReferralCodeScreen extends StatelessWidget {
  const ReferralCodeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<MainCubit>();
    

    return SafeArea(
      child: Scaffold(
        body: BlocBuilder<MainCubit, MainState>(
          builder: (context, state) {
            return Column(
              children: [
                CustomSimpleAppbar(title: "referral_code".tr()),

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Column(
                    children: [
                      SizedBox(height: 20.h),
                      Image.asset(
                        ImageAssets.referralCodeImage,
                        width: 210.w,
                        height: 210.h,
                      ),
                      SizedBox(height: 20.h),
                      Text(
                        "text_referral_code".tr(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppColors.blackLite,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 20.h),

                      // ==== Copy Code Box ====
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
                        decoration: BoxDecoration(
                          color: AppColors.grayLite,
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                cubit.loginModel?.data?.referralCode ?? "",
                                
                                style: TextStyle(fontSize: 14.sp, color: AppColors.black),
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Clipboard.setData(ClipboardData(text:cubit.loginModel?.data?.referralCode ?? ""));
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('Code copied!')),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primary,
                                padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 6.h),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6.r),
                                ),
                              ),
                              child: Text(
                                "copy_code".tr(),
                                style: TextStyle(color: Colors.white, fontSize: 12.sp),
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 20.h),
                      GestureDetector(
                          onTap: () async {
                              String url =  cubit.loginModel?.data?.referralCode ?? "refe";
                                await SharePlus.instance.share(ShareParams(
                  text:
                      url,
                  title: AppStrings.appName,
                ));
                            
                            },
                        child: Text(
                          "share_code_now".tr(),
                          style: TextStyle(
                            fontSize: 18.sp,
                            color: AppColors.black.withOpacity(0.8),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),

                      SizedBox(height: 12.h),

                      // ==== Share Icons ====
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.center,
                      //   children: [
                      //     _buildIcon(AppIcons.xIcon),
                      //     _buildIcon(AppIcons.face),
                      //     _buildIcon(AppIcons.messenger),
                      //     _buildIcon(AppIcons.whatsapp),
                      //   ],
                      // ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildIcon(String assetPath) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.w),
      child: SvgPicture.asset(
        assetPath,
        width: 32.w,
        height: 32.h,
      ),
    );
  }
}
