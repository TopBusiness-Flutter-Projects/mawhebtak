import 'package:easy_localization/easy_localization.dart';
import 'package:mawhebtak/features/calender/data/model/countries_model.dart';
import 'package:mawhebtak/features/casting/cubit/casting_cubit.dart';
import 'package:mawhebtak/features/casting/cubit/casting_state.dart';
import 'package:mawhebtak/features/home/cubits/request_gigs_cubit/request_gigs_cubit.dart';
import '../../../core/exports.dart';

class DetailsOfMainCategoryGigs extends StatefulWidget {
  const DetailsOfMainCategoryGigs({super.key, required this.type});
  final String type;

  @override
  State<DetailsOfMainCategoryGigs> createState() =>
      _DetailsOfMainCategoryGigsState();
}

class _DetailsOfMainCategoryGigsState extends State<DetailsOfMainCategoryGigs> {
  @override
  void initState() {
    (widget.type == 'gigs')?
    context.read<CastingCubit>().getCategory():
        null;
       super.initState();
  }

  @override

  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.type == 'gigs'?
      BlocBuilder<CastingCubit, CastingState>(
          builder: (context, state) {
            var requestGigs = context.read<RequestGigsCubit>().requestGigs;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                10.h.verticalSpace,
                CustomSimpleAppbar(
                  title: 'request_gigs'.tr(),
                  isActionButton: true,
                ),
                Padding(
                  padding:  EdgeInsets.only(top:20.h,right: 10.w,left: 10.w),
                  child: BlocBuilder<CastingCubit,CastingState>(
                    builder: (context,state) {
                      var subCategory= context.read<CastingCubit>();
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
                                  bottom: 10.h,
                                  top: 10.h,
                                  left: 10.w,
                                  right: 10.w),
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
                          // Expanded(
                          //     child: GridView.builder(
                          //
                          //       gridDelegate:
                          //       const SliverGridDelegateWithFixedCrossAxisCount(
                          //           crossAxisCount:2,
                          //           mainAxisSpacing: 10
                          //
                          //       ),
                          //       itemBuilder: (context, index) =>
                          //           Padding(
                          //             padding: EdgeInsetsDirectional.only(
                          //               start:  10.w,
                          //               end:  10.0.w,
                          //             ),
                          //             child: Container(
                          //               decoration: BoxDecoration(
                          //                 borderRadius: BorderRadius.circular(16.r),
                          //                 image: DecorationImage(
                          //                   image: requestGigs?.image != null &&
                          //                       requestGigs!.image!.isNotEmpty
                          //                       ? NetworkImage(requestGigs!.image!)
                          //                       : const AssetImage(ImageAssets.tasweerPhoto) as ImageProvider,
                          //                   fit: BoxFit.cover,
                          //                 ),
                          //               ),
                          //               child: Container(
                          //                 padding:  EdgeInsets.all(8.0.r),
                          //                 decoration: BoxDecoration(
                          //                   borderRadius: BorderRadius.circular(16.r),
                          //                   gradient: LinearGradient(
                          //                     colors: [
                          //                       Colors.black.withOpacity(0.6),
                          //                       Colors.transparent,
                          //                     ],
                          //                     begin: Alignment.bottomCenter,
                          //                     end: Alignment.topCenter,
                          //                   ),
                          //                 ),
                          //                 child: Align(
                          //                   alignment: Alignment.bottomLeft,
                          //                   child: SizedBox(
                          //                     width: 130.w,
                          //                     child: Padding(
                          //                         padding:  EdgeInsets.only(bottom: 10.h,left: 10.w,right: 10.w),
                          //                         child: Text.rich(
                          //
                          //                           TextSpan(
                          //                             children: [
                          //                               WidgetSpan(
                          //                                 child: Container(
                          //                                   decoration: BoxDecoration(
                          //                                     color:AppColors.secondPrimary,
                          //                                   ),
                          //                                   child: Text(
                          //                                     (requestGigs?.title ?? "").substring(0,
                          //                                         (requestGigs?.title?.length ?? 0) >= 5 ? 5 :
                          //                                         (requestGigs?.title?.length ?? 0)
                          //                                     ),
                          //                                     style: getMediumStyle(
                          //                                       color: Colors.white,
                          //                                       fontSize: 16.sp,
                          //                                     ),
                          //                                   ),
                          //                                 ),
                          //                               ),
                          //                               TextSpan(
                          //                                 text: (requestGigs?.title?.length ?? 0) > 5
                          //                                     ? (requestGigs?.title ?? "").substring(5)
                          //                                     : "",
                          //                                 style: getMediumStyle(
                          //                                   color: AppColors.white,
                          //                                   fontSize: 16.sp,
                          //                                 ),
                          //                               ),
                          //                             ],
                          //                           ),
                          //                           maxLines: 1,
                          //                           overflow: TextOverflow.ellipsis,
                          //                         )
                          //
                          //
                          //                     ),
                          //                   ),
                          //                 ),
                          //               ),
                          //             ),
                          //           ),
                          //       itemCount: requestGigs?.data?.length ?? 0,
                          //     )
                          // ),
                        ],
                      );
                    }
                  ),
                ),

              ],
            );
          }):const SizedBox()
    );
  }
}
