import 'package:mawhebtak/core/preferences/preferences.dart';
import 'package:mawhebtak/features/auth/login/data/models/login_model.dart';
import 'package:mawhebtak/features/profile/data/models/profile_model.dart';
import '../../../core/exports.dart';
import '../data/repo/profile_repo_impl.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(this.api) : super(ProfileInitial());
  ProfileRepo api;
  int selectedIndex = 0;
  bool isFollowing = true;

  changeSelected(int index) {
    selectedIndex = index;
    emit(ChangeIndexState());
  }

  toggleButton() {
    isFollowing = !isFollowing;
    emit(ChangeFollowersState());
  }

  Future<LoginModel> getUserFromPreferences() async {
    final user = await Preferences.instance.getUserModel();
    return user;
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
}
