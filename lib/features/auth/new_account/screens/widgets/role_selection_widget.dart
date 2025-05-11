import 'package:easy_localization/easy_localization.dart';
import 'package:mawhebtak/core/exports.dart';
import 'package:mawhebtak/features/auth/new_account/cubit/new_account_cubit.dart';
import 'package:mawhebtak/features/auth/new_account/cubit/new_account_state.dart';

import '../../data/model/user_types.dart';

class RoleSelectionWidget extends StatefulWidget {
  const RoleSelectionWidget({required this.list, super.key});
  final List<MainRegisterUserTypesData> list;
  @override
  _RoleSelectionWidgetState createState() => _RoleSelectionWidgetState();
}

class _RoleSelectionWidgetState extends State<RoleSelectionWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewAccountCubit, NewAccountState>(
      builder: (context, state) {
        var cubit = context.read<NewAccountCubit>();
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "i_am".tr(),
              style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400),
            ),
            SizedBox(height: 10.h),
            SizedBox(
              height: 50.h,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: widget.list?.length ?? 0,
                itemBuilder: (context, index) {
                  var item = widget.list?[index];

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        cubit.selectedUserType = item;
                      });
                    },
                    child: Container(
                      margin: EdgeInsets.only(right: 10.w),
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.r),
                        color: (cubit.selectedUserType?.id?.toString() ==
                                item?.id?.toString())
                            ? AppColors.primary
                            : Colors.grey[200],
                        border: Border.all(
                          color: (cubit.selectedUserType?.id?.toString() ==
                                  item?.id?.toString())
                              ? AppColors.primary
                              : Colors.transparent,
                        ),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        item?.name ?? "",
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          color: (cubit.selectedUserType?.id?.toString() ==
                                  item?.id?.toString())
                              ? AppColors.white
                              : Colors.black,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
