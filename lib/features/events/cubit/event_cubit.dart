
import 'package:mawhebtak/core/utils/widget_from_application.dart';
import 'package:mawhebtak/features/calender/cubit/calender_cubit.dart';
import 'package:mawhebtak/features/events/data/repo/event_repo_impl.dart';
import '../../../config/routes/app_routes.dart';
import '../../../core/exports.dart';
import '../data/model/event_details_model.dart';

part 'event_state.dart';

class EventCubit extends Cubit<EventState> {
  EventCubit(this.api) : super(EventInitial());
  EventRepo api;
  int selectedIndex = 0;
  void changeToggle(index) {
    selectedIndex = index;
    emit(ChangeToggleState());
  }

  String selectedCurrency = "";

  void changeCurrency(String currency) {
    selectedCurrency = currency;
    emit(ChangeCurrencyState());
  }

  GetMainEvenDetailsModel? eventDetails;
  getEventDetailsById(String id, BuildContext context) async {
    try {
      emit(GetEventDetailsLoadingState());
      final result = await api.getEventDetailsById(id);
      result.fold((l) {
        errorGetBar(l.toString());
        emit(GetEventDetailsErrorState());
      }, (r) {
        if (r.status == 200) {
          eventDetails = r;

          // if (eventDetails?.data?.isFollowed == true) {
          //   Navigator.pushNamed(context, Routes.detailsEventRoute,
          //       arguments: eventDetails?.data?.id.toString());
          // } else {
          //   Navigator.pushNamed(context, Routes.secondDetailsSecond,
          //       arguments: eventDetails?.data?.id.toString());
          // }

          emit(GetEventDetailsLoadedState());
        } else {
          errorGetBar(r.msg ?? 'Error occurred');
          emit(GetEventDetailsErrorState());
        }
      });
    } catch (e) {
      errorGetBar(e.toString());
      emit(GetEventDetailsErrorState());
    }
  }

  followUnfollowEvent({
    required String id,
    required BuildContext context,
     int? paymentMethod
  }) async {
    try {
      emit(FollowUnFollowEventLoadingState());
      final result = await api.followUnfollowEvent(eventId: id,paymentMethod: paymentMethod );
      result.fold((l) {
        errorGetBar(l.toString());
        emit(FollowUnFollowEventErrorState());
      }, (r) {
        if (r.status == 200) {
          successGetBar(r.msg ?? 'Success');
          getEventDetailsById(id, context);
          emit(FollowUnFollowEventLoadedState());
        } else {
          errorGetBar(r.msg ?? 'Error occurred');
          emit(FollowUnFollowEventErrorState());
        }
      });
    } catch (e) {
      errorGetBar(e.toString());
      emit(FollowUnFollowEventErrorState());
    }
  }


  scanQrCode({
    required String? eventFollowerId,
  }) async {
    try {
      emit(ScanQrCodeLoadingState());
      final result = await api.scanQrCode(eventFollowerId:eventFollowerId);
      result.fold((l) {
        errorGetBar(l.toString());
        emit(ScanQrCodeErrorState());
      }, (r) {
        if(r.status == 200 ){
          successGetBar(r.msg.toString());
          emit(ScanQrCodeLoadedState());
        }
        else{
          errorGetBar(r.msg.toString());
        }

      });
    } catch (e) {
      errorGetBar(e.toString());
      emit(ScanQrCodeErrorState());
    }
  }

  //! 00:00

  TextEditingController priceApplyController = TextEditingController();
  TextEditingController noteApplyController = TextEditingController();
  Requirement? selectedRequirement;
  applyToEvent(String eventId, BuildContext context) async {
    try {
      AppWidgets.create2ProgressDialog(context);
      emit(FollowUnFollowEventLoadingState());
      final result = await api.applyToEvent(eventId, priceApplyController.text,
          selectedRequirement?.id?.toString() ?? '', noteApplyController.text,
          files: [
            ...context.read<CalenderCubit>().myImagesF ?? [],
            ...context.read<CalenderCubit>().validVideos
          ]);
      result.fold((l) {
        errorGetBar(l.toString());
        emit(FollowUnFollowEventErrorState());
      }, (r) {
        if (r.status == 200) {
          successGetBar(r.msg ?? 'Success');
          getEventDetailsById(eventId, context);

          emit(FollowUnFollowEventLoadedState());
        } else {
          errorGetBar(r.msg ?? 'Error occurred');
          emit(FollowUnFollowEventErrorState());
        }
        context.read<CalenderCubit>().myImagesF = null;
        context.read<CalenderCubit>().myImages = null;
        context.read<CalenderCubit>().validVideos = [];
        selectedRequirement = null;
        priceApplyController.clear();
        noteApplyController.clear();
        Navigator.pop(context);
        Navigator.pop(context);
      });
    } catch (e) {
      errorGetBar(e.toString());
      emit(FollowUnFollowEventErrorState());
    }
  }

  Future deleteEvent(String id, BuildContext context, bool isDeeplink) async {
    try {
      AppWidgets.create2ProgressDialog(context);
      emit(DeleteEventLoadingState());
      final res = await api.deleteEvent(id);
      res.fold((l) {
        errorGetBar(l.toString());
        Navigator.pop(context);
        emit(DeleteEventErrorState());
      }, (r) {
        if (r.status == 200) {
          successGetBar(r.msg ?? 'Success');
          context.read<CalenderCubit>().getMyEvents();
          emit(DeleteEventLoadedState());
        } else {
          errorGetBar(r.msg ?? 'Error occurred');
          emit(DeleteEventErrorState());
        }

        Navigator.pop(context);

        if (isDeeplink) {
          Navigator.pushReplacementNamed(context, Routes.mainRoute);
        } else {
          Navigator.pop(context);
        }
      });
    } catch (e) {
      errorGetBar(e.toString());
      emit(DeleteEventErrorState());
    }
  }

  Future actionEventRequest(
      String eventId, String status, String id, BuildContext context) async {
    try {
      AppWidgets.create2ProgressDialog(context);
      emit(ActionRequestEventLoadingState());
      final res = await api.actionEventRequest(eventId: id, status: status);
      res.fold((l) {
        errorGetBar(l.toString());
        Navigator.pop(context);
        emit(ActionRequestEventErrorState());
      }, (r) {
        if (r.status == 200) {
          successGetBar(r.msg ?? 'Success');
          getEventDetailsById(eventId, context);
          emit(ActionRequestEventLoadedState());
        } else {
          errorGetBar(r.msg ?? 'Error occurred');
          emit(ActionRequestEventErrorState());
        }
        Navigator.pop(context);
      });
    } catch (e) {
      errorGetBar(e.toString());
      emit(ActionRequestEventErrorState());
    }
  }
}
