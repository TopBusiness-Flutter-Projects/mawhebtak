import 'package:mawhebtak/core/exports.dart';
import 'package:mawhebtak/features/home/data/models/notifications_model.dart';
import 'package:mawhebtak/features/home/data/repositories/notification_repository.dart';
part 'notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  NotificationCubit() : super(NotificationInitial());
  NotificationsRepository? api = NotificationsRepository(serviceLocator());
  NotificationModel? getNotificationsModel;
  bool isLoadingMore = false;
  notificationsData({
    bool isGetMore = false,
    String? orderBy,
    String? paginate,
    String? page,
  }) async {
    if (isGetMore) {
      isLoadingMore = true;
      emit(NotificationLoadingMore());
    } else {
      emit(NotificationLoading());
    }
    try {
      final res = await api!.notificationsData(
        paginate: paginate,
        orderBy: orderBy,
        page: page,
      );

      res.fold((l) {
        emit(NotificationError(l.toString()));
      }, (r) {
        if (isGetMore) {
          getNotificationsModel = NotificationModel(
            links: r.links,
            status: r.status,
            msg: r.msg,
            data: [...getNotificationsModel!.data!, ...r.data!],
          );
          emit(NotificationLoaded());
        } else {
          getNotificationsModel = r;
          emit(NotificationLoaded());
        }
        emit(NotificationLoaded());
      });
    } catch (e) {
      emit(NotificationError(e.toString()));
    }
  }
}
