import 'package:easy_localization/easy_localization.dart';
import 'package:mawhebtak/features/calender/data/model/countries_model.dart';
import 'package:mawhebtak/features/casting/cubit/casting_cubit.dart';
import 'package:mawhebtak/features/casting/cubit/casting_state.dart';
import 'package:mawhebtak/features/home/cubits/request_gigs_cubit/request_gigs_cubit.dart';
import '../../../core/exports.dart';

class DetailsOfMainCategoryTopTalents extends StatefulWidget {
  const DetailsOfMainCategoryTopTalents({super.key});

  @override
  State<DetailsOfMainCategoryTopTalents> createState() =>
      _DetailsOfMainCategoryTopTalentsState();
}

class _DetailsOfMainCategoryTopTalentsState
    extends State<DetailsOfMainCategoryTopTalents> {
  @override
  void initState() {
    context.read<CastingCubit>().getCategoryFromGigs();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<CastingCubit, CastingState>(builder: (context, state) {
        var requestGigs = context.read<RequestGigsCubit>().requestGigs;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            10.h.verticalSpace,
            CustomSimpleAppbar(
              title: 'top_talent'.tr(),
              isActionButton: true,
              filterType: 'top_talent',
            ),
            Padding(
              padding: EdgeInsets.only(top: 20.h, right: 10.w, left: 10.w),
              child: BlocBuilder<CastingCubit, CastingState>(
                  builder: (context, state) {
                var subCategory = context.read<CastingCubit>();
                return Column(
                  children: [
                    Container(
                      height: 60.h,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: AppColors.grayLite,
                        borderRadius: BorderRadius.circular(8.sp),
                      ),
                      child: DropdownButton<GetCountriesMainModelData>(
                        enableFeedback: true,
                        iconSize: 25.sp,
                        padding: EdgeInsets.only(
                            bottom: 10.h, top: 10.h, left: 10.w, right: 10.w),
                        underline: const SizedBox(),
                        onTap: () {},
                        icon: const Icon(Icons.keyboard_arrow_down),
                        iconEnabledColor: AppColors.secondPrimary,
                        isExpanded: true,
                        dropdownColor: AppColors.grayLite,
                        hint: Text('choose_category'.tr()),
                        value: subCategory.selectedCategory,
                        items: subCategory.categoryModel?.data?.map((category) {
                          return DropdownMenuItem<GetCountriesMainModelData>(
                            value: category,
                            child: Text(category.name ?? ""),
                          );
                        }).toList(),
                        onChanged: (GetCountriesMainModelData? value) {
                          subCategory.selectedCategory = value;
                          subCategory.subCategoryId = value?.id;
                          subCategory.getSubCategory(
                              categoryId: value?.id.toString() ?? "");
                        },
                      ),
                    ),
                  ],
                );
              }),
            ),
          ],
        );
      }),
    );
  }
}
