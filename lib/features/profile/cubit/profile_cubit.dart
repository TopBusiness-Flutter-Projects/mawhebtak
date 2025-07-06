import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mawhebtak/core/preferences/preferences.dart';
import 'package:mawhebtak/core/utils/widget_from_application.dart';
import 'package:mawhebtak/features/auth/login/data/models/login_model.dart';
import 'package:mawhebtak/features/auth/new_account/cubit/new_account_cubit.dart';
import 'package:mawhebtak/features/calender/data/model/countries_model.dart';
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
  double? review;
  String? fullPhoneFromWidget;
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController headlineController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController syndicateController = TextEditingController();
  TextEditingController bioController = TextEditingController();
  TextEditingController commentController = TextEditingController();
  List<GetCountriesMainModelData> selectedUserSubTypes = [];
  changeSelected(int index) {
    selectedIndex = index;
    emit(ChangeIndexState());
  }

  File? avatarImage;
  File? coverImage;

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

  String countryCode = '+20';
  saveData(BuildContext context) {
    countryCode = profileModel?.data?.countryCode ?? '+20';
    selectedGender = 'male';
    context.read<NewAccountCubit>().selectedUserType =
        profileModel?.data?.userType;
    selectedUserSubTypes = profileModel?.data?.userSubTypes ?? [];


    phoneController.text = profileModel?.data?.phone ?? '';
    nameController.text = profileModel?.data?.name ?? '';
    emailController.text = profileModel?.data?.email ?? "";
    bioController.text = profileModel?.data?.bio ?? "";
    ageController.text = (profileModel?.data?.age.toString() == null)
        ? ''
        : (profileModel?.data?.age?.toString() ?? "");
    syndicateController.text = (profileModel?.data?.syndicate == null)
        ? ''
        : (profileModel?.data?.syndicate.toString() ?? '');
    headlineController.text = profileModel?.data?.headline ?? '';
    locationController.text = profileModel?.data?.location ?? "";
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

  bool isLoadingMore = false;
  ProfileModel? profileModel;
  getProfileData({
    required BuildContext context,
    required String id,
  }) async {
    emit(GetProfileStateLoading());

    try {
      final res = await api.getProfileData(id: id);
      res.fold((l) {
        emit(GetProfileStateError(l.toString()));
      }, (r) async {
        if (r.status == 200) {
          isShowPhone = profileModel?.data?.isPhoneHidden == 0;
          profileModel = r;
          emit(GetProfileStateLoaded());
          Preferences.instance.getUserModel().then((v) {
            if (r.data?.id.toString() == v.data?.id.toString()) {
              var userModel = v;
              UserModel updatedUser = userModel.data!.copyWith(
                name: r.data?.name,
                email: r.data?.email,
                image: r.data?.avatar,
                phone: r.data?.phone,
              );
              Preferences.instance
                  .setUser(LoginModel(msg: '', status: 200, data: updatedUser));
            }
          });
          loadUserFromPreferences();
        } else {
          errorGetBar(r.msg ?? '');
          emit(GetProfileStateError(r.msg.toString()));
        }
      });
    } catch (e) {
      errorGetBar(e.toString());

      emit(GetProfileStateError(e.toString()));
    }
  }

  bool isShowPhone = false;
  void toggleShowPhone(bool value) {
    isShowPhone = value;
    profileModel?.data?.isPhoneHidden = value ? 0 : 1;
    emit(ProfileTogglePhoneState());
  }

  addReview({
    required BuildContext context,
    required String userId,
  }) async {
    AppWidgets.create2ProgressDialog(context);

    try {
      final res = await api.addReview(
        userId: userId,
        comment: commentController.text,
        review: review.toString(),
      );
      res.fold((l) {
        emit(AddReviewStateError(l.toString()));
      }, (r) {
        successGetBar(r.msg.toString());
        Navigator.pop(context);
        emit(AddReviewStateLoaded());
        commentController.clear();
        review = 0.0;

        getProfileData(context: context, id: userId);
      });
    } catch (e) {
      errorGetBar(e.toString());
      emit(AddReviewStateError(e.toString()));
    }
  }
  void addUserSubType(GetCountriesMainModelData userSubType) {
    selectedUserSubTypes.add(userSubType);
    emit(ProfileFormChanged());
  }

  void removeUserSubType(GetCountriesMainModelData userSubType) {
    selectedUserSubTypes.remove(userSubType);
    emit(ProfileFormChanged());
  }
  Future<void> updateProfileData(
      {required BuildContext context, required String profileId}) async {
    AppWidgets.create2ProgressDialog(context);
    String fullPhone =
        fullPhoneFromWidget ?? '$countryCode${phoneController.text.trim()}';
    try {
      final res = await api.updateProfileData(
        selectedUserSubType: selectedUserSubTypes,
        countryCode: countryCode,
        isPhoneHidden: isShowPhone ? 0 : 1,
        name: nameController.text.isEmpty ? null : nameController.text,
        phone: fullPhone,
        userSubTypeId:
            context.read<NewAccountCubit>().selectedUserSubType?.id.toString(),
        avatar: avatarImage != null && await avatarImage!.exists()
            ? avatarImage
            : null,
        byCaver: coverImage != null && await coverImage!.exists()
            ? coverImage
            : null,
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
        bio: bioController.text.isEmpty ? null : bioController.text,
        headline:
            headlineController.text.isEmpty ? null : headlineController.text,
        location:
            locationController.text.isEmpty ? null : locationController.text,
        age: ageController.text.isEmpty ? null : ageController.text,
        gender: selectedGender,
        syndicate:
            syndicateController.text.isEmpty ? null : syndicateController.text,
      );

      res.fold(
        (l) {
          errorGetBar(l.toString());
          emit(UpdateProfileStateError(l.toString()));
          Navigator.pop(context);
        },
        (r) {
          if (r.status == 200) {
            successGetBar(r.msg ?? 'Success');
            emit(UpdateProfileStateLoaded());
            coverImage = null;
            avatarImage = null;
            Navigator.pop(context);
            Navigator.pop(context);
            getProfileData(id: profileId, context: context);
          } else {
            errorGetBar(r.msg ?? '');
            emit(UpdateProfileStateError(r.msg.toString()));
            Navigator.pop(context);
          }
        },
      );
    } catch (e) {
      emit(UpdateProfileStateError(e.toString()));
    }
  }

  //! add experience
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  DateTime? fromDate;
  DateTime? toDate;
  bool isUntilNow = false;

  void setFromDate(DateTime date) {
    fromDate = date;
    emit(ExperienceFormChanged());
  }

  void setToDate(DateTime date) {
    toDate = date;
    emit(ExperienceFormChanged());
  }

  void toggleUntilNow(bool value) {
    isUntilNow = value;
    if (value) {
      toDate = null;
    }
    emit(ExperienceFormChanged());
  }

  Future<void> addNewExperience(BuildContext context) async {
    if (titleController.text.isEmpty || fromDate == null) {
      errorGetBar('please_fill_all_fields'.tr());

      emit(ExperienceError());
      return;
    }

    emit(ExperienceLoading());

    try {
      AppWidgets.create2ProgressDialog(context);
      final result = await api.addNewExperience(
        title: titleController.text.trim(),
        description: descriptionController.text.trim().isEmpty
            ? null
            : descriptionController.text.trim(),
        from: fromDate,
        to: isUntilNow ? null : toDate,
        isUntilNow: isUntilNow,
      );

      result.fold((l) {
        emit(ExperienceError());

        Navigator.pop(context);
      }, (r) {
        resetForm();
        successGetBar(r.msg.toString());
        emit(ExperienceSuccess());

        Navigator.pop(context);
        Navigator.pop(context);
        getProfileData(context: context, id: profileModel!.data!.id.toString());
      });
    } catch (e) {
      Navigator.pop(context);
      emit(ExperienceError());
    }
  }

  void initExperience(Experience exp) {
    titleController.text = exp.title ?? '';
    descriptionController.text = exp.description ?? '';
    fromDate = exp.from;
    toDate = exp.to;
    isUntilNow = (exp.to == null);
    emit(ProfileFormChanged());
  }

  /// Update an existing experience
  Future<void> updateExperience(BuildContext context,
      {required String id}) async {
    if (titleController.text.isEmpty || fromDate == null) {
      errorGetBar('please_fill_all_fields'.tr());
      emit(ExperienceError());
      return;
    }

    emit(ExperienceLoading());
    AppWidgets.create2ProgressDialog(context);

    final result = await api.updateExperience(
      id: id,
      title: titleController.text.trim(),
      description: descriptionController.text.trim().isEmpty
          ? null
          : descriptionController.text.trim(),
      from: fromDate,
      to: isUntilNow ? null : toDate,
      isUntilNow: isUntilNow,
    );

    result.fold((l) {
      Navigator.pop(context);
      emit(ExperienceError());
    }, (r) {
      resetForm();
      successGetBar(r.msg.toString());
      emit(ExperienceSuccess());
      Navigator.pop(context);
      Navigator.pop(context);
      getProfileData(
        context: context,
        id: profileModel!.data!.id.toString(),
      );
    });
  }

  void resetForm() {
    titleController.clear();
    descriptionController.clear();
    fromDate = null;
    toDate = null;
    isUntilNow = false;
  }
}
