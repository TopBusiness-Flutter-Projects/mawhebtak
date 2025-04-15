import 'package:easy_localization/easy_localization.dart';
import 'package:mawhebtak/core/exports.dart';
import 'package:mawhebtak/core/widgets/custom_simple_appbar.dart';
import 'package:mawhebtak/features/about_us/cubit/about_us_cubit.dart';
import 'package:mawhebtak/features/about_us/cubit/about_us_state.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<AboutUsCubit>();
    return SafeArea(
      child: Scaffold(
        body: BlocBuilder<AboutUsCubit, AboutUsState>(
            builder: (context, state) {
          return Column(
            children: [
              CustomSimpleAppbar(
                title: "about_us".tr(),
              ),
              Expanded(
                child: Container(
                  color: AppColors.grayLite.withOpacity(0.3),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                    Padding(
                      padding:  EdgeInsets.only(bottom: 20.h,top: 20.h),
                      child: Image.asset(ImageAssets.appIconWhite),
                    ),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.only(left: 20.w,right: 20.w,top: 20.h,bottom: 20.h),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: AppColors.white
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text("about_mawahbtak".tr(),style: TextStyle(
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w600
                              ),),

                            20.h.verticalSpace,
                              Text("text_about_us".tr(),
                                style: TextStyle(
                                  wordSpacing: 1.2,
                                height: 1.7,
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w400
                              ),),
                            ],
                          ),
                        ),
                      )

                    ],
                  ),
                ),
              )
            ],
          );
        }),
      ),
    );
  }
}
