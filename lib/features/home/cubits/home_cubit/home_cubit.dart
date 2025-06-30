import 'package:easy_localization/easy_localization.dart';
import 'package:mawhebtak/core/preferences/preferences.dart';
import 'package:mawhebtak/features/auth/login/data/models/login_model.dart';

import 'package:mawhebtak/features/home/cubits/home_cubit/home_state.dart';
import 'package:mawhebtak/features/home/data/models/home_model.dart';
import 'package:mawhebtak/features/home/data/repositories/home_repository.dart';
import '../../../../core/exports.dart';
import '../../screens/home_screen.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this.api) : super(HomeStateLoading()) {}
  HomeRepository api;
  TextEditingController searchController = TextEditingController();
  final List<HomeItem> items = [
    HomeItem(
        title: 'events'.tr(),
        icon: AppIcons.eventCalenderSecondColorIcon,
        label: 'Events',
        colorIcon: AppColors.secondPrimary),
    HomeItem(
      title: 'casting'.tr(),
      icon: AppIcons.aboutUs,
      label: 'Casting',
    ),
    HomeItem(
      title: 'announcements'.tr(),
      icon: AppIcons.announceIcon,
      label: 'Announce',
    ),
    HomeItem(
      title: 'jobs'.tr(),
      icon: AppIcons.jopIcon,
      label: 'Jobs',
    ),
    HomeItem(
        title: 'assistant'.tr(),
        icon: AppIcons.assistantIcon,
        label: 'Assistant'),
  ];
  HomeModel? homeModel;
  homeData() async {
    emit(HomeStateLoading());
    try {
      final res = await api.homeData();
      res.fold((l) {
        emit(HomeStateError(l.toString()));
      }, (r) {
        homeModel = r;
        // if(r.data?.topTalents?[index].isIFollow == true){
        //   r.data?.topTalents?[index].isIFollow == true
        // }
        // else{
        //   r.data?.topTalents?[index].isIFollow == true
        // }
        emit(HomeStateLoaded(r));
      });
    } catch (e) {
      emit(HomeStateError(e.toString()));
      return null;
    }
  }



  updateTopTalentHomeFollow(TopTalent? item) {
    if (homeModel?.data?.topTalents != null) {
      for (int i = 0; i < (homeModel?.data?.topTalents?.length ?? 0); i++) {
        if (item?.id == homeModel?.data?.topTalents?[i].id) {
          if (item?.isIFollow == true) {
            homeModel?.data?.topTalents?[i].followersCount =
                (item?.followersCount ?? 0) + 1;
            homeModel?.data?.topTalents?[i].isIFollow = false;
          } else {
            homeModel?.data?.topTalents?[i].followersCount =
                (item?.followersCount ?? 0) - 1;
            homeModel?.data?.topTalents?[i].isIFollow = true;
          }
          homeModel?.data?.topTalents?[i].isIFollow = item?.isIFollow;
        }
      }
      emit(UpdateIsFollowState());
    }
  }
}
