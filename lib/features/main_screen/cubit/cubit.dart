import 'package:mawhebtak/features/feeds/cubit/feeds_cubit.dart';
import 'package:mawhebtak/features/more_screen/screens/more_screen.dart';

import '../../../core/exports.dart';
import '../../calender/screens/calender_screen.dart';
import '../../casting/screens/casting_screen.dart';
import '../../feeds/screens/feeds_screen.dart';
import '../../home/screens/home_screen.dart';
import '../data/repo/main_repo_impl.dart';
import 'state.dart';

class MainCubit extends Cubit<MainState> {
  MainCubit(this.api) : super(MainInitial());
  MainRepo api;
  List<Widget> screens = [
    const HomeScreen(),
    BlocProvider(
        create: (context) => FeedsCubit()..postsData(page: '1'),
        child: const FeedsScreen()),
    const CastingScreen(),
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
