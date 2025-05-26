import 'package:easy_localization/easy_localization.dart';

import 'package:mawhebtak/core/exports.dart';
import 'package:mawhebtak/features/events/cubit/event_cubit.dart';

class ToggleTabs extends StatefulWidget {
  const ToggleTabs({super.key});

  @override
  State<ToggleTabs> createState() => _ToggleTabsState();
}

class _ToggleTabsState extends State<ToggleTabs> {
  @override
  Widget build(BuildContext context) {
    var cubit = context.read<EventCubit>();
    return BlocBuilder<EventCubit, EventState>(
      builder: (BuildContext context, state) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            // height: 40.h,
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: const Color(0xFFF5F5F5), // اللون الرمادي الكبير
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    // First tab
                    GestureDetector(
                      onTap: () {
                        cubit.changeToggle(0);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        decoration: BoxDecoration(
                          color: cubit.selectedIndex == 0
                              ? Colors.lightBlue
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        alignment: Alignment.center,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('events_details'.tr(),
                              style: getRegularStyle(
                                color: cubit.selectedIndex == 0
                                    ? Colors.white
                                    : Colors.grey,
                              )),
                        ),
                      ),
                    ),

                    // Second tab
                    GestureDetector(
                      onTap: () {
                        cubit.changeToggle(1);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        decoration: BoxDecoration(
                          color: cubit.selectedIndex == 1
                              ? Colors.lightBlue
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        alignment: Alignment.center,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('enrolled_users'.tr(),
                              style: getRegularStyle(
                                color: cubit.selectedIndex == 1
                                    ? Colors.white
                                    : Colors.grey,
                              )),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        cubit.changeToggle(2);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        decoration: BoxDecoration(
                          color: cubit.selectedIndex == 2
                              ? Colors.lightBlue
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        alignment: Alignment.center,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('event_requests'.tr(),
                              style: getRegularStyle(
                                color: cubit.selectedIndex == 2
                                    ? Colors.white
                                    : Colors.grey,
                              )),
                        ),
                      ),
                    ),
                    //! WE NEED ADD NEW TAB
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
