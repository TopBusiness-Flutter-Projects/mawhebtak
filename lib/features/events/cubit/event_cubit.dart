import 'dart:io';
import '../../../core/exports.dart';
import '../../../core/widgets/media_picker.dart';
import '../../home/data/repo/home_repo_impl.dart';

part 'event_state.dart';

class EventCubit extends Cubit<EventState> {
  EventCubit(this.api) : super(EventInitial());
  HomeRepo api;
  int selectedIndex=0;
  //change toogel in seconde details
  void changeToggle(index){
    selectedIndex = index;
    emit(ChangeToggleState());
  }
  String selectedCurrency = "L.E"; // داخل الState
  // File? selectedImage; // الصورة اللي المستخدم يختارها
  // File? selectedVideo;

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

  // Future<void> pickImage() async {
  //   final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
  //   if (picked != null) {
  //     selectedImage = File(picked.path);
  //     selectedVideo = null; // Reset if previously selected video
  //     emit(ImagePickedState()); // اعمل emit لحالة جديدة
  //   }
  // }
  //
  // Future<void> pickVideo() async {
  //   final picked = await ImagePicker().pickVideo(source: ImageSource.gallery);
  //   if (picked != null) {
  //     selectedVideo = File(picked.path);
  //     selectedImage = null; // Reset if previously selected image
  //     emit(VideoPickedState());
  //   }
  // }
  // Future<void> pickMedia(BuildContext context) async {
  //   showModalBottomSheet(
  //     context: context,
  //     builder: (_) {
  //       return SafeArea(
  //         child: Column(
  //           mainAxisSize: MainAxisSize.min,
  //           children: [
  //             ListTile(
  //               leading: Icon(Icons.photo),
  //               title: Text("Choose Image"),
  //               onTap: () {
  //                 Navigator.pop(context);
  //                 pickImage(); // الصورة
  //               },
  //             ),
  //             ListTile(
  //               leading: Icon(Icons.videocam),
  //               title: Text("Choose Video"),
  //               onTap: () {
  //                 Navigator.pop(context);
  //                 pickVideo(); // الفيديو
  //               },
  //             ),
  //           ],
  //         ),
  //       );
  //     },
  //   );
  // }

}
