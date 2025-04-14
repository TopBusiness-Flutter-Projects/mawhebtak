import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mawhebtak/core/exports.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../core/utils/assets_manager.dart';
import '../../../core/utils/get_size.dart';
import '../cubit/onboarding_cubit.dart';

class OnBoarding2 extends StatelessWidget {
  const OnBoarding2({super.key});
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
                      ImageAssets.onboarding2Image,
                      // width: getSize(context) / 1.1,
                    ),
                  ),
                ),
              ),
              Stack(
                children: [
                  Image.asset(ImageAssets.onboardingBackground),
                  Positioned(child:
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: getSize(context)/9,
                      ),
                      SmoothPageIndicator(
                        controller: cubit.pageController,
                        count: cubit.numPages,
                        textDirection: TextDirection.ltr,
                        effect: WormEffect(
                          activeDotColor: AppColors.secondPrimary,
                          dotColor: AppColors.gray,
                          dotHeight:5.h,
                          dotWidth: 13.w,
                          type: WormType.thin,
                        ),
                      ),
                      SizedBox(
                        height: getSize(context)/7,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: getSize(context) / 44),
                        child: Text(
                          'Follow your favorite artist',
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
'Mawahbtak big platform connects all artists in all fields to make large community between artists in Egypt',                          style: TextStyle(
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
                            cubit.pageController.animateToPage(2,
                                duration: const Duration(milliseconds: 1000),
                                curve: Curves.easeInOut);
                          },
                          child: Container(
                            padding: EdgeInsets.only(
                                left: 40.w, right: 40.w, top: 10.h, bottom: 10.h),
                            decoration: BoxDecoration(
                              color: AppColors.secondPrimary,
                              borderRadius: BorderRadius.circular(8.sp),
                            ),
                            child: Text(
                              //trans.tr('next'),
                              'Next',
                              style: TextStyle(
                                  fontFamily: 'Noto Sans',
                                  color: AppColors.white,
                                  fontSize: 15.sp),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: getSize(context)/4,
                      ),
                    ],
                  ),)
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
