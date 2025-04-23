

import 'package:mawhebtak/core/exports.dart';

import '../../home/screens/home_screen.dart';
import '../data/repos/casting.repo.dart';
import 'casting_state.dart';

class CastingCubit extends Cubit<CastingState> {
  CastingCubit(this.exRepo) : super(CastingInitial());
  CastingRepo exRepo ;
  final List<HomeItem> items = [
    HomeItem(icon: Icons.event, label: 'Events'),
    HomeItem(icon: Icons.leaderboard, label: 'Events'),
    HomeItem(icon: Icons.announcement, label: 'Casting'),
    HomeItem(icon: Icons.announcement, label: 'Announce'),
    HomeItem(icon: Icons.announcement, label: 'Announce'),
    HomeItem(icon: Icons.work, label: 'Jobs'),
    HomeItem(icon: Icons.work, label: 'Jobs'),
    HomeItem(icon: Icons.work, label: 'Jobs'),
    HomeItem(icon: Icons.work, label: 'Jobs'),
    HomeItem(icon: Icons.work, label: 'Jobs'),
  ];
}
