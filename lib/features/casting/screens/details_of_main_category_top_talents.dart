import 'package:lottie/lottie.dart';
import 'package:mawhebtak/core/widgets/dropdown_button_form_field.dart';
import 'package:mawhebtak/core/widgets/show_loading_indicator.dart';
import 'package:mawhebtak/features/calender/data/model/countries_model.dart';
import 'package:mawhebtak/features/casting/cubit/casting_state.dart';
import 'package:mawhebtak/features/home/cubits/top_talents_cubit/top_talents_cubit.dart';
import 'package:mawhebtak/features/home/screens/widgets/custom_top_talents_list.dart';
import '../../../core/exports.dart';

class DetailsOfMainCategoryTopTalents extends StatefulWidget {
  const DetailsOfMainCategoryTopTalents({super.key, required this.userTypeId});
  final String userTypeId;

  @override
  State<DetailsOfMainCategoryTopTalents> createState() =>
      _DetailsOfMainCategoryTopTalentsState();
}

class _DetailsOfMainCategoryTopTalentsState
    extends State<DetailsOfMainCategoryTopTalents> {
  @override
  void initState() {
    final cubit = context.read<TopTalentsCubit>();
    cubit.getDataUserSubType(userTypeId: widget.userTypeId);
    cubit.selectedUserSubType = null;
    super.initState();
  }

  // topSubCategoryTalents
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          10.h.verticalSpace,
          CustomSimpleAppbar(
            title: 'top_talent'.tr(),
            isActionButton: true,
            filterType: 'top_talent',
          ),
          Flexible(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 20.h),
              child: BlocBuilder<TopTalentsCubit, TopTalentsState>(
                builder: (context, state) {
                  var cubit = context.read<TopTalentsCubit>();
                  var hasSelectedSub = cubit.selectedUserSubType != null;
                  var hasNewData =
                      cubit.topTalents?.data?.isNotEmpty == true;
                  return

                  hasSelectedSub && hasNewData?
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildSubCategoryDropdown(context, cubit),
                      const SizedBox(height: 16),
                      (state is SubCategoryStateLoading)
                          ? const Center(child: CustomLoadingIndicator())
                          :Expanded(
                        child: ( cubit.topSubCategoryTalents?.data?.length == 0 || cubit.userSubTypeList?.data == [])
                            ?  Center(
                          child: Lottie.asset(
                              'assets/animation_icons/search_no_data.json',
                              height: 200,
                              width: 200),
                        )
                            : GridView.builder(
                          gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 10,
                            childAspectRatio: 0.8,
                          ),
                          shrinkWrap: true,
                          itemCount: cubit.topSubCategoryTalents?.data?.length ?? 0,
                          itemBuilder: (context, index) {
                            final topSubCategoryTalents = cubit.topSubCategoryTalents!.data![index];
                            return CustomTopTalentsList(
                              topTalentsCubit: cubit,
                              index: index,
                              topTalentsData: topSubCategoryTalents,
                            );
                          },
                        ),
                      ),
                    ],
                  ):
                  Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildSubCategoryDropdown(context, cubit),
                            const SizedBox(height: 16),
                            Expanded(
                              child: (state is TopTalentsStateLoading)?
                              const Center(child: CustomLoadingIndicator(),):
                              (cubit.topTalents?.data?.isEmpty ?? true)
                                  ?  Center(
                                child: Lottie.asset(
                                    'assets/animation_icons/search_no_data.json',
                                    height: 200,
                                    width: 200),
                              )
                                  : GridView.builder(
                                      gridDelegate:
                                          const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        mainAxisSpacing: 10,
                                        crossAxisSpacing: 10,
                                        childAspectRatio: 0.8,
                                      ),
                                      shrinkWrap: true,
                                      itemCount: cubit.topTalents
                                              ?.data?.length ??
                                          0,
                                      itemBuilder: (context, index) {
                                        final topTalent = cubit
                                            .topTalents!
                                            .data![index];
                                        return CustomTopTalentsList(
                                          topTalentsCubit: cubit,
                                          index: index,
                                          topTalentsData: topTalent,
                                        );
                                      },
                                    ),

                            ),
                            if (state
                            is TopTalentsStateLoadingMore)
                              const CustomLoadingIndicator(),
                          ],
                        );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSubCategoryDropdown(
      BuildContext context, TopTalentsCubit cubit) {
    return Container(
      height: 70.h,
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.grayLite,
        borderRadius: BorderRadius.circular(8.sp),
      ),
      child: GeneralCustomDropdownButtonFormField<GetCountriesMainModelData>(
        onChanged: (value) {
          cubit.selectedUserSubType = value;
          if (value?.id != null) {
            cubit.topTalentsData(
              page: '1',
              userSubTypeId: value?.id.toString(),
            );
          }
        },
        value: cubit.selectedUserSubType,
        items: cubit.userSubTypeList?.data ?? [],
        itemBuilder: (item) => item.name ?? '',
      ),
    );
  }
}
