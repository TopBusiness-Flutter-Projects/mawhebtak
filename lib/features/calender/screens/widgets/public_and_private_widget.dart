import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PublicPrivateToggle extends StatefulWidget {
  final Function(bool) onToggle;
  final bool isPublic;

  const PublicPrivateToggle({
    Key? key,
    required this.onToggle,
    this.isPublic = true,
  }) : super(key: key);

  @override
  _PublicPrivateToggleState createState() => _PublicPrivateToggleState();
}

class _PublicPrivateToggleState extends State<PublicPrivateToggle> {
  late bool _isPublic;

  @override
  void initState() {
    super.initState();
    _isPublic = widget.isPublic;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.only(right: 50.w),
      child: SizedBox(
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildToggleOption(
              text: 'public'.tr(),
              isSelected: _isPublic,
              onTap: () => _updateToggle(true),
            ),
            _buildToggleOption(
              text: 'private'.tr(),
              isSelected: !_isPublic,
              onTap: () => _updateToggle(false),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildToggleOption({
    required String text,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(

        decoration: BoxDecoration(
          color: isSelected ? Colors.transparent : Colors.transparent,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          children: [
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isSelected ? Colors.green : Colors.transparent,
                border: isSelected ? null : Border.all(color: Colors.grey.shade400),
              ),
              child: isSelected
                  ? Icon(
                Icons.check,
                color: Colors.white,
                size: 18.sp,
              )
                  : null,
            ),
            SizedBox(width: 8.w),
            Text(
              text,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: isSelected ? Colors.black87 : Colors.grey.shade600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _updateToggle(bool isPublic) {
    if (_isPublic != isPublic) {
      setState(() {
        _isPublic = isPublic;
      });
      widget.onToggle(_isPublic);
    }
  }
}

