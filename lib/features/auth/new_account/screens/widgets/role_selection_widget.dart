
import 'package:mawhebtak/core/exports.dart';
import 'package:mawhebtak/features/auth/new_account/cubit/new_account_cubit.dart';
import 'package:mawhebtak/features/auth/new_account/cubit/new_account_state.dart';
import 'package:mawhebtak/features/calender/data/model/countries_model.dart';

class RoleSelectionWidget extends StatefulWidget {
  const RoleSelectionWidget({required this.list, super.key});
  final List<GetCountriesMainModelData> list;
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
              style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w400),
            ),
            SizedBox(height: 10.h),
            SizedBox(
              height: 50.h,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: widget.list.length,
                itemBuilder: (context, index) {
                  var item = widget.list[index];
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        cubit.selectedUserType = item;
                      });
                      cubit.getDataUserSubType(
                        userTypeId:
                            cubit.selectedUserType?.id?.toString() ?? '',
                      );
                    },
                    child: Container(
                      margin: EdgeInsets.only(right: 10.w),
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.r),
                        color: (cubit.selectedUserType?.id?.toString() ==
                                item.id?.toString())
                            ? AppColors.primary
                            : Colors.grey[200],
                        border: Border.all(
                          color: (cubit.selectedUserType?.id?.toString() ==
                                  item.id?.toString())
                              ? AppColors.primary
                              : Colors.transparent,
                        ),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        item.name ?? "",
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w400,
                          color: (cubit.selectedUserType?.id?.toString() ==
                                  item.id?.toString())
                              ? AppColors.white
                              : Colors.black,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            if (cubit.userSubTypeList?.data?.length != 0)
              Column(
                children: [
                  10.h.verticalSpace,
                  SizedBox(
                    height: 50.h,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: cubit.userSubTypeList?.data?.length ?? 0,
                      itemBuilder: (context, index) {
                        var item = cubit.userSubTypeList?.data?[index];
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              if (cubit.selectedUserSubTypes.contains(item)) {
                                cubit.selectedUserSubTypes.remove(item);
                              } else {
                                cubit.selectedUserSubTypes.add(item!);
                              }
                            });
                          },
                          child: Container(
                            margin: EdgeInsets.only(right: 10.w),
                            padding: EdgeInsets.symmetric(horizontal: 16.w),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.r),
                              color: cubit.selectedUserSubTypes.contains(item)
                                  ? AppColors.primary
                                  : Colors.grey[200],
                              border: Border.all(
                                color: (cubit.selectedUserSubType?.id
                                            ?.toString() ==
                                        item?.id?.toString())
                                    ? AppColors.primary
                                    : Colors.transparent,
                              ),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              item?.name ?? "",
                              style: TextStyle(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w400,
                                color: (cubit.selectedUserSubType?.id
                                            ?.toString() ==
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
                  if (cubit.selectedUserSubTypes.isNotEmpty)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        10.h.verticalSpace,
                        Wrap(
                          spacing: 8.w,
                          runSpacing: 8.h,
                          children: cubit.selectedUserSubTypes.map((selectedItem) {
                            return Chip(
                              label: Text(selectedItem?.name ?? ""),
                              onDeleted: () {
                                setState(() {
                                  cubit.selectedUserSubTypes.remove(selectedItem);
                                });
                              },
                              backgroundColor: AppColors.primary.withOpacity(0.2),
                              deleteIconColor: AppColors.primary,
                            );
                          }).toList(),
                        ),
                      ],
                    ),

                ],
              )
          ],
        );
      },
    );
  }
}
