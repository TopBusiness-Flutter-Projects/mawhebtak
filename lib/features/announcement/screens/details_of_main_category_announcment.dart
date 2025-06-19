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
    cubit.announcementsFromSubCategory = null;
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
                  var hasSelectedSub = cubit.selectedSubCategory != null;
                  var hasNewData =
                      cubit.announcements?.data?.isNotEmpty == true;
                  return (state is SubCategoryStateLoading)
                      ? const Center(child: CustomLoadingIndicator())
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildSubCategoryDropdown(context, cubit),
                            const SizedBox(height: 16),
                            hasSelectedSub && hasNewData
                                ? Expanded(
                                    child: GridView.builder(
                                      itemCount:
                                          cubit.announcementsFromSubCategory?.data?.length ??
                                              0,
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 1,
                                        mainAxisSpacing: 8.h,
                                        crossAxisSpacing: 8.w,
                                        childAspectRatio: 0.7,
                                      ),
                                      itemBuilder: (context, index) =>
                                          CustomAnnouncementWidget(
                                        index: index,
                                        isMainWidget: true,
                                        announcement:
                                            cubit.announcementsFromSubCategory?.data?[index],
                                      ),
                                    ),
                                  )
                                : Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        (state is AnnouncementsStateLoading)
                                            ? const Expanded(
                                                child: Center(
                                                  child:
                                                      CustomLoadingIndicator(),
                                                ),
                                              )
                                            : Expanded(
                                                child: Padding(
                                                padding: EdgeInsets.only(
                                                    left: 8.w, right: 8.w),
                                                child: GridView.builder(
                                                  shrinkWrap: true,
                                                  gridDelegate:
                                                      SliverGridDelegateWithFixedCrossAxisCount(
                                                          crossAxisCount: 1,
                                                          mainAxisSpacing: 8.h,
                                                          crossAxisSpacing: 8.w,
                                                          childAspectRatio:
                                                              0.7),
                                                  itemBuilder: (context,
                                                          index) =>
                                                      CustomAnnouncementWidget(
                                                    index: index,
                                                    isMainWidget: true,
                                                    announcement: cubit
                                                        .announcements
                                                        ?.data?[index],
                                                  ),
                                                  itemCount: cubit.announcements
                                                          ?.data?.length ??
                                                      0,
                                                ),
                                              )),
                                        if (state
                                            is AnnouncementsStateLoadingMore)
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
  Widget _buildSubCategoryDropdown(
      BuildContext context, AnnouncementCubit cubit) {
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
}
