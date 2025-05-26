import 'dart:io';

import 'package:mawhebtak/features/events/data/repo/event_repo_impl.dart';

import '../../../config/routes/app_routes.dart';
import '../../../core/exports.dart';
import '../../../core/widgets/media_picker.dart';
import '../../calender/data/model/countries_model.dart';
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

  String selectedCurrency = "L.E";

  void changeCurrency(String currency) {
    selectedCurrency = currency;
    emit(ChangeCurrencyState());
  }

  File? selectedImage;
  File? selectedVideo;

  Future<void> pickMedia(BuildContext context) async {
    MediaPickerHelper.pickMedia(
      context: context,
      onImagePicked: (image) {
        selectedImage = image;
        selectedVideo = null;
        emit(ImagePickedState());
      },
      onVideoPicked: (video) {
        selectedVideo = video;
        selectedImage = null;
        emit(VideoPickedState());
      },
    );
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
}
