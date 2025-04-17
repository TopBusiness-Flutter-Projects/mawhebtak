import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mawhebtak/features/events/cubit/event_cubit.dart';

import '../../../core/exports.dart';
import '../../../core/widgets/custom_simple_appbar.dart';
import '../../home/screens/widgets/custom_top_event.dart';
import '../../home/screens/widgets/notification_widget.dart';

class EventScreen extends StatelessWidget {
  const EventScreen({super.key});

  @override
  Widget build(BuildContext context) {
  return BlocBuilder<EventCubit,EventState>(builder: (BuildContext context, state) {
       return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 20.h,),
          CustomSimpleAppbar(title: 'events'.tr(),isActionButton: true,),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Center(
                child: ListView.separated(
                  // scrollDirection: Axis.horizontal,
                  physics: AlwaysScrollableScrollPhysics(),
                  itemCount:10,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    return CustomTopEventList(isAll: true,);
                  }, separatorBuilder: (BuildContext context, int index) { return SizedBox(height: 10.h,); },),
              ),
            ),
          ),
          SizedBox(height: 20.h,)
        ],
      ),
    );
    },);
  }
}
