import 'package:easy_localization/easy_localization.dart';
import 'package:mawhebtak/core/exports.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

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
                    ),
                  ),
                ),
              ),
              Stack(
                children: [
                  Container(
                    height: getHeightSize(context) / 2.2,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(50.r),
                            topLeft: Radius.circular(50.r))),
                    child: Column(
                      children: [
                        SizedBox(
                          height: getSize(context) / 9,
                        ),
                        SmoothPageIndicator(
                          controller: cubit.pageController,
                          count: cubit.numPages,
                          effect: WormEffect(
                            activeDotColor: AppColors.secondPrimary,
                            dotColor: AppColors.grayLite.withOpacity(0.2),
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
                            "onboarding2_title".tr(),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontFamily: AppStrings.fontFamily2,
                                fontWeight: FontWeight.w600,
                                fontSize: 18.sp,
                                color: AppColors.white),
                          ),
                        ),
                        Flexible(child:  Container(
                          padding: EdgeInsets.all(getSize(context) / 44),
                          child: Text(
                            textAlign: TextAlign.center,
                            "onboarding2_description".tr(),
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontFamily: AppStrings.fontFamily2,
                                color: AppColors.white,
                                fontSize: 13.sp),
                          ),
                        )),
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
                                  left: 40.w,
                                  right: 40.w,
                                  top: 10.h,
                                  bottom: 10.h),
                              decoration: BoxDecoration(
                                color: AppColors.secondPrimary,
                                borderRadius: BorderRadius.circular(8.sp),
                              ),
                              child: Text(
                                "next".tr(),
                                style: TextStyle(
                                    fontFamily: AppStrings.fontFamily2,
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
