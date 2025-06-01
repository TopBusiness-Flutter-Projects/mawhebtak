import 'package:bloc/bloc.dart';
import 'package:mawhebtak/features/home/data/repositories/top_events_repository.dart';
import 'package:mawhebtak/injector.dart';
import 'package:meta/meta.dart';
import '../../data/models/top_events_model.dart';
part 'top_events_state.dart';

class TopEventsCubit extends Cubit<TopEventsState> {
  TopEventsCubit() : super(SeeAllEventStateLoading());
  TopEventsRepository? topEventsRepository = TopEventsRepository(
    serviceLocator(),
  );
  TopEventsModel? topEvents;
  bool isLoadingMore = false;
  topEventsData({
    bool isGetMore = false,
    required String page,
    String? orderBy,
  }) async {
    if (isGetMore) {
      isLoadingMore = true;
      emit(SeeAllEventStateLoadingMore());
    } else {
      emit(SeeAllEventStateLoading());
    }
    try {
      final res = await topEventsRepository!
          .topEventsData(page: page, orderBy: orderBy);

      res.fold((l) {
        emit(TopEventsStateError(l.toString()));
      }, (r) {
        if (isGetMore) {
          topEvents = TopEventsModel(
              status: r.status,
              links: r.links,
              msg: r.msg,
              data: [...topEvents!.data!, ...r.data!]);
          emit(TopEventsStateLoaded(topEvents!));
        } else {
          topEvents = r;
          emit(TopEventsStateLoaded(r));
        }
        emit(TopEventsStateLoaded(r));
      });
    } catch (e) {
      emit(TopEventsStateError(e.toString()));
    } finally {
      isLoadingMore = false;
    }
  }
}
