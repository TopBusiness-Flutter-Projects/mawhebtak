import 'package:easy_localization/easy_localization.dart';
import 'package:mawhebtak/core/exports.dart';
import 'package:mawhebtak/core/utils/custom_loadingindicator.dart';
import 'package:mawhebtak/features/home/cubits/top_talents_cubit/top_talents_cubit.dart';
import 'package:mawhebtak/features/home/screens/widgets/custom_top_talents_list.dart';

class TopTalentsScreen extends StatelessWidget {
  const TopTalentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<TopTalentsCubit, TopTalentsState>(
          builder: (context, state) {
        var topTalentData = context.read<TopTalentsCubit>().topTalents;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomSimpleAppbar(
              title: 'top_talents'.tr(),
              isActionButton: true,
            ),
            switch (state) {
              TopTalentsStateLoading() => const Expanded(
                  child: Center(
                    child: CustomLoadingIndicator(),
                  ),
                ),
              TopTalentsStateError() => Expanded(
                  child: Center(child: Text(state.errorMessage.toString()))),
              TopTalentsStateLoaded() => Expanded(
                    child: Padding(
                  padding: EdgeInsets.only(left: 8.w, right: 8.w),
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.9,
                    ),
                    itemBuilder: (context, index) => CustomTopTalentsList(
                      topTalentsData: topTalentData?.data?[index],
                      isLeftPadding: index == 0 ? true : false,
                      isRightPadding:
                          index == (topTalentData?.data?.length ?? 1) - 1
                              ? true
                              : false,
                    ),
                    itemCount: topTalentData?.data?.length ?? 0,
                  ),
                )),
            }
          ],
        );
      }),
    );
  }
}
