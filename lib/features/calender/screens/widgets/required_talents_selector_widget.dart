import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/services.dart';
import 'package:mawhebtak/core/exports.dart';
import 'package:mawhebtak/core/widgets/dropdown_button_form_field.dart';

import '../../cubit/calender_cubit.dart';
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
  late List<TalentRequirement> _talents;

  @override
  void initState() {
    super.initState();
    _talents = [
      TalentRequirement(type: 'Workshop', fee: '3000', currency: 'L.E'),
    ];
  }

  var _talentTypes = [];
  void _addNewTalent() {
    setState(() {
      _talents.add(
        TalentRequirement(type: _talentTypes[0], fee: '3000', currency: 'L.E'),
      );
    });
    // widget.onTalentsChanged(_talents);
  }

  void _updateTalent(int index, TalentRequirement updatedTalent) {
    setState(() {
      _talents[index] = updatedTalent;
    });
    // widget.onTalentsChanged(_talents);
  }

  void _removeTalent(int index) {
    setState(() {
      _talents.removeAt(index);
    });
    // widget.onTalentsChanged(_talents);
  }

  @override
  Widget build(BuildContext context) {
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
          Container(
            height: 200,
            child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _talents.length,
              itemBuilder: (context, index) {
                return SizedBox(
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
                        _buildTalentTypeDropdown(index),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Text(
                            'Fees',
                            maxLines: 1,
                            style: TextStyle(
                                fontSize: 18.sp, color: Colors.black87),
                          ),
                        ),
                        _buildFeeInput(index),
                        if (_talents.length > 1)
                          Padding(
                            padding: EdgeInsets.only(top: 24.h, left: 8.w),
                            child: InkWell(
                              onTap: () => _removeTalent(index),
                              child: Icon(
                                Icons.close,
                                color: Colors.red,
                                size: 18.w,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: InkWell(
              onTap: _addNewTalent,
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
  }

  Widget _buildTalentTypeDropdown(int index) {
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

  Widget _buildFeeInput(int index) {
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
              onChanged: (value) {
                _updateTalent(
                  index,
                  _talents[index].copyWith(fee: value),
                );
              },
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

  TalentRequirement({
    required this.type,
    required this.fee,
    required this.currency,
  });

  TalentRequirement copyWith({
    String? type,
    String? fee,
    String? currency,
  }) {
    return TalentRequirement(
      type: type ?? this.type,
      fee: fee ?? this.fee,
      currency: currency ?? this.currency,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'fee': fee,
      'currency': currency,
    };
  }
}
