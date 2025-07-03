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
        emit(HomeStateLoaded(r));
      });
    } catch (e) {
      emit(HomeStateError(e.toString()));
      return null;
    }
  }
  void removeTalentById(String id) {
    homeModel?.data?.topTalents?.removeWhere((e) => e.id == id);
    emit(HomeStateLoaded(homeModel!));
  }




}
