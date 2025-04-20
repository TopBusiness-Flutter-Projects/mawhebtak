import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../core/exports.dart';
import '../../home/screens/home_screen.dart';
import '../data/repo/announcement_repo_impl.dart';

part 'announcement_state.dart';

class AnnouncementCubit extends Cubit<AnnouncementState> {
  AnnouncementCubit(this.api) : super(AnnouncementInitial());
  AnnouncementRepoImpl api;
  final List<HomeItem> items = [
    HomeItem(icon: Icons.event, label: 'Events'),
    HomeItem(icon: Icons.leaderboard, label: 'Events'),
    HomeItem(icon: Icons.announcement, label: 'Casting'),
    HomeItem(icon: Icons.announcement, label: 'Records'),
    HomeItem(icon: Icons.announcement, label: 'Announce'),
    HomeItem(icon: Icons.work, label: 'Jobs'),
    HomeItem(icon: Icons.work, label: 'Jobs'),
    HomeItem(icon: Icons.work, label: 'Jobs'),
    HomeItem(icon: Icons.work, label: 'Jobs'),
    HomeItem(icon: Icons.work, label: 'Jobs'),

  ];
}
