import 'package:mawhebtak/features/auth/new_account/data/model/user_types.dart';
import 'package:mawhebtak/features/calender/data/model/countries_model.dart';
import 'package:mawhebtak/features/home/cubits/home_cubit/home_cubit.dart';
import 'package:mawhebtak/features/home/data/models/followers_model.dart';
import 'package:mawhebtak/features/home/data/models/top_talents_model.dart';
import 'package:mawhebtak/features/home/data/repositories/top_talents_repository.dart';
import 'package:mawhebtak/features/profile/cubit/profile_cubit.dart';
import '../../../../core/exports.dart';
import '../../data/models/home_model.dart';
part 'top_talents_state.dart';

class TopTalentsCubit extends Cubit<TopTalentsState> {
  TopTalentsCubit() : super(TopTalentsStateLoading());
  TopTalentsRepository? api = TopTalentsRepository(serviceLocator());
  TopTalentsModel? topTalents;
  TopTalentsModel? topSubCategoryTalents;
  bool isLoadingMore = false;
  GetCountriesMainModelData? selectedUserType;
  GetCountriesMainModelData? selectedUserSubType;
  MainRegisterUserTypes? userTypeList;
  MainRegisterUserTypes? userSubTypeList;

  getDataUserType(BuildContext context,
      {GetCountriesMainModelData? userTypeModel, bool? isEditProfile}) async {
    emit(LoadingGetUserTypesState());
    var response = await api!.getDataUserType();
    response.fold((l) {
      emit(ErrorGetUserTypesState('error_msg'.tr()));
    }, (r) {
      userTypeList = r;
      selectedUserSubType = null;
      if (userTypeModel != null) {
        for (int i = 0; i < (userTypeList?.data?.length ?? 0); i++) {
          if (userTypeList?.data?[i].id?.toString() ==
              userTypeModel.id?.toString()) {
            selectedUserType = userTypeList?.data?[i];
          }
        }
      }

      if (isEditProfile == true) {
        getDataUserSubType(
            userTypeId: selectedUserType?.id?.toString() ?? '',
            currentSubCategory:
                context.read<ProfileCubit>().profileModel?.data?.userSubType);
      }
      emit(LoadedGetUserTypesState(r));
    });
  }

  getDataUserSubType({
    required String userTypeId,
    GetCountriesMainModelData? currentSubCategory,
  }) async {
    emit(LoadingGetUserSubTypesState());
    var response = await api!.getDataUserSubType(userTypeId: userTypeId);
    response.fold((l) {
      emit(ErrorGetUserSubTypesState('error_msg'.tr()));
    }, (r) {
      userSubTypeList = r;

      if (currentSubCategory != null) {
        for (int i = 0; i < (userSubTypeList?.data?.length ?? 0); i++) {
          if (userSubTypeList?.data?[i].id?.toString() ==
              currentSubCategory.id?.toString()) {
            selectedUserSubType = userSubTypeList?.data?[i];
          }
        }
      }
      emit(LoadedGetUserSubTypesState(r));
    });
  }

  topTalentsData({
    bool isGetMore = false,
    required String page,
    String? orderBy,
    String? userSubTypeId,
  }) async {
    if (isGetMore) {
      isLoadingMore = true;
      emit(TopTalentsStateLoadingMore());
    } else {
      emit(TopTalentsStateLoading());
    }
    try {
      final res = await api!.topTalentsData(
          page: page, orderBy: orderBy, userSubTypeId: userSubTypeId);

      res.fold((l) {
        emit(TopTalentsStateError(l.toString()));
      }, (r) {
        if (userSubTypeId == null) {
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
        } else {
          if (isGetMore) {
            topSubCategoryTalents = TopTalentsModel(
              links: r.links,
              status: r.status,
              msg: r.msg,
              data: [...topSubCategoryTalents!.data!, ...r.data!],
            );

            emit(TopTalentsStateLoaded(topSubCategoryTalents!));
          } else {
            topSubCategoryTalents = r;
            emit(TopTalentsStateLoaded(r));
          }
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
      {required String followedId, TopTalent? item, int? index}) async {
    emit(FollowAndUnFollowStateLoading());
    try {
      final res = await api!.followAndUnFollow(followedId: followedId);

      res.fold((l) {
        emit(FollowAndUnFollowStateError(l.toString()));
      }, (r) {
        item?.isIFollow = !(item.isIFollow ?? false);
        followerAndFollowingModel?.data?[index!].isIFollow = !(followerAndFollowingModel?.data?[index].isIFollow ?? false);
        successGetBar(r.msg ?? "");
        updateTopTalentCastingFollow(item);
        context.read<HomeCubit>().updateTopTalentHomeFollow(item);
        emit(FollowAndUnFollowStateLoaded());
      });
    } catch (e) {
      emit(FollowAndUnFollowStateError(e.toString()));
    }
  }

  FollowerAndFollowingModel? followerAndFollowingModel;
  getFollowersAndFollowingData({
    bool isGetMore = false,
    required String page,
    String? orderBy,
    String? followedId,
    required String pageName,
  }) async {
    if (isGetMore) {
      isLoadingMore = true;
      emit(GetFollowersStateLoadingMore());
    } else {
      emit(GetFollowersStateLoading());
    }
    try {
      final res = await api!.getFollowersData(
          pageName: pageName,
          page: page,
          orderBy: orderBy,
          followedId: followedId,
       );

      res.fold((l) {
        emit(GetFollowersStateError(l.toString()));
      }, (r) {
        if (isGetMore) {
          followerAndFollowingModel = FollowerAndFollowingModel(
            links: r.links,
            status: r.status,
            msg: r.msg,
            data: [...followerAndFollowingModel!.data!, ...r.data!],
          );

          emit(GetFollowersStateLoaded());
        } else {
          followerAndFollowingModel = r;
          emit(GetFollowersStateLoaded());
        }
      });
    } catch (e) {
      emit(GetFollowersStateError(e.toString()));
    } finally {
      isLoadingMore = false;
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
