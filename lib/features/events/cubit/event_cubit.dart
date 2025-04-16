import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../home/data/repo/home_repo_impl.dart';

part 'event_state.dart';

class EventCubit extends Cubit<EventState> {
  EventCubit(this.api) : super(EventInitial());
  HomeRepoImpl api;
  int selectedIndex=0;
  void changeToggle(index){
    selectedIndex = index;
    emit(ChangeToggleState());
  }
}
