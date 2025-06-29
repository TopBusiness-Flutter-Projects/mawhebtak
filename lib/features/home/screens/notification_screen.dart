import 'package:mawhebtak/core/utils/filter.dart';
import 'package:mawhebtak/core/widgets/show_loading_indicator.dart';
import 'package:mawhebtak/features/home/cubits/notifications_cubit/notification_cubit.dart';
import 'package:mawhebtak/features/home/screens/widgets/notification_widget.dart';
import '../../../core/exports.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  late final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    context
        .read<NotificationCubit>()
        .notificationsData(page: '1', paginate: 'true');
    scrollController.addListener(_scrollListener);
    super.initState();
  }

  _scrollListener() {
    if (scrollController.position.maxScrollExtent == scrollController.offset) {
      if (context
              .read<NotificationCubit>()
              .getNotificationsModel
              ?.links
              ?.next !=
          null) {
        Uri uri = Uri.parse(context
                .read<NotificationCubit>()
                .getNotificationsModel
                ?.links
                ?.next ??
            "");
        String? page = uri.queryParameters['page'];
        context.read<NotificationCubit>().notificationsData(
            page: page ?? '1',
            isGetMore: true,
            orderBy: selctedFilterOption?.key);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotificationCubit, NotificationState>(
      builder: (BuildContext context, state) {
        var cubit = context.read<NotificationCubit>();
        return Scaffold(
          body: Column(
            children: [
              SizedBox(
                height: 20.h,
              ),
              CustomSimpleAppbar(title: 'notification'.tr()),
              Expanded(
                child: (state is NotificationLoading)
                    ? const Center(
                        child: CustomLoadingIndicator(),
                      )
                    : (cubit.getNotificationsModel?.data?.length == 0)
                        ? Center(
                            child: Text("no_data".tr()),
                          )
                        : ListView.separated(
                            shrinkWrap: true,
                            controller: scrollController,
                            itemCount:
                                cubit.getNotificationsModel?.data?.length ?? 0,
                            itemBuilder: (BuildContext context, int index) {
                              return NotificationWidget(
                                notification:
                                    cubit.getNotificationsModel?.data?[index],
                              );
                            },
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return SizedBox(
                                height: 10.h,
                              );
                            },
                          ),
              )
            ],
          ),
        );
      },
    );
  }
}
