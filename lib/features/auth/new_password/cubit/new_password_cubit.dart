
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mawhebtak/features/auth/new_password/cubit/new_password_state.dart';
import '../data/repos/new_password_repo.dart';


class NewPasswordCubit extends Cubit<NewPasswordState> {
  NewPasswordCubit(this.forgetPasswordRepo) : super(NewPasswordInitial());
  NewPasswordRepo forgetPasswordRepo;
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
}
