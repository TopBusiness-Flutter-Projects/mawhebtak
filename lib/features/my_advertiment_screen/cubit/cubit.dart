
import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mawhebtak/features/my_advertiment_screen/data/models/user_package_model.dart';
import '../../../core/exports.dart';
import '../data/repos/my_advertisment_repo.dart';
import 'state.dart';

class MyAdvertismentCubit extends Cubit<MyAdvertismentState> {
  MyAdvertismentCubit(this.api) : super(SubscribtionStateInitial());

  MyAdvertismentRepo api;
  String formattedDate = DateFormat('yyyy-MM-dd', 'en').format(DateTime.now());

  DateTime selectedDate = DateTime.now();
  DateTime fromData = DateTime.now();
  DateTime toDate = DateTime.now();

  Future<void> onSelectedDate(BuildContext context,
      {required bool isFromDate}) async {
    emit(LoadingMyAdvanceDateSelectedState());

    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: isFromDate ? fromData : toDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(9999),
    );

    if (picked != null) {
      if (isFromDate) {
        fromData = picked;
      } else {
        toDate = picked;
      }

      emit(AdvanceDateSelectedState());
    }
  }

  void updateFormattedDate() {
    formattedDate = DateFormat('yyyy-MM-dd', 'en').format(selectedDate);
  }

  File? uploadedImage;
  Future<void> pickImage(BuildContext context, bool isGallery) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(
      source: isGallery ? ImageSource.gallery : ImageSource.camera,
    );

    if (pickedFile == null || pickedFile.path.isEmpty) {
      errorGetBar("❌ لم يتم تحديد صورة صالحة! حاول مرة أخرى.");
      emit(FileNotPicked());
      return;
    }

    uploadedImage = File(pickedFile.path);
    debugPrint("✅ Image selected: ${uploadedImage?.path}");
    emit(FilePickedSuccessfully());
  }

  void clearImage() {
    uploadedImage = null;
    emit(FileRemovedSuccessfully());
  }

  // // ✅ إدارة الاشتراكات
  UserPackageModel? userPackageModel;
  void getUserPackageData() async {
    emit(LoadingUserPackageState());
    final res = await api.getUserPackageData();
    res.fold((l) {
      emit(ErrorUserPackageState());
    }, (r) {
      userPackageModel = r;
      emit(SuccessUserPackageState());
    });
  }

  // // ✅ تفاصيل الاشتراك
  // GetLawyerPackageAdsModel? getLawyerPackageAdsModelDetails;
  //
  // void getLawyerAdPackagesDetails({required String idFromPackage}) async {
  //   emit(LoadingLawyerPackageAdsState());
  //   final res = await api.getLawyerPackageAdsDetails(
  //     idFromPackage: idFromPackage,
  //   );
  //   res.fold((l) {
  //     emit(ErrorLawyerPackageAdsState());
  //   }, (r) {
  //     getLawyerPackageAdsModelDetails = r;
  //     emit(SuccessLawyerPackageAdsState());
  //   });
  // }
  //
  // // ✅ إضافة إعلان
  // DefaultMainModel? defaultMainModel;
  //
  // void addAdsToLawyerPackage(BuildContext context, {required String id}) async {
  //   emit(LoadingAddAdsToLawyerPackageState());
  //   final res = await api.addAdsToLawyerPackage(
  //       id: id,
  //       fromDate: DateFormat('yyyy-MM-dd', 'en').format(fromData),
  //       toDate: DateFormat('yyyy-MM-dd', 'en').format(toDate),
  //       image: uploadedImage ?? File(''));
  //
  //   res.fold((l) {
  //     errorGetBar(l.toString());
  //     emit(ErrorAddAdsToLawyerPackageState());
  //   }, (r) {
  //     if (r.status == 422) {
  //       errorGetBar(r.msg ?? '');
  //     } else {
  //       defaultMainModel = r;
  //       successGetBar(r.msg ?? '');
  //       getLawyerAdPackages();
  //       Navigator.pop(context);
  //     }
  //     emit(SuccessAddAdsToLawyerPackageState());
  //   });
  // }
}
