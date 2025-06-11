

import 'package:mawhebtak/core/exports.dart';
import 'package:mawhebtak/core/preferences/preferences.dart';
import 'package:mawhebtak/features/auth/login/data/models/login_model.dart';
import 'package:mawhebtak/features/more_screen/cubit/more_state.dart';
import 'package:mawhebtak/features/more_screen/data/repos/more.repo.dart';

class MoreCubit extends Cubit<MoreState> {
  MoreCubit(this.exRepo) : super(MoreInitial());
  MoreRepo exRepo ;
  Future<LoginModel> getUserFromPreferences() async {
    final user = await Preferences.instance.getUserModel();
    return user;
  }

  LoginModel? user;
  Future<void> loadUserFromPreferences() async {
    user = await Preferences.instance.getUserModel();
  }
}
