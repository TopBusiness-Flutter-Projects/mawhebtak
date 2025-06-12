import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mawhebtak/core/models/default_model.dart';
import 'package:mawhebtak/core/preferences/preferences.dart';
import 'package:mawhebtak/features/auth/login/data/models/login_model.dart';
import 'package:mawhebtak/features/location/cubit/location_cubit.dart';
import 'package:mawhebtak/features/profile/data/models/profile_model.dart';
import '../../../core/exports.dart';
import '../data/repo/profile_repo_impl.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(this.api) : super(ProfileInitial());
  ProfileRepo api;
  int selectedIndex = 0;
  bool isFollowing = true;
  List<String>? gender = ['male', 'female'];
  String? selectedGender;
  String? selectedGenderId;
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController headlineController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController syndicateController = TextEditingController();
  TextEditingController bioController = TextEditingController();
  changeSelected(int index) {
    selectedIndex = index;
    emit(ChangeIndexState());
  }

  File? avatarImage;
  File? coverImage;
  String? avatarUrl;
  String? coverUrl;

  Future<void> pickSingleImage({required String type}) async {
    try {
      final pickedFile =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedFile == null) return;

      File file = File(pickedFile.path);

      final imageBytes = await file.readAsBytes();
      if (imageBytes.length > 3 * 1024 * 1024) {
        final compressedImageBytes =
            await FlutterImageCompress.compressWithFile(
          file.path,
          quality: 75,
        );
        file = File('${file.path}.compressed.jpg');
        await file.writeAsBytes(compressedImageBytes!);
      }

      if (type == 'avatar') {
        avatarImage = file;
      } else if (type == 'cover') {
        coverImage = file;
      }

      emit(SuccessSelectNewImageProfileState());
    } on PlatformException catch (e) {
      debugPrint('Image picker error: $e');
    }
  }

  saveData() {
    selectedGender = 'male';
    avatarUrl = profileModel?.data?.avatar;
    coverUrl = profileModel?.data?.bgCover;
    phoneController.text = profileModel?.data?.phone ?? '';
    nameController.text = profileModel?.data?.name ?? '';
    emailController.text = profileModel?.data?.email ?? "";
    bioController.text = profileModel?.data?.bio ?? "";
    ageController.text = profileModel?.data?.age.toString() ?? "";
    syndicateController.text = profileModel?.data?.syndicate.toString() ?? "";
    headlineController.text = profileModel?.data?.headline.toString() ?? "";
    locationController.text = profileModel?.data?.location.toString() ?? "";
    emit(EditingState());
  }

  toggleButton() {
    isFollowing = !isFollowing;
    emit(ChangeFollowersState());
  }

  LoginModel? user;
  Future<void> loadUserFromPreferences() async {
    user = await Preferences.instance.getUserModel();
  }

  ProfileModel? profileModel;
  getProfileData({
    required String id,
  }) async {
    emit(GetProfileStateLoading());
    try {
      final res = await api.getProfileData(id: id);
      res.fold((l) {
        emit(GetProfileStateError(l.toString()));
      }, (r) {
        profileModel = r;
        emit(GetProfileStateLoaded());
      });
    } catch (e) {
      emit(GetProfileStateError(e.toString()));
    }
  }

  DefaultMainModel? defaultMainModel;

  Future<void> updateProfileData({required BuildContext context}) async {
    emit(UpdateProfileStateLoading());
    try {
      final res = await api.updateProfileData(
        name: nameController.text,
        phone: phoneController.text,
        userSubTypeId: selectedGenderId,
        email: emailController.text,
        avatar: avatarImage ?? File(''),
        byCaver: coverImage ?? File(''),
        lat: context
                .read<LocationCubit>()
                .selectedLocation
                ?.latitude
                .toString() ??
            "0.0",
        long: context
                .read<LocationCubit>()
                .selectedLocation
                ?.longitude
                .toString() ??
            "0.0",
        bio: bioController.text,
        headline: headlineController.text,
        location: locationController.text,
        age: ageController.text,
        gender: selectedGender,
        syndicate: syndicateController.text,
      );

      res.fold(
        (failure) {
          emit(UpdateProfileStateError(failure.toString()));
        },
        (result) {
          defaultMainModel = result;
          emit(GetProfileStateLoaded());
        },
      );
    } catch (e) {
      emit(UpdateProfileStateError(e.toString()));
    }
  }
}
