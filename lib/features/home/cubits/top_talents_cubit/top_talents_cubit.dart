
import 'package:mawhebtak/features/home/data/models/top_talents_model.dart';
import 'package:mawhebtak/features/home/data/repositories/top_talents_repository.dart';
import 'package:mawhebtak/injector.dart';
import '../../../../core/exports.dart';
part 'top_talents_state.dart';

class TopTalentsCubit extends Cubit<TopTalentsState> {
  TopTalentsCubit() : super(TopTalentsStateLoading());
  TopTalentsRepository? api = TopTalentsRepository(serviceLocator());
 TopTalentsModel? topTalents;
  topTalentsData() async {
    try {
      final res = await api!.topTalentsData();

      res.fold((l) {
        emit(TopTalentsStateError(l.toString()));
      }, (r) {
        topTalents = r;
        emit(TopTalentsStateLoaded(r));
      });
    } catch (e) {
      emit(TopTalentsStateError(e.toString()));
      return null;
    }
  }
}
