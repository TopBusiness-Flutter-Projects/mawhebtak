import 'package:mawhebtak/features/more/screens/more_screen.dart';
import '../../../core/exports.dart';
import '../../../core/preferences/preferences.dart';
import '../../auth/login/data/models/login_model.dart';
import '../../calender/screens/calender_screen.dart';
import '../../casting/screens/casting_screen.dart';
import '../../feeds/screens/feeds_screen.dart';
import '../../home/screens/home_screen.dart';
import '../data/repo/main_repo_impl.dart';
import 'state.dart';

class MainCubit extends Cubit<MainState> {
  MainCubit(this.api) : super(MainInitial()) {
    getUserData();
  }
  MainRepo api;
  List<Widget> screens = [
    const HomeScreen(),
    const FeedsScreen(),
    const CastingScreen(isFromHome: true),
    const CalendarScreen(),
    const MoreScreen(),
  ];
  int currentpage = 0;

  changePage(int index) {
    currentpage = index;
    emit(ChangepageIndexx());
  }

  LoginModel? loginModel;

  void getUserData() {
    Preferences.instance.getUserModel().then((value) {
      loginModel = value;
    });
    emit(GetUserDataState());
  }
}
