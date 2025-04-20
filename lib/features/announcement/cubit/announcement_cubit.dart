import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../data/repo/announcement_repo_impl.dart';

part 'announcement_state.dart';

class AnnouncementCubit extends Cubit<AnnouncementState> {
  AnnouncementCubit(this.api) : super(AnnouncementInitial());
  AnnouncementRepoImpl api;

}
