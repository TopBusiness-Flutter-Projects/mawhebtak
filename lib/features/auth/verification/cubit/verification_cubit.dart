import 'package:mawhebtak/core/exports.dart';

import 'package:mawhebtak/features/auth/verification/data/repos/verification.repo.dart';

import 'verification_state.dart';

class VerificationCubit extends Cubit<VerificationState> {
  VerificationCubit(this.exRepo) : super(VerificationInitial());
  VerificationRepo exRepo;
  final String correctOTP = "123456";
  TextEditingController pinController = TextEditingController();
  void validateOTP(String enteredOTP) {
    if (enteredOTP != correctOTP) {
      emit(state.copyWith(errorMessage: "Invalid Code, Enter Correct One"));
    } else {
      emit(state.copyWith(errorMessage: null));
      // Navigate or do something
    }
  }

  void clearError() {
    emit(state.copyWith(errorMessage: null));
  }
}
