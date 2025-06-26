import 'package:flutter_svg/svg.dart';

import '../../../../core/exports.dart';
import '../../../calender/cubit/calender_cubit.dart';
import '../../../feeds/cubit/feeds_cubit.dart';

class CustomAppBarWithClearWidget extends StatelessWidget {
  const CustomAppBarWithClearWidget({super.key, required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    return Container(
      //  height:  getHeightSize(context)/30,
      color: AppColors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: getHeightSize(context) / 100,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  title,
                  style: getMediumStyle(
                    color: AppColors.blackLite,
                    fontSize: 18.sp,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: InkWell(
                    onTap: () {
                      context.read<FeedsCubit>().clearDataAndBack(context);
                    },
                    child: SvgPicture.asset(AppIcons.xIcon)),
              ),
            ],
          ),
          SizedBox(
            height: getHeightSize(context) / 150,
          ),
          Container(
            color: AppColors.grayLite,
            width: double.infinity,
            height: 2.h,
          )
        ],
      ),
    );
  }
}
