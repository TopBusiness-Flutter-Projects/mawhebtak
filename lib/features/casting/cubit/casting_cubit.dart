import 'package:mawhebtak/core/exports.dart';

import '../data/repos/casting.repo.dart';
import 'casting_state.dart';

class CastingCubit extends Cubit<CastingState> {
  CastingCubit(this.exRepo) : super(CastingInitial());
  CastingRepo exRepo;
}
