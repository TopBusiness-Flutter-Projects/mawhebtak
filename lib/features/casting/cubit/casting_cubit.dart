import 'dart:developer';
import 'package:mawhebtak/config/routes/app_routes.dart';
import 'package:mawhebtak/core/exports.dart';
import 'package:mawhebtak/core/models/default_model.dart';
import 'package:mawhebtak/core/preferences/preferences.dart';
import 'package:mawhebtak/core/utils/widget_from_application.dart';
import 'package:mawhebtak/features/auth/login/data/models/login_model.dart';
import 'package:mawhebtak/features/calender/cubit/calender_cubit.dart';
import 'package:mawhebtak/features/casting/data/model/get_datails_gigs_model.dart';
import 'package:mawhebtak/features/casting/data/model/get_gigs_from_sub_category_model.dart';
import 'package:mawhebtak/features/casting/data/model/request_gigs_model.dart';
import 'package:mawhebtak/features/location/cubit/location_cubit.dart';
import 'package:mawhebtak/features/profile/cubit/profile_cubit.dart';
import '../../calender/data/model/countries_model.dart';
import '../../chat/screens/message_screen.dart';
import '../data/repos/casting.repo.dart';
import 'casting_state.dart';

class CastingCubit extends Cubit<CastingState> {
  CastingCubit(this.castingRepo) : super(CastingInitial());
  CastingRepo castingRepo;
  TextEditingController gigTitleController = TextEditingController();
  TextEditingController priceRangeController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController locationAddressController = TextEditingController();
  GetCountriesMainModelData? selectedCategory;
  int? subCategoryId;
  GetCountriesMainModelData? selectedSubCategory;
  bool isLoadingMore = false;

  //category الاساسية
  GetCountriesMainModel? categoryModel;
  getCategoryFromGigs({
    bool isGetMore = false,
    bool paginate = true,
    String? page,
    String? orderBy,
  }) async {
    if (isGetMore) {
      isLoadingMore = true;
      emit(CategoryFromGigsStateLoadingMore());
    } else {
      emit(CategoryFromGigsStateLoading());
    }
    try {
      final res = await castingRepo.getCategoryFromGigs(
          paginate: paginate, page: page, orderBy: orderBy);
      res.fold((l) {
        emit(CategoryFromGigsStateError(l.toString()));
      }, (r) {
        if (isGetMore) {
          categoryModel = GetCountriesMainModel(
            links: r.links,
            status: r.status,
            msg: r.msg,
            data: [...categoryModel!.data!, ...r.data!],
          );
          emit(CategoryFromGigsStateLoaded(r));
        } else {
          categoryModel = r;
          emit(CategoryFromGigsStateLoaded(r));
        }
      });
    } catch (e) {
      emit(CategoryFromGigsStateError(e.toString()));
    }
  }

  // gigs from sub
  GetGigsFromSubCategoryModel? getGigsFromSubCategoryModel;
  getGigsFromSubCategory({required String? id}) async {
    emit(GigsFromCategoryStateLoading());
    try {
      final res = await castingRepo.getGigsFromSubCategory(
        subCategoryId: id ?? '',
      );
      res.fold((l) {
        emit(GigsFromCategoryStateError(l.toString()));
      }, (r) {
        getGigsFromSubCategoryModel = r;
        emit(GigsFromCategoryStateLoaded(r));
      });
    } catch (e) {
      emit(CategoryFromGigsStateError(e.toString()));
    }
  }

  // sub from category
  GetCountriesMainModel? subCategoryFromCategoryGigsModel;
  subCategoryFromCategoryGigs({required String categoryId}) async {
    emit(SubCategoryStateLoading());
    try {
      final res =
          await castingRepo.subCategoryFromCategoryGigs(categoryId: categoryId);
      res.fold((l) {
        emit(SubCategoryStateError(l.toString()));
      }, (r) {
        getGigsFromSubCategoryModel = null;
        subCategoryFromCategoryGigsModel = r;
        emit(SubCategoryStateLoaded(r));
      });
    } catch (e) {
      emit(SubCategoryStateError(e.toString()));
    }
  }

  RequestGigsModel? allGigsModel;
  allGigsData({
    bool isGetMore = false,
    required String page,
    String? orderBy,
  }) async {
    if (isGetMore) {
      isLoadingMore = true;
      emit(RequestGigsStateLoadingMore());
    } else {
      emit(RequestGigsStateLoading());
    }
    try {
      final res =
          await castingRepo.requestGigsData(page: page, orderBy: orderBy);

      res.fold((l) {
        emit(RequestGigsStateError(l.toString()));
      }, (r) {
        if (isGetMore) {
          allGigsModel = RequestGigsModel(
            links: r.links,
            status: r.status,
            msg: r.msg,
            data: [...allGigsModel!.data!, ...r.data!],
          );
          emit(RequestGigsStateLoaded(allGigsModel!));
        } else {
          allGigsModel = r;
          emit(RequestGigsStateLoaded(allGigsModel!));
        }
        emit(RequestGigsStateLoaded(r));
      });
    } catch (e) {
      emit(RequestGigsStateError(e.toString()));
    } finally {
      isLoadingMore = false;
    }
  }

  GetDetailsGigsModel? getDetailsGigsModel;
  getDetailsGigs({required String id}) async {
    emit(DetailsGigsStateLoading());
    try {
      final res = await castingRepo.getDetailsGigs(id: id);
      res.fold((l) {
        emit(DetailsGigsStateError(l.toString()));
      }, (r) {
        getDetailsGigsModel = r;

        emit(DetailsGigsStateLoaded(r));
      });
    } catch (e) {
      emit(CategoryFromGigsStateError(e.toString()));
    }
  }

