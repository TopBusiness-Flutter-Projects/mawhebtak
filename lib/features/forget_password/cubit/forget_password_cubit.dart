
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mawhebtak/features/forget_password/cubit/forget_password_state.dart';
import 'package:mawhebtak/features/forget_password/data/repos/forget_password_repo.dart';


class ForgetPasswordCubit extends Cubit<ForgetPasswordState> {
  ForgetPasswordCubit(this.forgetPasswordRepo) : super(ForgetPasswordInitial());
  ForgetPasswordRepo forgetPasswordRepo;
  TextEditingController emailController = TextEditingController();
}
