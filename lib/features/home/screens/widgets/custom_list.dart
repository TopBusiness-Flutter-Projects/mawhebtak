import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mawhebtak/features/home/cubits/home_cubit/home_cubit.dart';
import 'package:mawhebtak/features/main_screen/cubit/cubit.dart';
import '../../../../config/routes/app_routes.dart';
import '../../../../core/exports.dart';

class CustomList extends StatelessWidget {
  const CustomList({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<HomeCubit>();
    return SizedBox(
      height: 100.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const AlwaysScrollableScrollPhysics(),
        itemCount: cubit.items.length,
        shrinkWrap: true,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              cubit.items[index].label == "Jobs"
                  ? Navigator.pushNamed(context, Routes.jobsRoute)
                  : cubit.items[index].label == "Events"
                      ? Navigator.pushNamed(context, Routes.topEventsScreen)
                      : cubit.items[index].label == "Assistant"
                          ? Navigator.pushNamed(context, Routes.recordsRoute)
                          : cubit.items[index].label == "Casting"
                              ? context.read<MainCubit>().changePage(2)
                              : cubit.items[index].label == "Announce"
                                  ? Navigator.pushNamed(
                                      context, Routes.announcementScreen)
                                  : null;
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0),
              child: Column(
                children: [
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Container(
                        height: 70.h,
                        width: 70.w,
                        decoration: BoxDecoration(
                          color: AppColors.blueMeduim,
                          shape: BoxShape.circle,
                          border:
                              Border.all(color: AppColors.grayDark, width: 2),
                        ),
                        child: Center(
                            child: SvgPicture.asset(
                          cubit.items[index].icon,
                          height: 30.h,
                          width: 30.h,
                        )),
                      ),
                    ),
                  ),
                  AutoSizeText(
                    cubit.items[index].title,
                    maxLines: 1,
                    style:
                        getMediumStyle(fontSize: 14.sp, color: AppColors.white),
                  ),
                  // 5.h.verticalSpace,
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