  DefaultMainModel? defaultMainModel;
  actionGig({
    required String status,
    required String gigId,
    required String requestId,
  }) async {
    emit(ActionGigStateLoading());
    try {
      final res = await castingRepo.actionGig(
        status: status,
        gigId: requestId,
      );
      res.fold((l) {
        errorGetBar(l.toString());
        emit(ActionGigStateError(l.toString()));
      }, (r) {
        successGetBar(r.msg);
        getDetailsGigs(id: gigId);
        emit(ActionGigStateLoaded());
      });
    } catch (e) {
      emit(ActionGigStateError(e.toString()));
    }
  }

  requestGigs(
      {required BuildContext context,
      required String type,
      required String chatName,
      required EventAndGigsModel eventAndGigsModel}) async {
    AppWidgets.create2ProgressDialog(context);
    emit(RequestGigStateLoading());
    try {
      final res =
          await castingRepo.requestGig(gigId: eventAndGigsModel.id.toString());
      res.fold((l) {
        errorGetBar(l.toString());
        emit(RequestGigStateError(l.toString()));
      }, (r) {
        if (r.status == 200) {
          Navigator.pop(context);
          successGetBar(r.msg);
          if (eventAndGigsModel.isRequested.toString() == "pending") {
            eventAndGigsModel.isRequested = "null";
            emit(RequestGigStateLoaded());
          } else if (eventAndGigsModel.isRequested.toString() == "null" ||
              eventAndGigsModel.isRequested.toString() == "rejected") {
            eventAndGigsModel.isRequested = "pending";
            Navigator.pushNamed(context, Routes.messageRoute,
                arguments: MainUserAndRoomChatModel(
                    receiverId: eventAndGigsModel.user?.id.toString(),
                    chatName: chatName
                    //!
                    ));
            emit(RequestGigStateLoaded());
          }
        } else {
          errorGetBar(r.msg.toString());
          emit(RequestGigStateError(r.msg.toString()));
          Navigator.pop(context);
        }
      });
    } catch (e) {
      errorGetBar(e.toString());
      emit(RequestGigStateError(e.toString()));
    }
  }

  addNewGig({required BuildContext context}) async {
    AppWidgets.create2ProgressDialog(context);
    emit(AddNewGigStateLoading());

    try {
      final res = await castingRepo.addNewGig(
        currencyId:
            context.read<CalenderCubit>().selectedCurrency?.id.toString() ?? '',
        categoryId: selectedCategory?.id.toString() ?? "",
        title: gigTitleController.text,
        price: priceRangeController.text,
        description: descriptionController.text,
        lat: context
                .read<LocationCubit>()
                .selectedLocation
                ?.latitude
                .toString() ??
            "0.0",
        long: context
                .read<LocationCubit>()
                .selectedLocation
                ?.longitude
                .toString() ??
            "0.0",
        mediaFiles: [
          ...context.read<CalenderCubit>().myImagesF ?? [],
          ...context.read<CalenderCubit>().validVideos
        ],
        location: locationAddressController.text,
        subCategoryId: selectedSubCategory?.id.toString() ?? "",
      );
      res.fold((l) {
        errorGetBar(l.toString());
        emit(AddNewGigStateError(l.toString()));
      }, (r) {
        if (r.status == 200) {
          successGetBar(r.msg.toString());
          priceRangeController.clear();
          gigTitleController.clear();
          descriptionController.clear();
          context.read<CalenderCubit>().myImagesF = [];
          context.read<CalenderCubit>().myImages = [];
          context.read<CalenderCubit>().validVideos = [];
          locationAddressController.clear();
          selectedCategory = null;
          selectedSubCategory = null;
          allGigsData(page: '1');
          context.read<ProfileCubit>().getProfileData(
              context: context,
              id: context
                      .read<ProfileCubit>()
                      .profileModel
                      ?.data
                      ?.id
                      .toString() ??
                  "");
          Navigator.pop(context);
          emit(AddNewGigStateLoaded());
        } else {
          errorGetBar(r.msg.toString());
          emit(AddNewGigStateError(r.msg.toString()));
        }
      });
    } catch (e) {
      successGetBar(e.toString());

      emit(AddNewGigStateError(e.toString()));
    }
    Navigator.pop(context);
  }

  LoginModel? user;
  Future<void> loadUserFromPreferences() async {
    user = await Preferences.instance.getUserModel();
  }

  deleteGigs(
      {required String gigId,
      required BuildContext context,
      bool? isDetails = false,
      int? index}) async {
    emit(DeleteGigsStateLoading());
    try {
      final res = await castingRepo.deleteGigs(gigId);
      res.fold((l) {
        Navigator.pop(context);

        errorGetBar(l.toString());
        emit(DeleteGigsStateError());
      }, (r) {
        if (r.status == 200) {
          successGetBar(r.msg.toString());
          allGigsModel?.data?.removeAt(index!);
          context
              .read<ProfileCubit>()
              .profileModel
              ?.data
              ?.myGigs
              ?.removeAt(index!);
          if (isDetails == true) {
            Navigator.pop(context);
          }

          emit(DeleteGigsStateLoaded());
        } else {
          errorGetBar(r.msg.toString());
          emit(DeleteGigsStateError());
        }
      });
    } catch (e) {
      errorGetBar(e.toString());
      emit(DeleteGigsStateError());
    }
  }
}
