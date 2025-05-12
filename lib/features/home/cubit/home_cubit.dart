import 'package:mawhebtak/features/home/data/models/home_model.dart';
import '../../../core/exports.dart';
import '../data/repo/home_repo_impl.dart';
import '../screens/home_screen.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this.api) : super(HomeStateLoading());
  HomeRepo api;
  TextEditingController searchController = TextEditingController();
  final List<HomeItem> items = [
    HomeItem(
        icon: AppIcons.eventCalenderSecondColorIcon,
        label: 'Events',
        colorIcon: AppColors.secondPrimary),
    HomeItem(icon: AppIcons.aboutUs, label: 'Casting'),
    HomeItem(icon: AppIcons.announceIcon, label: 'Announce'),
    HomeItem(icon: AppIcons.jopIcon, label: 'Jobs'),
    HomeItem(icon: AppIcons.assistantIcon, label: 'Assistant'),
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
}

