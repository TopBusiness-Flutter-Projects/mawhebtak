

import 'package:mawhebtak/core/exports.dart';
import 'package:mawhebtak/features/calender/cubit/calender_state.dart';
import 'package:mawhebtak/features/calender/data/repos/calender.repo.dart';

class CalenderCubit extends Cubit<CalenderState> {
  CalenderCubit(this.exRepo) : super(CalenderInitial());
  CalenderRepo exRepo ;
}
