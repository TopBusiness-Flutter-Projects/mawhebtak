import 'package:mawhebtak/core/widgets/dropdown_button_form_field.dart';
import 'package:mawhebtak/core/widgets/show_loading_indicator.dart';
import 'package:mawhebtak/features/announcement/cubit/announcement_cubit.dart';
import 'package:mawhebtak/features/calender/data/model/countries_model.dart';
import 'package:mawhebtak/features/home/screens/widgets/custom_announcement_widget.dart';
import '../../../core/exports.dart';

class DetailsOfMainCategoryAnnouncement extends StatefulWidget {
  const DetailsOfMainCategoryAnnouncement(
      {super.key, required this.categoryId});
  final String categoryId;

  @override
  State<DetailsOfMainCategoryAnnouncement> createState() =>
      _DetailsOfMainCategoryAnnouncementState();
}

class _DetailsOfMainCategoryAnnouncementState
    extends State<DetailsOfMainCategoryAnnouncement> {
  @override
  void initState() {
    var cubit = context.read<AnnouncementCubit>();
    cubit.subCategoryFromCategoryAnnouncement(categoryId: widget.categoryId);
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
            title: 'request_announcement'.tr(),
            isActionButton: true,
            filterType: 'announcements',
          ),
          Flexible(
            child: Padding(
              padding: EdgeInsets.only(top: 20.h, right: 10.w, left: 10.w),
              child: BlocBuilder<AnnouncementCubit, AnnouncementState>(
                builder: (context, state) {
                  var cubit = context.read<AnnouncementCubit>();
                  return (state is SubCategoryStateLoading)
                      ? const Center(child: CustomLoadingIndicator())
                      : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildSubCategoryDropdown(context, cubit),
                      const SizedBox(height: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            (state is AnnouncementsStateLoading)
                                ? const Expanded(
                              child: Center(
                                child: CustomLoadingIndicator(),
                              ),
                            )
                                : Expanded(
                                child: Padding(
                                  padding: EdgeInsets.only(left: 8.w, right: 8.w),
                                  child: GridView.builder(
                                    shrinkWrap: true,
                                    gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 1,
                                        mainAxisSpacing: 8.h,
                                        crossAxisSpacing: 8.w,
                                        childAspectRatio: 0.7),
                                    itemBuilder: (context, index) =>
                                        CustomAnnouncementWidget(
                                          announcement: cubit.announcements?.data?[index],

                                        ),
                                    itemCount:  cubit.announcements?.data?.length ?? 0,
                                  ),
                                )),
                            if (state is AnnouncementsStateLoadingMore)
                              const CustomLoadingIndicator(),
                          ],
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
  Widget _buildSubCategoryDropdown(BuildContext context, AnnouncementCubit cubit) {
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

          cubit.getAnnouncementsFromSubCategory(
              id: cubit.selectedSubCategory?.id.toString() ?? '');
        },
        items: cubit.subCategoryFromCategoryAnnouncementsModel?.data ?? [],
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
}

  // Dropdown UI
  // Widget _buildSubCategoryDropdown(BuildContext context, AnnouncementCubit cubit) {
  //   return Container(
  //     height: 70.h,
  //     width: double.infinity,
  //     decoration: BoxDecoration(
  //       color: AppColors.grayLite,
  //       borderRadius: BorderRadius.circular(8.sp),
  //     ),
  //     child: GeneralCustomDropdownButtonFormField<GetCountriesMainModelData>(
  //       value: cubit.selectedSubCategory,
  //       onChanged: (value) {
  //         cubit.selectedSubCategory = value;
  //
  //         cubit.getGigsFromSubCategory(
  //             id: cubit.selectedSubCategory?.id.toString() ?? '');
  //       },
  //       items: cubit.subCategoryModel?.data ?? [],
  //       itemBuilder: (item) => item.name ?? '',
  //     ),
  //   );
  // }

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

