import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

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
}
