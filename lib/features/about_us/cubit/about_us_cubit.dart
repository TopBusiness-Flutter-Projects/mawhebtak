
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mawhebtak/features/about_us/cubit/about_us_state.dart';
import '../data/repos/about_us_repo.dart';


class AboutUsCubit extends Cubit<AboutUsState> {
  AboutUsCubit(this.forgetPasswordRepo) : super(AboutUsInitial());
  AboutUsRepo forgetPasswordRepo;
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
}
