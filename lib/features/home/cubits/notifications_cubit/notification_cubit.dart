import 'package:bloc/bloc.dart';
import 'package:mawhebtak/core/exports.dart';
import 'package:mawhebtak/features/home/data/models/notifications_model.dart';
import 'package:mawhebtak/features/home/data/repositories/notification_repository.dart';
import 'package:meta/meta.dart';

part 'notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  NotificationCubit() : super(NotificationInitial());
  NotificationsRepository? api = NotificationsRepository(serviceLocator());
  GetNotificationsModel? getNotificationsModel;
  notificationsData() async {
   emit(NotificationLoading());
    try {
      final res = await api!.notificationsData();

      res.fold((l) {
        emit(NotificationError(l.toString()));
      }, (r) {
        getNotificationsModel = r;
        emit(NotificationLoaded());

      });
    } catch (e) {
      emit(NotificationError(e.toString()));
    }
  }

}
