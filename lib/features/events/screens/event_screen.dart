import 'package:easy_localization/easy_localization.dart';
import 'package:mawhebtak/core/utils/custom_loadingindicator.dart';
import 'package:mawhebtak/features/events/cubit/event_cubit.dart';
import 'package:mawhebtak/features/home/data/models/home_model.dart';
import '../../../core/exports.dart';
import '../../home/screens/widgets/custom_top_event.dart';

class EventScreen extends StatefulWidget {
  const EventScreen({super.key});

  @override
  State<EventScreen> createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen> {
  @override
  void initState() {
    context.read<EventCubit>().seeAllEventData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EventCubit, EventState>(
      builder: (BuildContext context, state) {
        var seeAllEventData = context.read<EventCubit>().seeAllEventModel;
        return Scaffold(
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomSimpleAppbar(
                title: 'events'.tr(),
                isActionButton: true,
              ),
              if (state is SeeAllEventStateLoading)
                const Center(
                  child: CustomLoadingIndicator(),
                ),
              Expanded(
                child: Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 20.0.w),
                  child: Center(
                    child: ListView.separated(
                      physics: const AlwaysScrollableScrollPhysics(),
                      itemCount: seeAllEventData?.data?.length ?? 0,
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        return CustomTopEventList(
                          topEvent: seeAllEventData?.data?[index],
                          isAll: true,
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return SizedBox(
                          height: 10.h,
                        );
                      },
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
}
