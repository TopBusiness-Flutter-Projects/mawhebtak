import 'dart:io';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mawhebtak/core/models/default_model.dart';
import 'package:mawhebtak/core/utils/widget_from_application.dart';
import 'package:mawhebtak/features/announcement/data/models/announcements_model.dart';
import 'package:mawhebtak/features/casting/data/model/request_gigs_model.dart';
import 'package:mawhebtak/features/home/data/models/top_events_model.dart';
import 'package:mawhebtak/features/my_advertiment/data/models/user_package_details_model.dart';
import 'package:mawhebtak/features/my_advertiment/data/models/user_package_model.dart';
import '../../../core/exports.dart';
import '../data/repos/my_advertisment_repo.dart';
import 'state.dart';
class DropdownModel {
  final String id;
  final String name;

  DropdownModel({required this.id, required this.name});
}
class MyAdvertismentCubit extends Cubit<MyAdvertismentState> {
  MyAdvertismentCubit(this.api) : super(SubscribtionStateInitial());

  MyAdvertismentRepo api;
  String formattedDate = DateFormat('yyyy-MM-dd', 'en').format(DateTime.now());

  DateTime selectedDate = DateTime.now();
  DateTime fromData = DateTime.now();
  DateTime toDate = DateTime.now();
  String? selectedModelType;
  String? selectedModelTypeId;
  Map<String, String> modelTypeMap =
    {
      "Event": "event".tr(),
      "Announcement": "announcement".tr(),
      "Gig": "gig".tr()

  };

  List<DropdownModel> get selectedList {
    switch (selectedModelType) {
      case "Event":
        return (eventsModel?.data ?? [])
            .map((e) => DropdownModel(id: e.id.toString(), name: e.title ?? ''))
            .toList();
      case "Gig":
        return (gigsModel?.data ?? [])
            .map((e) => DropdownModel(id: e.id.toString(), name: e.title ?? ''))
            .toList();
      case "Announcement":
        return (announcementsModel?.data ?? [])
            .map((e) => DropdownModel(id: e.id.toString(), name: e.title ?? ''))
            .toList();
      default:
        return [];
    }
  }
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
  // events
  TopEventsModel? eventsModel;
  void getEventsData() async {
    emit(LoadingEventsDataState());
    final res = await api.eventsData();
    res.fold((l) {
      emit(ErrorEventsDataState());
    }, (r) {
      eventsModel = r;
      emit(SuccessEventsDataState());
    });
  } // announcment
  AnnouncementsModel? announcementsModel;
  void getAnnouncementData() async {
    emit(LoadingAnnouncementDataState());
    final res = await api.announcmentData();
    res.fold((l) {
      emit(ErrorAnnouncementDataState());
    }, (r) {
      announcementsModel = r;
      emit(SuccessAnnouncementDataState());
    });
  }// Gig
  RequestGigsModel? gigsModel;
  void getGigsData() async {
    emit(LoadingGigsDataState());
    final res = await api.gigsData();
    res.fold((l) {
      emit(ErrorGigsDataState());
    }, (r) {
      gigsModel = r;
      emit(SuccessGigsDataState());
    });
  }


  // // ✅ تفاصيل الاشتراك
  UserPackageDetailsModel? userPackageDetailsModel;

  void getUserPackageDetailsData({required String idFromPackage}) async {
    emit(LoadingPackageDetailsState());
    final res =
        await api.getUserPackageDetailsData(idFromPackage: idFromPackage);
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
      modelId: selectedModelTypeId.toString(),
      modelType: selectedModelType ?? "",
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
        selectedModelType = null;
        selectedModelTypeId = null;
        Navigator.pop(context);
      }
      emit(SuccessAddAdsState());
    });
  }
}
