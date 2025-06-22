import 'package:flutter_html/flutter_html.dart';
import 'package:mawhebtak/core/exports.dart';
import 'package:mawhebtak/core/widgets/show_loading_indicator.dart';
import 'package:mawhebtak/features/more_screen/cubit/more_cubit.dart';
import 'package:mawhebtak/features/more_screen/cubit/more_state.dart';

class TermsAndConditionScreen extends StatefulWidget {
  const TermsAndConditionScreen({super.key});

  @override
  State<TermsAndConditionScreen> createState() =>
      _TermsAndConditionScreenState();
}

class _TermsAndConditionScreenState extends State<TermsAndConditionScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<MoreCubit, MoreState>(builder: (context, state) {
        var cubit = context.read<MoreCubit>();
        return Column(
          children: [
            CustomSimpleAppbar(
              title: "terms_and_condition".tr(),
            ),
            Expanded(
              child: Container(
                color: AppColors.grayLite.withOpacity(0.3),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    20.h.verticalSpace,
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
                            child: Html(
                              data: cubit.settingModel?.data?.terms ?? "",
                            )),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        );
      }),
    );
  }
}
