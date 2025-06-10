import 'package:equatable/equatable.dart';
import 'package:mawhebtak/features/home/cubits/home_cubit/home_cubit.dart';
import 'package:mawhebtak/features/home/data/models/top_talents_model.dart';
import 'package:mawhebtak/features/home/data/repositories/top_talents_repository.dart';

import '../../../../core/exports.dart';
import '../../data/models/home_model.dart';
part 'top_talents_state.dart';

class TopTalentsCubit extends Cubit<TopTalentsState> {
  TopTalentsCubit() : super(TopTalentsStateLoading());
  TopTalentsRepository? api = TopTalentsRepository(serviceLocator());
  TopTalentsModel? topTalents;
  bool isLoadingMore = false;

  topTalentsData({
    bool isGetMore = false,
    required String page,
    String? orderBy,
  }) async {
    if (isGetMore) {
      isLoadingMore = true;
      emit(TopTalentsStateLoadingMore());
    } else {
      emit(TopTalentsStateLoading());
    }
    try {
      final res = await api!.topTalentsData(page: page, orderBy: orderBy);

      res.fold((l) {
        emit(TopTalentsStateError(l.toString()));
      }, (r) {
        if (isGetMore) {
          topTalents = TopTalentsModel(
            links: r.links,
            status: r.status,
            msg: r.msg,
            data: [...topTalents!.data!, ...r.data!],
          );

          emit(TopTalentsStateLoaded(topTalents!));
        } else {
          topTalents = r;
          emit(TopTalentsStateLoaded(r));
        }
        emit(TopTalentsStateLoaded(r));
      });
    } catch (e) {
      emit(TopTalentsStateError(e.toString()));
    } finally {
      isLoadingMore = false;
    }
  }

  updateTopTalentCastingFollow(TopTalent? item) {
    if (topTalents != null) {
      for (int i = 0; i < (topTalents?.data?.length ?? 0); i++) {
        if (item?.id == topTalents?.data?[i].id) {
          if (item?.isIFollow == true) {
            topTalents?.data?[i].followersCount =
                (item?.followersCount ?? 0) + 1;
          } else {
            topTalents?.data?[i].followersCount =
                (item?.followersCount ?? 0) - 1;
          }
          topTalents?.data?[i].isIFollow = item?.isIFollow;
        }
      }
      emit(UpdateIsFollowState());
    }
  }

  followAndUnFollow(BuildContext context,
      {required String followedId, TopTalent? item}) async {
    emit(FollowAndUnFollowStateLoading());
    try {
      final res = await api!.followAndUnFollow(followedId: followedId);

      res.fold((l) {
        emit(FollowAndUnFollowStateError(l.toString()));
      }, (r) {
        item?.isIFollow = !(item?.isIFollow ?? false);
        successGetBar(r.msg ?? "");
        updateTopTalentCastingFollow(item);
        context.read<HomeCubit>().updateTopTalentHomeFollow(item);
        emit(FollowAndUnFollowStateLoaded());
      });
    } catch (e) {
      emit(FollowAndUnFollowStateError(e.toString()));
    }
  }

  Future<void> hideTopTalent(
      {required String unwantedUserId, required int index}) async {
    emit(HideTopTalentStateLoading());
    try {
      final res = await api!.hideTopTalents(unwantedUserId: unwantedUserId);

      res.fold((l) {
        emit(HideTopTalentStateError(l.toString()));
      }, (r) {
        topTalents?.data?.removeAt(index);
        successGetBar(r.msg ?? "");
        emit(HideTopTalentStateLoaded());
      });
    } catch (e) {
      emit(HideTopTalentStateError(e.toString()));
    }
  }
}
