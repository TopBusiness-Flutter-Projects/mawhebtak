import 'dart:developer';
import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mawhebtak/core/exports.dart';
import 'package:mawhebtak/features/auth/login/cubit/cubit.dart';
import 'package:mawhebtak/features/auth/login/cubit/state.dart';

class GoogleAndFacebookWidget extends StatefulWidget {
  const GoogleAndFacebookWidget({super.key});

  @override
  State<GoogleAndFacebookWidget> createState() =>
      _GoogleAndFacebookWidgetState();
}

class _GoogleAndFacebookWidgetState extends State<GoogleAndFacebookWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(builder: (context, state) {
      var cubit = context.read<LoginCubit>();
      return Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
        Platform.isAndroid
            ? const SizedBox()
            : Expanded(
                child: GestureDetector(
                  onTap: () async {
                    cubit.signInWithApple(context);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16.sp),
                      border: Border.all(color: AppColors.grayLite),
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: 15.w, right: 15.w, top: 10.h, bottom: 10.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            AppIcons.appleIcon,
                            width: 30.w,
                          ),
                          SizedBox(width: 10.w),
                          Text("apple".tr(),
                              style: TextStyle(
                                  color: AppColors.darkGray.withOpacity(0.8),
                                  fontSize: 20.sp))
                        ],
                      ),
                    ),
                  ),
                ),
              ),
        Platform.isAndroid ? const SizedBox() : SizedBox(width: 20.w),
        Expanded(
          child: GestureDetector(
            onTap: () async {
              cubit.signInWithGoogle(context);
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.sp),
                border: Border.all(color: AppColors.grayLite),
              ),
              child: Padding(
                padding: EdgeInsets.only(
                    left: 15.w, right: 15.w, top: 10.h, bottom: 10.h),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        AppIcons.googleIcon,
                        width: 30.w,
                      ),
                      SizedBox(width: 10.w),
                      Text("google".tr(),
                          style: TextStyle(
                              color: AppColors.darkGray.withOpacity(0.8),
                              fontSize: 20.sp))
                    ]),
              ),
            ),
          ),
        ),
      ]);
    });
  }
}
