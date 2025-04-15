import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/exports.dart';
import '../../home/screens/home_screen.dart';
import '../data/repo/main_repo_impl.dart';
import 'state.dart';

class MainCubit extends Cubit<MainState> {
  MainCubit(this.api) : super(MainInitial());
  MainRepoImpl api;
  List<Widget> screens = [
    HomeScreen(),
      Container(color: AppColors.black,),
      Container(width: 200,height: 200,color: AppColors.secondPrimary,),
      Container(width: 200,height: 200,color: AppColors.blackLite,),
    // const MyReservationsScreen(),
    // const FavouritesScreen(),
    // const AccountScreen()
  ];
  int currentpage = 0;

  changePage(int index) {
    currentpage = index;
    emit(ChangepageIndexx());
  }
}
