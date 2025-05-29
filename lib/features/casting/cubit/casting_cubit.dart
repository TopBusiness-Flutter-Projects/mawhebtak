import 'package:mawhebtak/config/routes/app_routes.dart';
import 'package:mawhebtak/core/exports.dart';
import 'package:mawhebtak/core/models/default_model.dart';
import 'package:mawhebtak/core/utils/widget_from_application.dart';
import 'package:mawhebtak/features/calender/cubit/calender_cubit.dart';
import 'package:mawhebtak/features/casting/data/model/get_datails_gigs_model.dart';
import 'package:mawhebtak/features/casting/data/model/get_gigs_from_sub_category_model.dart';
import 'package:mawhebtak/features/location/cubit/location_cubit.dart';
import '../../calender/data/model/countries_model.dart';
import '../data/repos/casting.repo.dart';
import 'casting_state.dart';

class CastingCubit extends Cubit<CastingState> {
  CastingCubit(this.castingRepo) : super(CastingInitial());
  CastingRepo castingRepo;
  TextEditingController gigTitleController = TextEditingController();
  TextEditingController priceRangeController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController locationAddressController = TextEditingController();
  GetCountriesMainModel? categoryModel;
  GetCountriesMainModelData? selectedCategory;
  int? subCategoryId;
  GetCountriesMainModelData? selectedSubCategory;

  getCategoryFromGigs() async {
    emit(CategoryFromGigsStateLoading());
    try {
      final res = await castingRepo.getCategoryFromGigs();
      res.fold((l) {
        emit(CategoryFromGigsStateError(l.toString()));
      }, (r) {
        categoryModel = r;
        emit(CategoryFromGigsStateLoaded(r));
      });
    } catch (e) {
      emit(CategoryFromGigsStateError(e.toString()));
    }
  }

  GetGigsFromSubCategoryModel? getGigsFromSubCategoryModel;
  getGigsFromSubCategory({required String id}) async {
    emit(GigsFromCategoryStateLoading());
    try {
      final res = await castingRepo.getGigsFromSubCategory(id: id);
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

  GetCountriesMainModel? subCategoryModel;
  getSubCategory({required String categoryId}) async {
    emit(SubCategoryStateLoading());
    try {
      final res = await castingRepo.subCetCategory(categoryId: categoryId);
      res.fold((l) {
        emit(SubCategoryStateError(l.toString()));
      }, (r) {
        getGigsFromSubCategoryModel = null;
        subCategoryModel = r;
        emit(SubCategoryStateLoaded(r));
      });
    } catch (e) {
      emit(SubCategoryStateError(e.toString()));
    }
  }

  DefaultMainModel? defaultMainModel;

  actionGig({required String status,
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

  requestGigs({required String gigId, required BuildContext context,required String type}) async {
    AppWidgets.create2ProgressDialog(context);
    emit(RequestGigStateLoading());
    try {
      final res = await castingRepo.requestGig(
        gigId: gigId,
      );
      res.fold((l) {
        errorGetBar(l.toString());
        emit(RequestGigStateError(l.toString()));
      }, (r) {
        if (r.status == 200) {
          Navigator.pop(context);

            Navigator.pushNamed(context, Routes.chatRoute);
            successGetBar(r.msg);
            getDetailsGigs(id: gigId);

          emit(RequestGigStateLoaded());
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
        subCategoryId: subCategoryId.toString(),
      );
      res.fold((l) {
        errorGetBar(l.toString());
        emit(AddNewGigStateError(l.toString()));
      }, (r) {
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
        Navigator.pop(context);
        emit(AddNewGigStateLoaded());
      });
    } catch (e) {
      successGetBar(e.toString());

      emit(AddNewGigStateError(e.toString()));
    }
    Navigator.pop(context);
  }
}
