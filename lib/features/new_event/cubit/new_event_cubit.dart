

import 'package:mawhebtak/core/exports.dart';
import 'package:mawhebtak/features/ex/cubit/ex_state.dart';
import 'package:mawhebtak/features/ex/data/repos/ex.repo.dart';
import 'package:mawhebtak/features/new_event/cubit/new_event_state.dart';
import 'package:mawhebtak/features/new_event/data/repos/new_event.repo.dart';

class NewEventCubit extends Cubit<NewEventState> {
  NewEventCubit(this.exRepo) : super(NewEventInitial());
  NewEventRepo exRepo ;
}
