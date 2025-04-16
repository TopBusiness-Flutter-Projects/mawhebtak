
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mawhebtak/features/about_us/cubit/about_us_state.dart';
import 'package:mawhebtak/features/referral_code/cubit/referral_code_state.dart';
import '../data/repos/referral_code_repo.dart';


class ReferralCodeCubit extends Cubit<ReferralCodeState> {
  ReferralCodeCubit(this.forgetPasswordRepo) : super(ReferralCodeInitial());
  ReferralCodeRepo forgetPasswordRepo;
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
}
