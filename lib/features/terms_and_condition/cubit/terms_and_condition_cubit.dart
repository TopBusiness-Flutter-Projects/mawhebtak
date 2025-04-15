
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mawhebtak/features/terms_and_condition/cubit/terms_and_condition_state.dart';
import '../data/repos/terms_and_condition_repo.dart';


class TermsAndConditionCubit extends Cubit<TermsAndConditionState> {
  TermsAndConditionCubit(this.forgetPasswordRepo) : super(TermsAndConditionInitial());
  TermsAndConditionRepo forgetPasswordRepo;
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
}
