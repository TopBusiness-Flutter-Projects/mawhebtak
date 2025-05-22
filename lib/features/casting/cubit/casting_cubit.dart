import 'package:mawhebtak/core/exports.dart';
import 'package:mawhebtak/core/preferences/preferences.dart';
import 'package:mawhebtak/features/auth/login/data/models/login_model.dart';
import 'package:mawhebtak/features/calender/cubit/calender_cubit.dart';

import '../../calender/data/model/countries_model.dart';
import '../data/repos/casting.repo.dart';
import 'casting_state.dart';

class CastingCubit extends Cubit<CastingState> {
  CastingCubit(this.castingRepo) : super(CastingInitial());
  CastingRepo castingRepo;
  TextEditingController gigTitleController = TextEditingController();
  TextEditingController priceRangeController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  GetCountriesMainModel? categoryModel;
  GetCountriesMainModelData? selectedCategory;
  int? subCategoryId;
  GetCountriesMainModelData? selectedSubCategory;
  getCategory() async {
    emit(CategoryStateLoading());
    try {
      final res = await castingRepo.getCategory();
      res.fold((l) {
        emit(CategoryStateError(l.toString()));
      }, (r) {
        categoryModel = r;
        emit(CategoryStateLoaded());
      });
    } catch (e) {
      emit(CategoryStateError(e.toString()));
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
        subCategoryModel = r;
        emit(SubCategoryStateLoaded());
      });
    } catch (e) {
      emit(SubCategoryStateError(e.toString()));
    }
  }

  addNewGig({required BuildContext context}) async {
    emit(AddNewGigStateLoading());
    try {
      final res = await castingRepo.addNewGig(
        title: gigTitleController.text,
        price: context.read<CalenderCubit>().ticketPriceController.text,
        description: descriptionController.text,
        lat: "31.14234242",
        long: "30.2424243",
        userId: user?.data?.id ?? 0,
        mediaFiles: [
          ...context.read<CalenderCubit>().myImagesF ?? [],
          ...context.read<CalenderCubit>().validVideos
        ],
        location: "عزبه كفر الحله",
        subCategoryId: subCategoryId.toString(),
      );
      res.fold((l) {
        emit(AddNewGigStateError(l.toString()));
      }, (r) {
        emit(AddNewGigStateLoaded());
        successGetBar(r.msg);
        Navigator.pop(context);
        context.read<CalenderCubit>().ticketPriceController.clear();
        gigTitleController.clear();
        descriptionController.clear();
        context.read<CalenderCubit>().myImagesF = [];
        context.read<CalenderCubit>().validVideos = [];
      });
    } catch (e) {
      emit(AddNewGigStateError(e.toString()));
    }
  }

  Future<LoginModel> getUserFromPreferences() async {
    final user = await Preferences.instance.getUserModel();
    return user;
  }

  LoginModel? user;
  Future<void> loadUserFromPreferences() async {
    user = await Preferences.instance.getUserModel();
  }
}
