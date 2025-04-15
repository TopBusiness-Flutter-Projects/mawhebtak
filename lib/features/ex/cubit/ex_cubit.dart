

import 'package:mawhebtak/core/exports.dart';
import 'package:mawhebtak/features/ex/cubit/ex_state.dart';
import 'package:mawhebtak/features/ex/data/repos/ex.repo.dart';

class ExCubit extends Cubit<ExState> {
  ExCubit(this.exRepo) : super(ExInitial());
  ExRepo exRepo ;
}
