

import 'package:mawhebtak/core/exports.dart';
import 'package:mawhebtak/features/records/cubit/records_state.dart';

import '../data/repos/records.repo.dart';

class RecordsCubit extends Cubit<RecordsState> {
  RecordsCubit(this.exRepo) : super(RecordsInitial());
  RecordsRepo exRepo ;
  TextEditingController workNameController = TextEditingController();
}
