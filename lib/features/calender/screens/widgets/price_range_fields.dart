import 'package:easy_localization/easy_localization.dart';
import 'package:mawhebtak/core/exports.dart';
import 'package:mawhebtak/features/jobs/cubit/jobs_cubit.dart';

class PriceRangeFields extends StatefulWidget {
  PriceRangeFields({Key? key, required this.jobsCubit}) : super(key: key);
  JobsCubit jobsCubit;

  @override
  State<PriceRangeFields> createState() => _PriceRangeFieldsState();
}

class _PriceRangeFieldsState extends State<PriceRangeFields> {
  // Predefined list of price options
  final List<String> priceOptions = [
    '5000',
    '10000',
    '15000',
    '20000',
    '25000',
    '30000',
    '35000',
    '40000',
    '45000',
    '50000'
  ];

  bool _isFromDropdownOpen = false;
  bool _isToDropdownOpen = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'price_range'.tr(),
          style: getMediumStyle(
              fontSize: 14.sp,
              color: AppColors.blackLite
          ),
        ),
        8.h.verticalSpace,

        // From field with dropdown
        _buildDropdownField(
            label: 'from'.tr(),
            controller: widget.jobsCubit.fromController,
            isOpen: _isFromDropdownOpen,
            onToggle: () => setState(() => _isFromDropdownOpen = !_isFromDropdownOpen),
            onSelect: (value) {
              setState(() {
                widget.jobsCubit.fromController.text = value;
                _isFromDropdownOpen = false;
              });
            }
        ),

        if (_isFromDropdownOpen) _buildDropdownList(
          options: priceOptions,
          onSelect: (value) {
            setState(() {
              widget.jobsCubit.fromController.text = value;
              _isFromDropdownOpen = false;
            });
          },
        ),

        8.h.verticalSpace,

        // To field with dropdown
        _buildDropdownField(
            label: 'to'.tr(),
            controller: widget.jobsCubit.toController,
            isOpen: _isToDropdownOpen,
            onToggle: () => setState(() => _isToDropdownOpen = !_isToDropdownOpen),
            onSelect: (value) {
              setState(() {
                widget.jobsCubit.toController.text = value;
                _isToDropdownOpen = false;
              });
            }
        ),

        if (_isToDropdownOpen) _buildDropdownList(
          options: priceOptions,
          onSelect: (value) {
            setState(() {
              widget.jobsCubit.toController.text = value;
              _isToDropdownOpen = false;
            });
          },
        ),
      ],
    );
  }

  Widget _buildDropdownField({
    required String label,
    required TextEditingController controller,
    required bool isOpen,
    required VoidCallback onToggle,
    required Function(String) onSelect,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(8.r),
      ),
      height: 50.h,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.w),
        child: Row(
          children: [
            Text(
              '$label:',
              style: getMediumStyle(
                fontSize: 14.sp,
                color: Colors.grey[600],
              ),
            ),
            label == 'from'.tr() ? SizedBox(width: 8.w) : SizedBox(width: 16.w),
            Expanded(
              child: TextField(
                controller: controller,
                readOnly: true, // Make read-only since we're using dropdown
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.zero,
                  hintText: label == 'from'.tr() ? '10000' : '20000',
                  hintStyle: const TextStyle(color: Colors.black87),
                ),
                style: const TextStyle(color: Colors.black87),
              ),
            ),
            InkWell(
              onTap: onToggle,
              child: Icon(
                isOpen ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                color: Colors.blue[400],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDropdownList({
    required List<String> options,
    required Function(String) onSelect,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      constraints: BoxConstraints(
        maxHeight: 200.h,
      ),
      margin: EdgeInsets.only(top: 4.h),
      child: ListView.builder(
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        itemCount: options.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () => onSelect(options[index]),
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 12.w),
              decoration: BoxDecoration(
                border: index < options.length - 1
                    ? Border(bottom: BorderSide(color: Colors.grey.shade200))
                    : null,
              ),
              child: Text(
                options[index],
                style: getMediumStyle(
                  fontSize: 14.sp,
                  color: AppColors.blackLite,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}