import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mawhebtak/core/widgets/dropdown_button_form_field.dart';
import 'package:mawhebtak/features/announcement/cubit/announcement_cubit.dart';
import 'package:mawhebtak/features/calender/cubit/calender_cubit.dart';
import 'package:mawhebtak/features/calender/cubit/calender_state.dart';
import 'package:mawhebtak/features/calender/data/model/countries_model.dart';
import 'package:mawhebtak/features/feeds/screens/widgets/image_view_file.dart';
import 'package:mawhebtak/features/feeds/screens/widgets/video_from_file_screen.dart';
import 'package:mawhebtak/features/location/cubit/location_cubit.dart';
import 'package:mawhebtak/features/location/cubit/location_state.dart';
import 'package:mawhebtak/features/location/screens/full_screen_map.dart';
import '../../../core/exports.dart';
import '../../events/screens/widgets/custom_apply_app_bar.dart';
import '../../feeds/cubit/feeds_cubit.dart';
import '../../home/screens/widgets/follow_button.dart';

class NewAnnouncementScreen extends StatefulWidget {
  const NewAnnouncementScreen({super.key});

  @override
  State<NewAnnouncementScreen> createState() => _NewAnnouncementScreenState();
}

class _NewAnnouncementScreenState extends State<NewAnnouncementScreen> {
  @override
  void initState() {
    if (context.read<CalenderCubit>().countriesMainModel == null) {
      context.read<CalenderCubit>().getAllCountries();
    }
    context.read<AnnouncementCubit>().selectedCategory = null;
    context.read<AnnouncementCubit>().selectedSubCategory = null;
    context.read<AnnouncementCubit>().getCategoryFromAnnouncment(page: '1');
    super.initState();
  }

