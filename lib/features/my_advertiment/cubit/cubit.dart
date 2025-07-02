
import 'dart:io';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mawhebtak/core/models/default_model.dart';
import 'package:mawhebtak/core/utils/widget_from_application.dart';
import 'package:mawhebtak/features/my_advertiment/data/models/user_package_details_model.dart';
import 'package:mawhebtak/features/my_advertiment/data/models/user_package_model.dart';
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
  UserPackageDetailsModel? userPackageDetailsModel;

  void getUserPackageDetailsData({required String idFromPackage}) async {
    emit(LoadingPackageDetailsState());
    final res = await api.getUserPackageDetailsData(
      idFromPackage: idFromPackage,
    );
    res.fold((l) {
      emit(ErrorPackageDetailsState());
    }, (r) {
      userPackageDetailsModel = r;
      emit(SuccessPackageDetailsState());
    });
  }

  // // ✅ إضافة إعلان
  DefaultMainModel? defaultMainModel;

  void addAdds(BuildContext context, {required String id}) async {
    if (uploadedImage == null || !uploadedImage!.existsSync()) {
      Fluttertoast.showToast(msg: "please_select_image".tr());
      return;
    }

    AppWidgets.create2ProgressDialog(context);

    final res = await api.addAdds(
      id: id,
      fromDate: DateFormat('yyyy-MM-dd', 'en').format(fromData),
      toDate: DateFormat('yyyy-MM-dd', 'en').format(toDate),
      image: uploadedImage!,
    );

    res.fold((l) {
      errorGetBar(l.toString());
      emit(ErrorAddAdsState());
    }, (r) {
      if (r.status == 422) {
        errorGetBar(r.msg ?? '');
        Navigator.pop(context);
      } else {
        defaultMainModel = r;
        successGetBar(r.msg ?? '');
        getUserPackageData();
        uploadedImage = null;
        toDate == DateTime.now();
        fromData == DateTime.now();
        Navigator.pop(context);
      }
      emit(SuccessAddAdsState());
    });
  }

}
