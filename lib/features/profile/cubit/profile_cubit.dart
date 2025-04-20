import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../core/exports.dart';
import '../../../core/widgets/media_picker.dart';
import '../data/repo/profile_repo_impl.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(this.api) : super(ProfileInitial());
  profileRepoImpl api;
  int selectedIndex = 0;
  bool isFollowing = true;

changeSelected(int index){
  selectedIndex=index;
  emit(ChangeIndexState());
}toggleButton(){
    isFollowing=!isFollowing;
  emit(ChangeFollowersState());
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

}
