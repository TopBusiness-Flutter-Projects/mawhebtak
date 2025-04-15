

import 'package:mawhebtak/core/exports.dart';
import 'package:mawhebtak/features/more_screen/cubit/more_state.dart';
import 'package:mawhebtak/features/more_screen/data/repos/more.repo.dart';

class MoreCubit extends Cubit<MoreState> {
  MoreCubit(this.exRepo) : super(MoreInitial());
  MoreRepo exRepo ;
}
