import 'package:easy_localization/easy_localization.dart';

import 'package:mawhebtak/core/exports.dart';
import 'package:mawhebtak/core/widgets/dropdown_button_form_field.dart';

import '../../cubit/calender_cubit.dart';
import '../../cubit/calender_state.dart';
import '../../data/model/countries_model.dart';

class RequiredTalentsSelector extends StatefulWidget {
  const RequiredTalentsSelector({
    Key? key,
  }) : super(key: key);

  @override
  _RequiredTalentsSelectorState createState() =>
      _RequiredTalentsSelectorState();
}

class _RequiredTalentsSelectorState extends State<RequiredTalentsSelector> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CalenderCubit, CalenderState>(
      builder: (context, state) {
        var cubit = context.read<CalenderCubit>();

        return SizedBox(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: 16.h),
                child: Text(
                  'select_required_talents'.tr(),
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                  ),
                ),
              ),
              if (cubit.selectedTalends.length != 0)
                SizedBox(
                  // height: 300.h,
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: cubit.selectedTalends.length,
                    itemBuilder: (context, index) {
                      return Stack(
                        children: [
                          IntrinsicHeight(
                            child: Container(
                              padding: EdgeInsets.all(8.w),
                              margin: EdgeInsets.all(2.w),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.1),
                                      spreadRadius: 1,
                                      blurRadius: 5,
                                      offset: const Offset(0, 3),
                                    ),
                                  ]),
                              // height: 150.h,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 8.0),
                                          child: Text(
                                            'select_type'.tr(),
                                            maxLines: 1,
                                            style: TextStyle(
                                              fontSize: 18.sp,
                                              color: Colors.black87,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                        Text(cubit.selectedTalends[index]
                                                .subCategoryIds.name ??
                                            ''),
                                      ],
                                    ),
                                  ),
                                  VerticalDivider(
                                    width:
                                        32.w, // Total width including margins
                                    thickness: 1.7,
                                    color: Colors.grey.shade300,
                                    indent: 8,
                                    endIndent: 8,
                                  ),
                                  Expanded(
                                      child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 8.0),
                                        child: Text(
                                          'Fees'.tr(),
                                          maxLines: 1,
                                          style: TextStyle(
                                              fontSize: 18.sp,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black87),
                                        ),
                                      ),
                                      Text(
                                          '${cubit.selectedTalends[index].prices} ${cubit.selectedTalends[index].countryCurrencies.currency ?? ''}'),
                                    ],
                                  ))
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            top: 2,
                            right: 2,
                            child: InkWell(
                              onTap: () {
                                cubit.removeFromTalends(index);
                              },
                              child: Icon(Icons.close,
                                  color: Colors.red, size: 18.w),
                            ),
                          )
                        ],
                      );
                    },
                  ),
                ),
              SizedBox(
                // height: 150.h,
                child: Padding(
                  padding: EdgeInsets.only(bottom: 16.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Text(
                          'select_type'.tr(),
                          maxLines: 1,
                          style: TextStyle(
                            fontSize: 18.sp,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                      _buildTalentTypeDropdown(),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Text(
                          'Fees'.tr(),
                          maxLines: 1,
                          style:
                              TextStyle(fontSize: 18.sp, color: Colors.black87),
                        ),
                      ),
                      _buildFeeInput(),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: InkWell(
                  onTap: () {
                    ///! here i want duplicate the last item
                    if (cubit.feesPriceController.text.isEmpty ||
                        cubit.selectedSubCategoty == null ||
                        cubit.selectedCurrency == null) {
                      errorGetBar('please_fill_all_fields'.tr());
                      return;
                    }
                    cubit.addNewTalends();
                  },
                  child: Container(
                    width: 40.w,
                    height: 40.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4.r),
                      border: Border.all(color: AppColors.primary),
                    ),
                    child: Icon(
                      Icons.add,
                      color: AppColors.primary,
                      size: 24.w,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTalentTypeDropdown() {
    var cubit = context.read<CalenderCubit>();
    return Container(
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(4.r),
            bottomRight: Radius.circular(4.r),
          ),
          border: Border(
            left: BorderSide(color: Colors.grey.shade300),
          ),
        ),
        child: GeneralCustomDropdownButtonFormField<GetCountriesMainModelData>(
          items: cubit.subCategoriesMainModel?.data ?? [],
          itemBuilder: (item) {
            return item.name ?? '';
          },
          onChanged: (value) {
            if (value != null) {
              cubit.selectedSubCategoty = value;
            }
          },
          value: cubit.selectedSubCategoty,
          validator: (value) {
            if (value == null) {
              return 'required_talents'.tr();
            }
            return null;
          },
        ));
  }

  Widget _buildFeeInput() {
    var cubit = context.read<CalenderCubit>();
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(4.r),
                bottomLeft: Radius.circular(4.r),
              ),
            ),
            child: TextField(
              controller: cubit.feesPriceController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: '500',
                hintStyle: TextStyle(
                  fontSize: 16.sp,
                  color: AppColors.grey,
                ),
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
                border: InputBorder.none,
              ),
              style: TextStyle(
                fontSize: 16.sp,
                color: Colors.black87,
              ),
              onChanged: (value) {},
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Container(
              // height: 40.h,
              // width: 80.w,
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(4.r),
                  bottomRight: Radius.circular(4.r),
                ),
                border: Border(
                  left: BorderSide(color: Colors.grey.shade300),
                ),
              ),
              child: GeneralCustomDropdownButtonFormField<
                  GetCountriesMainModelData>(
                items: cubit.countriesMainModel?.data ?? [],
                itemBuilder: (item) {
                  return item.currency ?? '';
                },
                onChanged: (value) {
                  if (value != null) {
                    cubit.selectedCurrency = value;
                  }
                },
                value: cubit.selectedCurrency,
                // value: cubit.selectedSubCategoty,
                validator: (value) {
                  if (value == null) {
                    return 'required_talents'.tr();
                  }
                  return null;
                },
              )),
        ),
      ],
    );
  }
}

// Model class to represent a talent requirement
class TalentRequirement {
  final String type;
  final String fee;
  final String currency;

  TalentRequirement(
      {required this.type, required this.fee, required this.currency});

  TalentRequirement copyWith({String? type, String? fee, String? currency}) {
    return TalentRequirement(
        type: type ?? this.type,
        fee: fee ?? this.fee,
        currency: currency ?? this.currency);
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'fee': fee,
      'currency': currency,
    };
  }
}
