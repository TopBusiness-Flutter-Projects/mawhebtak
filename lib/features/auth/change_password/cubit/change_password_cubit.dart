
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mawhebtak/features/auth/change_password/cubit/change_password_state.dart';
import '../data/repos/change_password_repo.dart';


class ChangePasswordCubit extends Cubit<ChangePasswordState> {
  ChangePasswordCubit(this.forgetPasswordRepo) : super(ChangePasswordInitial());
  ChangePasswordRepo forgetPasswordRepo;
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
}
