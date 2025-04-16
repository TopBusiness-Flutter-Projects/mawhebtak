import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mawhebtak/features/more_screen/screens/more_screen.dart';

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
    Container(color: AppColors.black,),
    Container(color: AppColors.black,),


    const MoreScreen(),
    // const MyReservationsScreen(),
    // const FavouritesScreen(),

  ];
  int currentpage = 0;

  changePage(int index) {
    currentpage = index;
    emit(ChangepageIndexx());
  }
}
