import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mawhebtak/core/exports.dart';
import '../../../../core/preferences/preferences.dart';
import '../data/repos/login_repo.dart';
import 'state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this.api) : super(LoginStateInitial());
  LoginRepo api;

  login(
    String email,
    String password,
  ) async {
    emit(LoginStateLoading());
    try {
      final res = await api.login(email, password);

      res.fold((l) {
        emit(LoginStateError());
      }, (r) {
        if (r.status == 200) {
          Preferences.instance.setUser(r);
          successGetBar(r.msg ?? '');
          emit(LoginStateLoaded());
        } else {
          errorGetBar(r.msg ?? '');
          emit(LoginStateError());
        }
      });
    } catch (e) {
      emit(LoginStateError());
      return null;
    }

    //!
  }
}
