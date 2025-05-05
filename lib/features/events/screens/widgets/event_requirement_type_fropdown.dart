import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EventRequirementTypeDropdown extends StatefulWidget {
  final Function(String) onChanged;
  final String initialValue;
  final List<String> eventTypes;

  const EventRequirementTypeDropdown({
    Key? key,
    required this.onChanged,
    this.initialValue = 'Teacher',
    this.eventTypes = const ['Teacher', 'Auther', 'Editor', 'Programmer'],
  }) : super(key: key);

  @override
  _EventRequirementTypeDropdownState createState() => _EventRequirementTypeDropdownState();
}

class _EventRequirementTypeDropdownState extends State<EventRequirementTypeDropdown> {
  late String _selectedValue;

  @override
  void initState() {
    super.initState();
    _selectedValue = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'event_req'.tr(),
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 8.h),
        Container(
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(8),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: _selectedValue,
              isExpanded: true,
              icon: Icon(Icons.keyboard_arrow_down, color: Colors.blue.shade700),
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
              borderRadius: BorderRadius.circular(8),
              items: widget.eventTypes.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value,
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: Colors.black87,
                    ),
                  ),
                );
              }).toList(),
              onChanged: (newValue) {
                if (newValue != null) {
                  setState(() {
                    _selectedValue = newValue;
                  });
                  widget.onChanged(newValue);
                }
              },
            ),
          ),
        ),
      ],
    );
  }
}
