import 'package:mawhebtak/core/exports.dart';
import 'package:mawhebtak/core/utils/widget_from_application.dart';
import 'package:mawhebtak/features/calender/cubit/calender_cubit.dart';
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
    AppWidgets.create2ProgressDialog(context);
    emit(AddNewGigStateLoading());

    try {
      final res = await castingRepo.addNewGig(
        title: gigTitleController.text,
        price: context.read<CalenderCubit>().ticketPriceController.text,
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
        context.read<CalenderCubit>().ticketPriceController.clear();
        gigTitleController.clear();
        descriptionController.clear();
        context.read<CalenderCubit>().myImagesF = [];
        context.read<CalenderCubit>().validVideos = [];
        locationAddressController.clear();
        selectedCategory = null;
        selectedSubCategory = null;
        emit(AddNewGigStateLoaded());
      });
    } catch (e) {
      successGetBar(e.toString());

      emit(AddNewGigStateError(e.toString()));
    }
    Navigator.pop(context);
  }
}
