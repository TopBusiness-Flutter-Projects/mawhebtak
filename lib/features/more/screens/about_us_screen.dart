import 'package:flutter_html/flutter_html.dart';
import 'package:mawhebtak/core/exports.dart';
import 'package:mawhebtak/features/more/cubit/more_cubit.dart';
import 'package:mawhebtak/features/more/cubit/more_state.dart';

class AboutUsScreen extends StatefulWidget {
  const AboutUsScreen({super.key});

  @override
  State<AboutUsScreen> createState() => _AboutUsScreenState();
}

class _AboutUsScreenState extends State<AboutUsScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BlocBuilder<MoreCubit, MoreState>(builder: (context, state) {
          var cubit = context.read<MoreCubit>();
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
                        padding: EdgeInsets.only(bottom: 20.h, top: 20.h),
                        child: Image.asset(ImageAssets.appIconWhite),
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Container(
                            padding: EdgeInsets.only(
                                left: 20.w,
                                right: 20.w,
                                top: 20.h,
                                bottom: 20.h),
                            width: double.infinity,
                            decoration: BoxDecoration(color: AppColors.white),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "about_mawahbtak".tr(),
                                  style: TextStyle(
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.w600),
                                ),
                                20.h.verticalSpace,
                                Html(
                                  data: cubit.settingModel?.data?.aboutUs ?? "",
                                )
                              ],
                            ),
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
