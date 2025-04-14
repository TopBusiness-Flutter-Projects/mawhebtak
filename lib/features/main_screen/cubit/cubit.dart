import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_club/core/exports.dart';
import 'package:travel_club/features/favourites/screens/favourites_screen.dart';
import 'package:travel_club/features/home/screens/home_screen.dart';
import 'package:travel_club/features/my_account/screens/account_screen.dart';
import '../../my_bookings/view/my_reservations_screen.dart';
import '../data/repo/main_repo_impl.dart';
import 'state.dart';

class MainCubit extends Cubit<MainState> {
  MainCubit(this.api) : super(MainInitial());
  MainRepoImpl api;
  List<Widget> screens = [
    const HomeScreen(),
    const MyReservationsScreen(),
    const FavouritesScreen(),
    const AccountScreen()
  ];
  int currentpage = 0;

  changePage(int index) {
    currentpage = index;
    emit(ChangepageIndex());
  }
}
