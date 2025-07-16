import 'package:mawhebtak/features/home/screens/widgets/custom_top_event.dart';
import 'package:mawhebtak/features/more/cubit/more_cubit.dart';
import 'package:mawhebtak/features/more/cubit/more_state.dart';
import '../../../core/exports.dart';

class MyEventsScreen extends StatefulWidget {
  const MyEventsScreen({super.key});

  @override
  State<MyEventsScreen> createState() => _MyEventsScreenState();
}

class _MyEventsScreenState extends State<MyEventsScreen> {
  @override
  void initState() {
    context.read<MoreCubit>().getMyEventData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MoreCubit, MoreState>(
      builder: (BuildContext context, state) {
        var cubit = context.read<MoreCubit>();
        return Scaffold(
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CustomSimpleAppbar(
                title: 'my_event'.tr(),
                isActionButton: false,

              ),
              (state is GetMyEventDataStateLoading)
                  ? Center(
                      child: Text("no_data".tr()),
                    )
                  : Expanded(
                      child: (context
                                  .read<MoreCubit>()
                                  .requestGigsModel
                                  ?.data
                                  ?.length ==
                              0)
                          ? Center(child: Text("no_data".tr()))
                          : Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20.0.w),
                              child: RefreshIndicator(
                                onRefresh: () async {
                                  cubit.getMyEventData();
                                },
                                child: ListView.separated(
                                  physics:
                                      const AlwaysScrollableScrollPhysics(),
                                  itemCount: context
                                          .read<MoreCubit>()
                                          .requestGigsModel
                                          ?.data
                                          ?.length ??
                                      0,
                                  shrinkWrap: true,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return CustomTopEventList(
                                      topEvent: context
                                          .read<MoreCubit>()
                                          .requestGigsModel
                                          ?.data?[index],
                                      isAll: true,
                                    );
                                  },
                                  separatorBuilder:
                                      (BuildContext context, int index) {
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
