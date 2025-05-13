import 'dart:io';
import 'package:mawhebtak/features/events/data/models/sell_all_event_model.dart';
import 'package:mawhebtak/features/events/data/repo/event_repo_impl.dart';

import '../../../core/exports.dart';
import '../../../core/widgets/media_picker.dart';

part 'event_state.dart';

class EventCubit extends Cubit<EventState> {
  EventCubit(this.api) : super(EventInitial());
  EventRepo api;
  int selectedIndex=0;
  void changeToggle(index){
    selectedIndex = index;
    emit(ChangeToggleState());
  }
  String selectedCurrency = "L.E";


  void changeCurrency(String currency){
  selectedCurrency=currency;
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
  SeeAllEventModel? seeAllEventModel;
  seeAllEventData() async {
    emit(SeeAllEventStateLoading());
    try {
      final res = await api.seeAllEventData();

      res.fold((l) {
        emit(SeeAllEventStateError(l.toString()));
      }, (r) {
        seeAllEventModel = r;
        emit(SeeAllEventStateLoaded(r));
      });
    } catch (e) {
      emit(SeeAllEventStateError(e.toString()));
      return null;
    }
  }



}
