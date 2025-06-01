import 'package:easy_localization/easy_localization.dart';
import 'package:mawhebtak/core/widgets/dropdown_button_form_field.dart';
import 'package:mawhebtak/core/widgets/show_loading_indicator.dart';
import 'package:mawhebtak/features/calender/data/model/countries_model.dart';
import 'package:mawhebtak/features/casting/cubit/casting_cubit.dart';
import 'package:mawhebtak/features/casting/cubit/casting_state.dart';
import 'package:mawhebtak/features/casting/screens/widgets/gigs_widgets.dart';
import '../../../core/exports.dart';

class DetailsOfMainCategoryGigs extends StatefulWidget {
  const DetailsOfMainCategoryGigs({super.key, required this.categoryId});
  final String categoryId;

  @override
  State<DetailsOfMainCategoryGigs> createState() =>
      _DetailsOfMainCategoryGigsState();
}

class _DetailsOfMainCategoryGigsState extends State<DetailsOfMainCategoryGigs> {
  @override
  void initState() {
    var cubit = context.read<CastingCubit>();
    cubit.selectedSubCategory = null;

    cubit.getSubCategory(categoryId: widget.categoryId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          10.h.verticalSpace,
          CustomSimpleAppbar(
            title: 'request_gigs'.tr(),
            isActionButton: true,
            filterType: 'casting',
          ),
          Flexible(
            child: Padding(
              padding: EdgeInsets.only(top: 20.h, right: 10.w, left: 10.w),
              child: BlocBuilder<CastingCubit, CastingState>(
                builder: (context, state) {
                  var cubit = context.read<CastingCubit>();

                  return (state is SubCategoryStateLoading)
                      ? Center(child: const CustomLoadingIndicator())
                      : (cubit.subCategoryModel?.data?.length == 0)
                          ? Center(
                              child: Text('no_data'.tr()),
                            )
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildSubCategoryDropdown(context, cubit),
                                const SizedBox(height: 16),
                                Flexible(
                                  child: (cubit.getGigsFromSubCategoryModel
                                                  ?.data?.length ==
                                              0 ||
                                          cubit.getGigsFromSubCategoryModel ==
                                              null)
                                      ? Center(
                                          child: Text('no_data'.tr()),
                                        )
                                      : ListView.builder(
                                          shrinkWrap: true,
                                          physics:
                                              const AlwaysScrollableScrollPhysics(),
                                          itemCount: cubit
                                              .getGigsFromSubCategoryModel
                                              ?.data
                                              ?.length,
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 12.w),
                                          itemBuilder: (context, index) =>
                                              GigsWidget(
                                            isDetails: false,
                                            castingCubit: cubit,
                                            eventAndGigsModel: cubit
                                                .getGigsFromSubCategoryModel
                                                ?.data?[index],
                                            isWithButton: true,
                                          ),
                                        ),
                                )
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

  // Dropdown UI
  Widget _buildSubCategoryDropdown(BuildContext context, CastingCubit cubit) {
    return Container(
      height: 70.h,
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.grayLite,
        borderRadius: BorderRadius.circular(8.sp),
      ),
      child: GeneralCustomDropdownButtonFormField<GetCountriesMainModelData>(
        value: cubit.selectedSubCategory,
        onChanged: (value) {
          cubit.selectedSubCategory = value;

          cubit.getGigsFromSubCategory(
              id: cubit.selectedSubCategory?.id.toString() ?? '');
        },
        items: cubit.subCategoryModel?.data ?? [],
        itemBuilder: (item) => item.name ?? '',
      ),
    );
  }

  // // Grid View for Gigs
  // Widget _buildGigsGridView(BuildContext context) {
  //   final gigsList = castingCubit.getGigsFromSubCategoryModel?.data ?? [];
  //   return GridView.builder(
  //     shrinkWrap: true,
  //     physics: const NeverScrollableScrollPhysics(),
  //     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
  //       crossAxisCount: 2,
  //       mainAxisSpacing: 10,
  //       crossAxisSpacing: 10,
  //       childAspectRatio: 0.95,
  //     ),
  //     itemCount: gigsList.length,
  //     itemBuilder: (context, index) {
  //       final gig = gigsList[index];
  //       return Padding(
  //         padding: EdgeInsetsDirectional.only(start: 10.w, end: 10.w),
  //         child: Container(
  //           decoration: BoxDecoration(
  //             borderRadius: BorderRadius.circular(16.r),
  //             image: const DecorationImage(
  //               image: AssetImage(ImageAssets.tasweerPhoto),
  //               fit: BoxFit.cover,
  //             ),
  //           ),
  //           child: Container(
  //             padding: EdgeInsets.all(8.r),
  //             decoration: BoxDecoration(
  //               borderRadius: BorderRadius.circular(16.r),
  //               gradient: LinearGradient(
  //                 colors: [Colors.black.withOpacity(0.6), Colors.transparent],
  //                 begin: Alignment.bottomCenter,
  //                 end: Alignment.topCenter,
  //               ),
  //             ),
  //             child: Align(
  //               alignment: Alignment.bottomLeft,
  //               child: SizedBox(
  //                 width: 130.w,
  //                 child: Padding(
  //                   padding:
  //                       EdgeInsets.only(bottom: 10.h, left: 10.w, right: 10.w),
  //                   child: Text.rich(
  //                     TextSpan(
  //                       children: [
  //                         WidgetSpan(
  //                           child: Container(
  //                             decoration: BoxDecoration(
  //                               color: AppColors.secondPrimary,
  //                             ),
  //                             child: Text(
  //                               (gig.title ?? "").substring(
  //                                 0,
  //                                 (gig.title?.length ?? 0) >= 5
  //                                     ? 5
  //                                     : (gig.title?.length ?? 0),
  //                               ),
  //                               style: getMediumStyle(
  //                                 color: Colors.white,
  //                                 fontSize: 16.sp,
  //                               ),
  //                             ),
  //                           ),
  //                         ),
  //                         TextSpan(
  //                           text: (gig.title?.length ?? 0) > 5
  //                               ? gig.title!.substring(5)
  //                               : "",
  //                           style: getMediumStyle(
  //                             color: AppColors.white,
  //                             fontSize: 16.sp,
  //                           ),
  //                         ),
  //                       ],
  //                     ),
  //                     maxLines: 1,
  //                     overflow: TextOverflow.ellipsis,
  //                   ),
  //                 ),
  //               ),
  //             ),
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }
}
