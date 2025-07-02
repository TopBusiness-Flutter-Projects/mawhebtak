import 'dart:io';
import 'package:mawhebtak/core/exports.dart';
import 'package:mawhebtak/core/widgets/dropdown_button_form_field.dart';
import 'package:mawhebtak/features/calender/cubit/calender_cubit.dart';
import 'package:mawhebtak/features/calender/cubit/calender_state.dart';
import 'package:mawhebtak/features/calender/data/model/countries_model.dart';
import 'package:mawhebtak/features/casting/cubit/casting_cubit.dart';
import 'package:mawhebtak/features/casting/cubit/casting_state.dart';
import 'package:mawhebtak/features/feeds/screens/widgets/image_view_file.dart';
import 'package:mawhebtak/features/home/screens/widgets/follow_button.dart';
import 'package:mawhebtak/features/location/cubit/location_cubit.dart';
import 'package:mawhebtak/features/location/cubit/location_state.dart';
import 'package:mawhebtak/features/location/screens/full_screen_map.dart';
import '../../events/screens/widgets/custom_apply_app_bar.dart';
import '../../feeds/cubit/feeds_cubit.dart';

class NewGigsScreen extends StatefulWidget {
  const NewGigsScreen({super.key});

  @override
  State<NewGigsScreen> createState() => _NewGigsScreenState();
}

class _NewGigsScreenState extends State<NewGigsScreen> {
  @override
  void initState() {
    context.read<CastingCubit>().getCategoryFromGigs(paginate: false);
    context.read<CastingCubit>().selectedCategory = null;
    context.read<CastingCubit>().selectedSubCategory = null;
    if (context.read<CalenderCubit>().countriesMainModel == null) {
      context.read<CalenderCubit>().getAllCountries();
    }
    super.initState();
  }
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CastingCubit, CastingState>(
      builder: (context, state) {
        var cubit = context.read<CastingCubit>();
        return WillPopScope(
      onWillPop: () async {
        context.read<FeedsCubit>().clearDataAndBack(context);
        return Future.value(false);
      },
          child: Scaffold(
            body: SafeArea(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: 10.h),
                      child: CustomAppBarWithClearWidget(title: "new_gig".tr()),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: EdgeInsets.only(left: 16.0.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "gig_title_you_will_offer".tr(),
                                style: getRegularStyle(fontSize: 18.sp),
                              ),
                              CustomTextField(
                                controller: cubit.gigTitleController,
                                hintText: "John doe".tr(),
                                hintTextSize: 18.sp,

                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 10.h, bottom: 10.h),
                                child: Text(
                                  "category".tr(),
                                  style: getRegularStyle(fontSize: 18.sp),
                                ),
                              ),
                              Container(
                                height: 60.h,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: AppColors.grayLite,
                                  borderRadius: BorderRadius.circular(8.sp),
                                ),
                                child: GeneralCustomDropdownButtonFormField<
                                    GetCountriesMainModelData>(
                                  itemBuilder: (item) {
                                    return item.name ?? '';
                                  },
                                  value: cubit.selectedCategory,
                                  items: cubit.categoryModel?.data ?? [],
                                  onChanged: (value) {
                                    cubit.selectedCategory = value;
                                    cubit.subCategoryFromCategoryGigsModel?.data =
                                        [];
                                    cubit.selectedSubCategory = null;
                                    cubit.subCategoryFromCategoryGigs(
                                        categoryId: value?.id.toString() ?? "");
                                  },
                                ),
                              ),
                              10.h.verticalSpace,
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  if (cubit.subCategoryFromCategoryGigsModel?.data
                                          ?.length !=
                                      0)
                                    Padding(
                                      padding:
                                          EdgeInsets.only(top: 10.h, bottom: 10.h),
                                      child: Text(
                                        "sub_category".tr(),
                                        style: getRegularStyle(fontSize: 18.sp),
                                      ),
                                    ),
                                  if (cubit.subCategoryFromCategoryGigsModel?.data
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
                                                .subCategoryFromCategoryGigsModel
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
                              BlocBuilder<CalenderCubit, CalenderState>(
                                  builder: (context, state) {
                                var cubit2 = context.read<CalenderCubit>();
                                return CustomTextField(
                                  keyboardType: TextInputType.number,
                                  validator: (p0) {
                                    if (p0!.isEmpty) {
                                      return 'enter_ticket_price'.tr();
                                    }
                                    return null;
                                  },
                                  controller: cubit.priceRangeController,
                                  hintText: 'ticket_price'.tr(),
                                  hintTextSize: 18.sp,
                                  enabled: true,
                                  suffixIcon: InkWell(
                                    onTap: () {
                                      showCurrencyPicker(
                                          cubit2.countriesMainModel?.data ?? [],
                                          context);
                                    },
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          cubit2.selectedCurrency?.currency ?? '',
                                          style: getRegularStyle(
                                              color: Colors.blue, fontSize: 14.sp),
                                        ),
                                        const Icon(Icons.keyboard_arrow_down_sharp,
                                            color: Colors.blue),
                                      ],
                                    ),
                                  ),
                                );
                              }),
                              Text(
                                "select_location".tr(),
                                style: getRegularStyle(fontSize: 14.sp),
                              ),
                              BlocBuilder<LocationCubit, LocationState>(
                                builder: (context, state) {
                                  return CustomTextField(
                                    hintTextSize: 18.sp,
                                    controller: cubit.locationAddressController,
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
                                                  type: 'add_gig',
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
                                controller: cubit.descriptionController,
                                hintText: "".tr(),
                                hintTextSize: 18.sp,
                                maxLines: 6,
                                isMessage: true,
                              ),
                              Text(
                                "image_or_video".tr(),
                                style: getRegularStyle(fontSize: 14.sp),
                              ),
                              10.verticalSpace,
                              InkWell(
                                  onTap: () {
                                    context
                                        .read<CalenderCubit>()
                                        .showSelectionBottomSheet(context);
                                  },
                                  child: Image.asset(
                                    ImageAssets.imageOrVideo,
                                    height: 88.h,
                                  )),
                              SizedBox(height: 20.h),
                              BlocBuilder<CalenderCubit, CalenderState>(
                                  builder: (context, state) {
                                var cubit = context.read<CalenderCubit>();
                                return SizedBox(
                                  height: (cubit.myImages?.length == 0 ||
                                          cubit.myImages == null)
                                      ? 0
                                      : 80.h,
                                  child: ListView.separated(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: (cubit.myImages?.length ?? 0),
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
                                                              image: cubit
                                                                  .myImages![index]
                                                                  .path)));
                                            },
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              child: Image.file(
                                                File(cubit.myImages![index].path),
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
                                                cubit.deleteImage(File(
                                                    cubit.myImages![index].path));
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
                                );
                              }),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            bottomNavigationBar: Padding(
              padding: const EdgeInsets.all(20.0),
              child: CustomContainerButton(
                height: 48.h,
                title: "create_gig".tr(),
                color: AppColors.primary,
                onTap: () {
                  final currency = context.read<CalenderCubit>().selectedCurrency?.currency;
                  if (currency == null || currency.isEmpty) {
                    errorGetBar("please_select_currency".tr()); // أو اكتبي الرسالة يدويًا
                    return;
                  }
                  cubit.addNewGig(context: context);
                },


              ),
            ),
          ),
        );
      },
    );
  }

  void showCurrencyPicker(
      List<GetCountriesMainModelData> currencyList, BuildContext context) {
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
                setState(() {
                  context.read<CalenderCubit>().selectedCurrency = currency;
                });
                Navigator.pop(context);
              },
            );
          }).toList(),
        ),
      ),
    );
  }
}
