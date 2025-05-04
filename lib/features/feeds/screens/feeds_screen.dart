
import '../../../core/exports.dart';
import '../../home/screens/widgets/custom_app_bar_row.dart';
import '../../profile/screens/widgets/time_line_widget/time_line_list.dart';
import '../../profile/screens/widgets/time_line_widget/what_do_you_want.dart';

class FeedsScreen extends StatelessWidget {
  const FeedsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
             padding: EdgeInsets.only(top: 20.h, ),
             child: CustomAppBarRow(
                colorTextFromSearchTextField:
                    AppColors.darkGray.withOpacity(0.3),
                backgroundColorTextFieldSearch: AppColors.grayLite,
                isMore: true,
                colorSearchIcon: AppColors.secondPrimary,
                backgroundNotification: AppColors.primary,
              ),
            ),
            Container(
             color: AppColors.grayLite,
              height: getHeightSize(context) / 50,
            ),
            //what do you want
            const WhatDoYouWant(),
           10.h.verticalSpace,
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 9,
              itemBuilder: (BuildContext context, int index) {
                return const TimeLineList();
              },
              separatorBuilder: (BuildContext context, int index) {
                return SizedBox(
                  height: 15.h,
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
