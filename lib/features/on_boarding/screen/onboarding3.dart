import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mawhebtak/config/routes/app_routes.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../core/exports.dart';
import '../../../core/utils/assets_manager.dart';
import '../../../core/utils/get_size.dart';
import '../cubit/onboarding_cubit.dart';

class OnBoarding3 extends StatelessWidget {
  const OnBoarding3({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OnboardingCubit, OnboardingState>(
      listener: (context, state) {},
      builder: (context, state) {
        OnboardingCubit cubit = context.read<OnboardingCubit>();
        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            actions: [],
          ),
          body: Column(
            children: [
              SizedBox(
                height: getSize(context) / 22,
              ),
              Flexible(
                fit: FlexFit.tight,
                child: Padding(
                  padding: EdgeInsets.all(getSize(context) / 22),
                  child: Center(
                    child: Image.asset(
                      ImageAssets.onboarding3Image,
                      // width: getSize(context) / 1.1,
                    ),
                  ),
                ),
              ),
              Stack(
                children: [
                  Image.asset(ImageAssets.onboardingBackground),
                  Positioned(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: getSize(context) / 9,
                        ),
                        SmoothPageIndicator(
                          controller: cubit.pageController,
                          count: cubit.numPages,
                          effect: WormEffect(
                            activeDotColor: AppColors.secondPrimary,
                            dotColor: AppColors.gray,
                            dotHeight: 5.h,
                            dotWidth: 13.w,
                            type: WormType.thin,
                          ),
                        ),
                        SizedBox(
                          height: getSize(context) / 7,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: getSize(context) / 44),
                          child: Text(
                            "onboarding3_title".tr(),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontFamily: 'NotoSans',
                                fontWeight: FontWeight.w600,
                                fontSize: 18.sp,
                                color: AppColors.white),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(getSize(context) / 44),
                          child: Text(
                            textAlign: TextAlign.center,
                            "onboarding3_description".tr(),                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontFamily: 'NotoSans',
                                color: AppColors.white,
                                fontSize: 13.sp),
                          ),
                        ),
                        SizedBox(
                          height: 30.h,
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 100.w, left: 100.w),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, Routes.loginRoute);
                            },
                            child: Container(
                              padding: EdgeInsets.only(
                                  left: 40.w,
                                  right: 40.w,
                                  top: 10.h,
                                  bottom: 10.h),
                              decoration: BoxDecoration(
                                color: AppColors.secondPrimary,
                                borderRadius: BorderRadius.circular(8.sp),
                              ),
                              child: Text(
                                "Let_is_start".tr(),
                                style: TextStyle(
                                    fontFamily: 'Noto Sans',
                                    color: AppColors.white,
                                    fontSize: 15.sp),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: getSize(context) / 4,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