  double getDiscountedPrice() {
    double price = double.tryParse(
            context.read<AnnouncementCubit>().priceController.text) ??
        0;
    double discount = double.tryParse(
            context.read<AnnouncementCubit>().discountController.text) ??
        0;

    return price - ((discount / 100) * price);
  }

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<AnnouncementCubit>();
    return BlocBuilder<CalenderCubit, CalenderState>(builder: (context, state) {
      var calenderCubit = context.read<CalenderCubit>();
      return BlocBuilder<AnnouncementCubit, AnnouncementState>(
        builder: (BuildContext context, state) {
          var announcementCubit = context.read<AnnouncementCubit>();
          return WillPopScope(
            onWillPop: () async {
              context.read<FeedsCubit>().clearDataAndBack(context);
              return Future.value(false);
            },
            child: SafeArea(
              child: Scaffold(
                body: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CustomAppBarWithClearWidget(
                        title: "new_announcments".tr(),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 16.0.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "announcment_title".tr(),
                              style: getRegularStyle(fontSize: 14.sp),
                            ),
                            CustomTextField(
                              controller:
                                  announcementCubit.announcementTitleController,
                              hintText: "John doe".tr(),
                              hintTextSize: 18.sp,
                            ),
                            Text(
                              "select_category".tr(),
                              style: getRegularStyle(fontSize: 14.sp),
                            ),
                            Container(
                              height: 60.h,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: AppColors.grayLite,
                                borderRadius: BorderRadius.circular(8.sp),
                              ),
                              child: GeneralCustomDropdownButtonFormField(
                                itemBuilder: (item) {
                                  return item.name ?? '';
                                },
                                value: cubit.selectedCategory,
                                items:
                                    cubit.announcementCategoryModel?.data ?? [],
                                onChanged: (value) {
                                  cubit.selectedCategory = value;
                                  cubit
                                      .subCategoryFromCategoryAnnouncementsModel
                                      ?.data = [];
                                  cubit.selectedSubCategory = null;
                                  cubit.subCategoryFromCategoryAnnouncement(
                                      categoryId: value?.id.toString() ?? "");
                                },
                              ),
                            ),
                            10.h.verticalSpace,
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                if (cubit
                                        .subCategoryFromCategoryAnnouncementsModel
                                        ?.data
                                        ?.length !=
                                    0)
                                  Padding(
                                    padding: EdgeInsets.only(
                                        top: 10.h, bottom: 10.h),
                                    child: Text(
                                      "sub_category".tr(),
                                      style: getRegularStyle(fontSize: 18.sp),
                                    ),
                                  ),
                                if (cubit
                                        .subCategoryFromCategoryAnnouncementsModel
                                        ?.data
                                        ?.length !=
                                    0)
                                  Container(
                                    height: 60.h,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: AppColors.grayLite,
                                      borderRadius: BorderRadius.circular(8.sp),
                                    ),
                                    child: GeneralCustomDropdownButtonFormField(
                                      itemBuilder: (item) {
                                        return item?.name ?? '';
                                      },
                                      value: cubit.selectedSubCategory,
                                      items: cubit
                                              .subCategoryFromCategoryAnnouncementsModel
                                              ?.data ??
                                          [],
                                      onChanged: (value) {
                                        cubit.selectedSubCategory = value;
                                      },
                                    ),
                                  ),
                              ],
                            ),
                            10.h.verticalSpace,
                            Text(
                              "price_range".tr(),
                              style: getRegularStyle(fontSize: 14.sp),
                            ),
                            CustomTextField(
                              keyboardType: TextInputType.number,
                              onChanged: (v) {
                                setState(() {});
                              },
                              validator: (p0) {
                                if (p0!.isEmpty) {
                                  return 'price_range'.tr();
                                }
                                return null;
                              },
                              controller: cubit.priceController,
                              hintText: 'price_range'.tr(),
                              hintTextSize: 18.sp,
                              enabled: true,
                              suffixIcon: InkWell(
                                onTap: () {
                                  showCurrencyPicker(
                                      calenderCubit.countriesMainModel?.data ??
                                          []);
                                },
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      calenderCubit
                                              .selectedCurrency?.currency ??
                                          '',
                                      style: getRegularStyle(
                                          color: Colors.blue, fontSize: 14.sp),
                                    ),
                                    const Icon(Icons.keyboard_arrow_down_sharp,
                                        color: Colors.blue),
                                  ],
                                ),
                              ),
                            ),
                            Column(
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 16.w, vertical: 12.h),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(12.r),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Icon(Icons.event_available,
                                              color: AppColors.primary),
                                          SizedBox(width: 10.w),
                                          Text(
                                            'is_discount'.tr(),
                                            style: getMediumStyle(
                                                fontSize: 18.sp,
                                                color: AppColors.grayDark),
                                          ),
                                        ],
                                      ),
                                      Switch(
                                        value: cubit.isDiscount,
                                        activeColor: AppColors.primary,
                                        onChanged: (value) {
                                          setState(() {
                                            cubit.isDiscount =
                                                !cubit.isDiscount;
                                            if (cubit.isDiscount == false) {
                                              cubit.discountController.clear();
                                            }
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                                if (cubit.isDiscount)
                                  CustomTextField(
                                    keyboardType: TextInputType.number,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.allow(
                                          RegExp(r'^\d{0,3}')),
                                      TextInputFormatter.withFunction(
                                          (oldValue, newValue) {
                                        try {
                                          final text = newValue.text;
                                          if (text.isEmpty) return newValue;
                                          final value = double.parse(text);
                                          if (value >= 100) {
                                            return oldValue; // امنع التحديث
                                          }
                                          return newValue;
                                        } catch (e) {
                                          return oldValue;
                                        }
                                      }),
                                    ],
                                    onChanged: (v) {
                                      setState(() {});
                                    },
                                    validator: (p0) {
                                      if (p0 == null || p0.isEmpty) {
                                        return 'enter_discount_price'.tr();
                                      }

                                      double? value = double.tryParse(p0);
                                      if (value == null) {
                                        return 'invalid_number'.tr();
                                      }

                                      if (value >= 100) {
                                        return 'must_less_than_100'.tr();
                                      }

                                      return null;
                                    },
                                    controller: cubit.discountController,
                                    hintText: 'discount_value'.tr(),
                                    hintTextSize: 18.sp,
                                    suffixIcon: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10.w, vertical: 10.h),
                                      child: Text(
                                        "%",
                                        style: TextStyle(
                                            fontSize: 20.sp,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                if (cubit.isDiscount)
                                  Padding(
                                    padding:
                                        EdgeInsets.only(top: 10.h, left: 10.w),
                                    child: Text(
                                      '${'price_after_discount'.tr()}: ${getDiscountedPrice().toStringAsFixed(2)}',
                                      style: TextStyle(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.primary,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                            Text(
                              "expire_in".tr(),
                              style: getRegularStyle(fontSize: 14.sp),
                            ),
                            CustomTextField(
                              validator: (p0) {
                                if (p0!.isEmpty) {
                                  return 'select_date'.tr();
                                }
                                return null;
                              },
                              controller:
                                  announcementCubit.announcementDateController,
                              suffixIcon: Padding(
                                padding: EdgeInsets.all(10.0.r),
                                child: SvgPicture.asset(AppIcons.dateIcon),
                              ),
                              onTap: () {
                                announcementCubit.selectDateTime(context);
                              },
                              hintTextSize: 14.sp,
                              hintText: "select_date".tr(),
                            ),
                            10.verticalSpace,
                            Text(
                              "select_location".tr(),
                              style: getRegularStyle(fontSize: 14.sp),
                            ),
                            BlocBuilder<LocationCubit, LocationState>(
                              builder: (context, state) {
                                return CustomTextField(
                                  hintTextSize: 18.sp,
                                  controller:
                                      announcementCubit.locationController,
                                  validator: (p0) {
                                    if (p0!.isEmpty) {
                                      return 'select_location'.tr();
                                    }
                                    return null;
                                  },
                                  hintText: "select_location".tr(),
                                );
                              },
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => FullScreenMap(
                                                type: 'add_announcement',
                                              )));
                                },
                                child: Text(
                                  "open_map".tr(),
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.primary,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ),
                            ),
                            Text(
                              "description".tr(),
                              style: getRegularStyle(fontSize: 14.sp),
                            ),
                            CustomTextField(
                              controller: announcementCubit
                                  .announcementDescriptionController,
                              hintText: "".tr(),
                              hintTextSize: 18.sp,
                              maxLines: 6,
                              isMessage: true,
                            ),
                            10.verticalSpace,
                            Text(
                              "image_or_video".tr(),
                              style: getRegularStyle(fontSize: 14.sp),
                            ),
                            10.verticalSpace,
                            InkWell(
                                onTap: () {
                                  calenderCubit
                                      .showSelectionBottomSheet(context);
                                },
                                child: Image.asset(
                                  ImageAssets.imageOrVideo,
                                  height: 88.h,
                                )),
                            SizedBox(height: 20.h),
                            SizedBox(
                              height: (calenderCubit.myImages?.length == 0 ||
                                      calenderCubit.myImages == null)
                                  ? 0
                                  : 80.h,
                              child: ListView.separated(
                                scrollDirection: Axis.horizontal,
                                itemCount:
                                    (calenderCubit.myImages?.length ?? 0),
                                separatorBuilder: (_, __) =>
                                    const SizedBox(width: 10),
                                itemBuilder: (context, index) {
                                  return Stack(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      ImageFileView(
                                                          image: calenderCubit
                                                              .myImages![index]
                                                              .path)));
                                        },
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          child: Image.file(
                                            File(calenderCubit
                                                .myImages![index].path),
                                            width: 80.w,
                                            height: 80.w,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        top: 0,
                                        right: 0,
                                        child: GestureDetector(
                                          onTap: () {
                                            calenderCubit.deleteImage(File(
                                                calenderCubit
                                                    .myImages![index].path));
                                          },
                                          child: Container(
                                            decoration: const BoxDecoration(
                                              color: Colors.black45,
                                              shape: BoxShape.circle,
                                            ),
                                            child: const Icon(Icons.close,
                                                color: Colors.white, size: 18),
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ),
                            SizedBox(
                              height: getHeightSize(context) / 33,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SizedBox(
                                height: context.read<CalenderCubit>().validVideos.isEmpty ? 0 : 80,
                                child: ListView.separated(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: (context.read<CalenderCubit>().validVideos.length),
                                  separatorBuilder: (_, __) =>
                                  const SizedBox(width: 10),
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    VideoPlayerScreenFile(
                                                      videoFile: File(context.read<CalenderCubit>()
                                                          .validVideos[index].path),
                                                    )));
                                      },
                                      child: Stack(
                                        children: [
                                          ClipRRect(
                                            borderRadius: BorderRadius.circular(8),
                                            child: Container(
                                              width: 80.w,
                                              height: 80.w,
                                              decoration: const BoxDecoration(
                                                color: Colors.black12,
                                                image: DecorationImage(
                                                  image: AssetImage(
                                                      ImageAssets.videoImage),
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            top: 0,
                                            right: 0,
                                            child: GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  context.read<CalenderCubit>().deleteVideo(File(context.read<CalenderCubit>()
                                                      .validVideos[index].path));
                                                });
                                              },
                                              child: Container(
                                                decoration: const BoxDecoration(
                                                  color: Colors.black45,
                                                  shape: BoxShape.circle,
                                                ),
                                                child: const Icon(Icons.close,
                                                    color: Colors.white, size: 18),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(right: 16.0.w),
                              child: CustomContainerButton(
                                onTap: () {
                                  announcementCubit.addAnnouncement(
                                      context: context);
                                },
                                height: 48.h,
                                title: 'create_announcments'.tr(),
                                color: AppColors.primary,
                              ),
                            ),
                            SizedBox(
                              height: getHeightSize(context) / 33,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      );
    });
  }

  void showCurrencyPicker(List<GetCountriesMainModelData> currencyList) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: EdgeInsets.symmetric(vertical: 20.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: currencyList.map((currency) {
            return ListTile(
              title: Text(currency.currency ?? '', style: getRegularStyle()),
              onTap: () {
                context.read<CalenderCubit>().selectedCurrency = currency;
                Navigator.pop(context);
              },
            );
          }).toList(),
        ),
      ),
    );
  }
}
