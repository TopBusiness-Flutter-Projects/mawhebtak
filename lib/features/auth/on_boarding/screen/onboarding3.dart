import 'package:mawhebtak/config/routes/app_routes.dart';
import 'package:mawhebtak/core/exports.dart';
import 'package:mawhebtak/core/preferences/preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../cubit/onboarding_cubit.dart';
import 'package:auto_size_text/auto_size_text.dart';

class OnBoarding3 extends StatelessWidget {
  const OnBoarding3({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OnboardingCubit, OnboardingState>(
      listener: (context, state) {},
      builder: (context, state) {
        OnboardingCubit cubit = context.read<OnboardingCubit>();
        return Scaffold(
          appBar: AppBar(elevation: 0),
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
                  Container(
                    height: getHeightSize(context) / 2.2,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(50.r),
                            topLeft: Radius.circular(50.r))),
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
                            "onboarding3_title".tr(),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontFamily: 'NotoSans',
                                fontWeight: FontWeight.w600,
                                fontSize: 18.sp,
                                color: AppColors.white),
                          ),
                        ),
                        Flexible(
                          child: Container(
                            padding: EdgeInsets.all(getSize(context) / 44),
                            child: AutoSizeText(
                              textAlign: TextAlign.center,
                              "onboarding3_description".tr(),
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontFamily: 'NotoSans',
                                  color: AppColors.white,
                                  fontSize: 13.sp),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 30.h,
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 100.w, left: 100.w),
                          child: GestureDetector(
                            onTap: () async {
                              Navigator.pushNamed(context, Routes.loginRoute);
                              await Preferences.instance.setFirstInstall();
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
