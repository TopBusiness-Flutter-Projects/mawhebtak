// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:travel_club/core/exports.dart';
// import 'package:travel_club/features/home/data/models/home_model.dart';
// import '../../entertainment/data/model/get_ways_model.dart';
// import '../../food/data/models/get_catogrey_model.dart';
// import '../../food/data/models/get_resturant_model.dart';
// import '../../other_services/data/models/get_others_model.dart';
// import '../../other_services/data/models/sub_services_model.dart';
// import '../../residence/data/models/lodges_model.dart';
// import '../../transportation/data/models/get_companies_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/exports.dart';
import '../data/models/home_filter_model.dart';
import '../data/models/home_model.dart';
import '../data/repo/home_repo_impl.dart';
import '../screens/home_screen.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this.api) : super(HomeInitial());
  HomeRepoImpl api;
  int moduleslenth = 5;
  TextEditingController searchController = TextEditingController();

   String? selectedModule;
  final List<HomeItem> items = [
    HomeItem(icon: Icons.event, label: 'Events'),
    HomeItem(icon: Icons.leaderboard, label: 'Events'),
    HomeItem(icon: Icons.announcement, label: 'Casting'),
    HomeItem(icon: Icons.announcement, label: 'Records'),
    HomeItem(icon: Icons.announcement, label: 'Announce'),
    HomeItem(icon: Icons.work, label: 'Jobs'),
    HomeItem(icon: Icons.work, label: 'Jobs'),
    HomeItem(icon: Icons.work, label: 'Jobs'),
    HomeItem(icon: Icons.work, label: 'Jobs'),
    HomeItem(icon: Icons.work, label: 'Jobs'),

  ];
   // المتغير الذي يحمل القيمة المختارة
  void removeImage(int indexx){
    print(indexx);
    print(items.length);
    items.removeAt(indexx);
    emit(ImageDeleted());
  }
  // ModuleModel? selectedModulee; // حفظ الكائن المختار
  // String? moduleId; // حفظ الكائن المختار
  //
  // void selectModule(ModuleModel module) {
  //   selectedModulee = module;
  //   print("module id is "+'${selectedModulee?.id.toString()}');
  //   moduleId=selectedModulee?.id.toString();
  //   emit(HomeModuleSelected()); // تحديث الحالة
  // }
  // GetHomeModel homeModel = GetHomeModel();
  // getHomeData() async {
  //   emit(LoadingHomeData());
  //   final res = await api.getHome();
  //   res.fold((l) {
  //     emit(ErrorGetHomeData());
  //   }, (r) {
  //     homeModel = r;
  //     homeModel.data!.modules =
  //         homeModel.data!.modules!.sublist(0, moduleslenth);
  //     emit(SucessGetHomeData());
  //   });
  // }
  GetHomeFilter homeFilterModel = GetHomeFilter();
  // GetLodgesModel residenceFavouriteModel = GetLodgesModel();
  // GetRestaurantModel getRestaurantModel = GetRestaurantModel();
  // GetCompaniesModel transportationFavouriteModel = GetCompaniesModel();
  // GetOthersModel othersModel = GetOthersModel();
  // GetWaysModel getWaysModel = GetWaysModel();


  // int selectedIndex = 0;
  // void changeContainer(int index, BuildContext context) {
  //   print("index $index");
  //   selectedIndex = index;
  //   searchController.clear();
  //   getHomeFilterData(context: context);
  //   emit(IndexChanged());
  // }

  // onChangeSearch(String? value, BuildContext context) {
  //   getHomeFilterData(context: context);
  // }
}
