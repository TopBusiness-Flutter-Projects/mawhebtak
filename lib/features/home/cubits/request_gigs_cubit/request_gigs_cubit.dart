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
  requestGigsData(
  {
    bool isGetMore = false,
   required String page
}
      ) async {
   if ( isGetMore){
     emit(RequestGigsStateLoadingMore());
   }
    try {

      final res = await api!.requestGigsData(
        page: page
      );

      res.fold((l) {
        emit(RequestGigsStateError(l.toString()));
      }, (r) {
        if (isGetMore){
          requestGigs = RequestGigsModel(
            links: r.links,
            status: r.status,
            msg: r.msg,
            data:
            [...requestGigs!.data!, ...r.data!],
          );


        }else{
          requestGigs = r;
        }

        emit(RequestGigsStateLoaded(r));
      });
    } catch (e) {
      emit(RequestGigsStateError(e.toString()));
      return null;
    }
  }
}
/*
GetAllPartnersModel? allPartnersModel;
  getAllPartnersForReport(
      {int page = 1,
      bool? isUserOnly,
      int pageSize = 20, //num of products at one page
      bool isGetMore = false}) async {
    isGetMore
        ? emit(LoadingMorePartnersState())
        : emit(LoadingGetPartnersState());
    final result = await api.getAllPartnersForReport(page, pageSize,
        isUserOnly: isUserOnly ?? selectedProducsStockType == "stock");
    result.fold(
      (l) => emit(ErrorGetPartnersState()),
      (r) {
        if (isGetMore) {
          allPartnersModel = GetAllPartnersModel(
            count: r.count,
            next: r.next,
            prev: r.prev,
            result: [...allPartnersModel!.result!, ...r.result!],
          );
        } else {
          allPartnersModel = r;
        }
        print("loaded");
        emit(SucessGetPartnersState(allPartnersModel: allPartnersModel));
      },
    );
  }
 */