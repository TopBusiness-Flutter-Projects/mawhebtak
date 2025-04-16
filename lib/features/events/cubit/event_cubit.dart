import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';

import '../../home/data/repo/home_repo_impl.dart';

part 'event_state.dart';

class EventCubit extends Cubit<EventState> {
  EventCubit(this.api) : super(EventInitial());
  HomeRepoImpl api;
  int selectedIndex=0;
  //change toogel in seconde details
  void changeToggle(index){
    selectedIndex = index;
    emit(ChangeToggleState());
  }
  String selectedCurrency = "L.E"; // داخل الState
  File? selectedImage; // الصورة اللي المستخدم يختارها
void changeCurency(String currency){
  selectedCurrency=currency;
  emit(ChangeCurrencyState());
}
  Future<void> pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery); // ممكن تغيري لـ camera لو عايزة الكاميرا

    if (pickedFile != null) {

        selectedImage = File(pickedFile.path);
        emit(ChangePhotoState());

    }
  }
}
