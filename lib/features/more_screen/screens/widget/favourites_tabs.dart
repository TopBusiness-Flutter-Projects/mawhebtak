import 'package:mawhebtak/features/more_screen/cubit/more_cubit.dart';
import 'package:mawhebtak/features/profile/cubit/profile_cubit.dart';

import '../../../../core/exports.dart';

class FavouritesTabs extends StatefulWidget {
  const FavouritesTabs({super.key});


  @override
  State<FavouritesTabs> createState() => _FavouritesTabsState();
}

class _FavouritesTabsState extends State<FavouritesTabs> {
  @override
  Widget build(BuildContext context) {
    var cubit = context.read<MoreCubit>();

    final List<String> tabs = [
      "announcement".tr(),
      "jop".tr(),

    ];

    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (BuildContext context, state) {
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(tabs.length, (index) {
                final isSelected = cubit.selectedIndex == index;
                return GestureDetector(
                  onTap: () {
                    cubit.changeSelected(index);
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        tabs[index],
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: isSelected
                              ? AppColors.primary
                              : AppColors.grayText2,
                        ),
                      ),
                      SizedBox(height: 10.h),
                      Container(
                        height: 2.h,
                        width: 72.w,
                        color:
                        isSelected ? AppColors.primary : Colors.transparent,
                      )
                    ],
                  ),
                );
              }),
            ),
            SizedBox(height: 6.h),
            Container(height: 8.h, color: AppColors.grayLite),
          ],
        );
      },
    );
  }
}
