import 'package:mawhebtak/features/more_screen/screens/more_screen.dart';

import '../../../core/exports.dart';
import '../../calender/screens/calender_screen.dart';
import '../../calender/screens/widgets/calender_widget.dart';
import '../../home/screens/home_screen.dart';
import '../data/repo/main_repo_impl.dart';
import 'state.dart';

class MainCubit extends Cubit<MainState> {
  MainCubit(this.api) : super(MainInitial());
  MainRepoImpl api;
  List<Widget> screens = [
    const HomeScreen(),
      Container(color: AppColors.black,),
    Container(color: AppColors.black,),
    const CalendarScreen(),


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
