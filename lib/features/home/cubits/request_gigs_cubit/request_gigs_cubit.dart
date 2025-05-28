
import 'package:bloc/bloc.dart';
import 'package:mawhebtak/features/home/data/models/request_gigs_model.dart';
import 'package:mawhebtak/features/home/data/repositories/request_gigs_repository.dart';
import 'package:mawhebtak/injector.dart';
import 'package:meta/meta.dart';
part 'request_gigs_state.dart';

class RequestGigsCubit extends Cubit<RequestGigsState> {
  RequestGigsCubit() : super(RequestGigsStateLoading());
  RequestGigsRepository? api = RequestGigsRepository(serviceLocator());
  RequestGigsModel? requestGigs;
  bool isLoadingMore = false;
  requestGigsData({bool isGetMore = false, required String page}) async {
    if (isGetMore) {
      isLoadingMore = true;
      emit(RequestGigsStateLoadingMore());
    } else {
      emit(RequestGigsStateLoading());
    }
    try {
      final res = await api!.requestGigsData(page: page);

      res.fold((l) {
        emit(RequestGigsStateError(l.toString()));
      }, (r) {
        if (isGetMore) {
          requestGigs = RequestGigsModel(
            links: r.links,
            status: r.status,
            msg: r.msg,
            data: [...requestGigs!.data!, ...r.data!],
          );
          emit(RequestGigsStateLoaded(requestGigs!));
        } else {
          requestGigs = r;
          emit(RequestGigsStateLoaded(requestGigs!));
        }
        emit(RequestGigsStateLoaded(r));
      });
    } catch (e) {
      emit(RequestGigsStateError(e.toString()));
    } finally {
      isLoadingMore = false;
    }
  }

}
