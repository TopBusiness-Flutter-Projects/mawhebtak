import 'package:mawhebtak/core/exports.dart';

import 'package:mawhebtak/features/verification/data/repos/verification.repo.dart';

import 'verification_state.dart';

class VerificationCubit extends Cubit<VerificationState> {
  VerificationCubit(this.exRepo) : super(VerificationInitial());
  VerificationRepo exRepo;
}
