import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/services.dart';
import 'package:mawhebtak/core/exports.dart';

class RequiredTalentsSelector extends StatefulWidget {
  final Function(List<TalentRequirement>) onTalentsChanged;
  final List<TalentRequirement>? initialTalents;

  const RequiredTalentsSelector({
    Key? key,
    required this.onTalentsChanged,
    this.initialTalents,
  }) : super(key: key);

  @override
  _RequiredTalentsSelectorState createState() => _RequiredTalentsSelectorState();
}

class _RequiredTalentsSelectorState extends State<RequiredTalentsSelector> {
  late List<TalentRequirement> _talents;
  final List<String> _talentTypes = [
    'Workshop',
    'Photographer',
    'Videographer',
    'Designer',
    'Speaker',
    'Actor',
    'Singer',
    'Dancer',
    'Writer',
    'Other'
  ];
  final List<String> _currencies = ['L.E', 'USD', 'EUR', 'SAR'];

  @override
  void initState() {
    super.initState();
    _talents = widget.initialTalents ??
        [
          TalentRequirement(type: 'Workshop', fee: '3000', currency: 'L.E'),
        ];
  }

  void _addNewTalent() {
    setState(() {
      _talents.add(
        TalentRequirement(
            type: _talentTypes[0],
            fee: '3000',
            currency: 'L.E'
        ),
      );
    });
    widget.onTalentsChanged(_talents);
  }

  void _updateTalent(int index, TalentRequirement updatedTalent) {
    setState(() {
      _talents[index] = updatedTalent;
    });
    widget.onTalentsChanged(_talents);
  }

  void _removeTalent(int index) {
    setState(() {
      _talents.removeAt(index);
    });
    widget.onTalentsChanged(_talents);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: 16.h),
          child: Text(
            'select_required_talents'.tr(),
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: _talents.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.only(bottom: 16.h),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'select_type'.tr(),
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Colors.black87,
                          ),
                        ),
                        SizedBox(height: 4.h),
                        _buildTalentTypeDropdown(index),
                      ],
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Fees',
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Colors.black87,
                          ),
                        ),
                        SizedBox(height: 4.h),
                        _buildFeeInput(index),
                      ],
                    ),
                  ),
                  if (_talents.length > 1)
                    Padding(
                      padding: EdgeInsets.only(top: 24.h, left: 8.w),
                      child: InkWell(
                        onTap: () => _removeTalent(index),
                        child: Icon(
                          Icons.close,
                          color: Colors.red,
                          size: 20.w,
                        ),
                      ),
                    ),
                ],
              ),
            );
          },
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
    );
  }

  Widget _buildTalentTypeDropdown(int index) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(4.r),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: _talents[index].type,
          isExpanded: true,
          icon: Icon(Icons.keyboard_arrow_down, color: Colors.blue.shade700),
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 2.h),
          borderRadius: BorderRadius.circular(4.r),
          items: _talentTypes.map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(
                value,
                style: TextStyle(
                  fontSize: 14.sp,
                  color: Colors.black87,
                ),
              ),
            );
          }).toList(),
          onChanged: (newValue) {
            if (newValue != null) {
              _updateTalent(
                index,
                _talents[index].copyWith(type: newValue),
              );
            }
          },
        ),
      ),
    );
  }

  Widget _buildFeeInput(int index) {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(4.r),
                bottomLeft: Radius.circular(4.r),
              ),
            ),
            child: TextField(
              controller: TextEditingController(text: _talents[index].fee),
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
                border: InputBorder.none,
                isDense: true,
              ),
              style: TextStyle(
                fontSize: 14.sp,
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
        Container(
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
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: _talents[index].currency,
              icon: Icon(Icons.keyboard_arrow_down, color: Colors.blue.shade700),
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
              borderRadius: BorderRadius.circular(4.r),
              items: _currencies.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value,
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Colors.blue.shade700,
                    ),
                  ),
                );
              }).toList(),
              onChanged: (newValue) {
                if (newValue != null) {
                  _updateTalent(
                    index,
                    _talents[index].copyWith(currency: newValue),
                  );
                }
              },
            ),
          ),
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

// Example usage in a screen
class RequiredTalentsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Required Talents')),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RequiredTalentsSelector(
                onTalentsChanged: (talents) {
                  print('Talents updated: ${talents.length}');
                  // Handle talents update
                },
                initialTalents: [
                  TalentRequirement(type: 'Workshop', fee: '3000', currency: 'L.E'),
                  TalentRequirement(type: 'Photographer', fee: '3000', currency: 'L.E'),
                ],
              ),
              SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: () {
                    // Handle submit
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                  ),
                  child: Text(
                    'Next',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}