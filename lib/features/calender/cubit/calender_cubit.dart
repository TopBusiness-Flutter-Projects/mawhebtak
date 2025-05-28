import 'dart:developer';
import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mawhebtak/core/exports.dart';
import 'package:mawhebtak/features/calender/cubit/calender_state.dart';
import 'package:mawhebtak/features/calender/data/repos/calender.repo.dart';
import 'package:path/path.dart' as path;

import 'package:video_compress/video_compress.dart';

import '../../../core/utils/widget_from_application.dart';
import '../../location/cubit/location_cubit.dart';
import '../data/model/countries_model.dart';
import '../data/model/selected_talends.dart';
import '../data/repos/model/calender_model.dart';
import '../data/repos/model/event_model.dart';
import '../screens/widgets/calender_widget.dart';

class CalenderCubit extends Cubit<CalenderState> {
  CalenderCubit(this.api) : super(CalenderInitial());
  CalenderRepo api;
  int currentStep = 0;

  // TextEditingController locationController = TextEditingController();
  TextEditingController eventDateController = TextEditingController();
  TextEditingController eventToDateController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController titleOfTheEventController = TextEditingController();
  TextEditingController ticketPriceController = TextEditingController();
  TextEditingController eventLimitController = TextEditingController();
  TextEditingController locationAddressController = TextEditingController();
  TextEditingController feesPriceController = TextEditingController();
  DateTime? selectedDate;
  List<MainCalendarEventData> events = [];
  List<File> validVideos = [];
  List<XFile>? myImages;
  List<File>? myImagesF;
  bool isFree = true;
  bool isPublic = true;

  List<SelectedTalends> selectedTalends = [];
  GetCountriesMainModelData? selectedCurrency;
  GetCountriesMainModelData? selectedCategoty;
  GetCountriesMainModelData? selectedSubCategoty;
  //!
  Future<void> selectDateTime(BuildContext context,
      {bool isFrom = false}) async {
    DateTime? initialDate;
    TimeOfDay initialTime = TimeOfDay.now();

    if (isFrom && eventDateController.text.isNotEmpty) {
      // End date: start from selected start date
      try {
        final startDate =
            DateFormat('yyyy-MM-dd HH:mm:ss').parse(eventDateController.text);
        initialDate = startDate;
        initialTime = TimeOfDay.fromDateTime(startDate);
      } catch (e) {
        initialDate = DateTime.now();
      }
    } else if (!isFrom && eventDateController.text.isNotEmpty) {
      // Start date: use stored value or today
      try {
        final startDate =
            DateFormat('yyyy-MM-dd HH:mm:ss').parse(eventDateController.text);
        initialDate = startDate;
        initialTime = TimeOfDay.fromDateTime(startDate);
      } catch (e) {
        initialDate = DateTime.now();
      }
    } else {
      initialDate = DateTime.now();
      initialTime = TimeOfDay.now();
    }

    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: isFrom && eventDateController.text.isNotEmpty
          ? DateFormat('yyyy-MM-dd HH:mm:ss').parse(eventDateController.text)
          : DateTime(2020),
      lastDate: DateTime(3100),
    );

    if (pickedDate != null) {
      TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: initialTime,
      );

      if (pickedTime != null) {
        DateTime finalDateTime = DateTime(
          pickedDate.year,
          pickedDate.month,
          pickedDate.day,
          pickedTime.hour,
          pickedTime.minute,
        );

        selectedDate = finalDateTime;

        String formattedDateTime =
            DateFormat('yyyy-MM-dd HH:mm:ss').format(finalDateTime);

        if (isFrom) {
          eventToDateController.text = formattedDateTime;
        } else {
          eventDateController.text = formattedDateTime;
        }

        emit(DateTimeSelected(formattedDateTime));
      }
    }
  }

  //! get countries

  GetCountriesMainModel? countriesMainModel;
  Future<void> getAllCountries() async {
    emit(GetGetCountriesLoadingState());
    final result = await api.mainGetData(queryParameters: {"model": "Country"});
    result.fold((l) {
      emit(GetGetCountriesErrorState());
    }, (r) {
      countriesMainModel = r;
      emit(GetGetCountriesSuccessState());
    });
  }

  //!
  GetCountriesMainModel? categoriesMainModel;
  Future<void> getAllCategories() async {
    emit(GetGetCategoriesLoadingState());
    final result = await api.mainGetData(
        queryParameters: {"model": "Category", "where[0]": "status,1"});
    result.fold((l) {
      emit(GetGetCategoriesErrorState());
    }, (r) {
      categoriesMainModel = r;
      subCategoriesMainModel = null;
      emit(GetGetCategoriesSuccessState());
    });
  }

  GetCountriesMainModel? subCategoriesMainModel;
  Future<void> getAllSubCategories(String categoryId) async {
    emit(GetGetCategoriesLoadingState());
    final result = await api.mainGetData(queryParameters: {
      "model": "SubCategory",
      "where[0]": "status,1",
      "where[1]": "category_id,$categoryId"
    });
    result.fold((l) {
      emit(GetGetCategoriesErrorState());
    }, (r) {
      subCategoriesMainModel = null;
      selectedSubCategoty = null;
      subCategoriesMainModel = r;
      emit(GetGetCategoriesSuccessState());
    });
  }

  Future pickMultiImage() async {
    List<XFile>? images;
    List<File> files = [];

    try {
      images = await ImagePicker().pickMultiImage();
      if (images == null || images.isEmpty) return;

      for (var xImage in images) {
        final file = File(xImage.path);

        // ✅ Check if the image already exists in myImages

        final imageBytes = await file.readAsBytes();

        if (imageBytes.length > 3 * 1024 * 1024) {
          final compressedImageBytes =
              await FlutterImageCompress.compressWithFile(
            file.path,
            quality: 75,
          );
          final compressedImage = File('${file.path}.compressed.jpg');
          await compressedImage.writeAsBytes(compressedImageBytes!);
          files.add(compressedImage);
        } else {
          files.add(file);
        }

        // ✅ Add XFile and File to lists
        myImages = [...?myImages, xImage];
      }

      myImagesF = [...?myImagesF, ...files];

      emit(SuccessSelectNewImageState());
    } on PlatformException catch (e) {
      debugPrint('Image picker error: $e');
    }
  }

  // delete from path not index
  void deleteImage(File image) {
    myImagesF!.removeWhere((element) => element.path == image.path);
    myImages!.removeWhere((element) => element.path == image.path);
    if (myImagesF!.isEmpty) {
      myImages = null;
      myImagesF = null;
    }
    emit(SuccessRemoveImageState());
  }

  void deleteVideo(File video) {
    validVideos.removeWhere((element) => element.path == video.path);

    if (validVideos.isEmpty) {
      validVideos = [];
    }
    emit(SuccessRemoveVideoState());
  }

  Future<List<File>?> pickMultipleVideos(BuildContext context) async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowMultiple: false,
        type: FileType.video,
      );
      if (result != null) {
        List<File> files = result.paths.map((path) => File(path!)).toList();
        //! clear List before select
        validVideos.clear();
        for (File file in files) {
          final fileBytes = await file.readAsBytes();
          if (fileBytes.length > 2 * 1024 * 1024) {
            AppWidgets.create2ProgressDialog(context);
            try {
              final compressedFile = await _compressVideo(File(file.path));
              // print('video Size After : ${await compressedFile.length()}');
              validVideos.add(compressedFile);
              log('video path $compressedFile');

              Navigator.pop(context);
            } catch (e) {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                      "Failed to compress video ${path.basename(file.path)}."),
                ),
              );
            }
          } else {
            AppWidgets.create2ProgressDialog(context);
            log('video path ${file.path}');
            validVideos.add(File(file.path));
            Navigator.pop(context);

            //////////////////////
            //!
          }
        }
      }
      emit(LoadedAddNewViedoState());
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Error picking videos."),
        ),
      );
      return null;
    }
    return null;
  }

//!
  Future<File> _compressVideo(File file) async {
    try {
      await VideoCompress.setLogLevel(0);
      MediaInfo videoDuration = await VideoCompress.getMediaInfo(file.path);

      final compressedVideo = await VideoCompress.compressVideo(
        file.path,
        quality: VideoQuality.MediumQuality,
        deleteOrigin: true,
        includeAudio: true,
        frameRate: 15,
        startTime: 0,
        duration: (videoDuration.duration! / 1000).round() > 30
            ? (videoDuration.duration! / 1000).floor() - 30
            : 0,
      );
      log('LLLLLLLLLL ${compressedVideo != null && compressedVideo.path != null}');
      log('LLLLLLLLLL ${compressedVideo?.path}');
      emit(CompressedVideoState());
      if (compressedVideo != null && compressedVideo.path != null) {
        return compressedVideo.path != null
            ? File(compressedVideo.path!)
            : file;
      } else {
        VideoCompress.cancelCompression();
        return file;
      }
    } catch (e) {
      VideoCompress.cancelCompression();
      return file;
    }
  }

  bool isImage = true;

  void showSelectionBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      showDragHandle: true,
      backgroundColor: Colors.white,
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: Text(
                'pick_image'.tr(),
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: MediaQuery.of(context).size.width / 20),
              ),
              onTap: () async {
                // Call your pickMultiImage method here
                await pickMultiImage();
                isImage = true;

                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.video_library),
              title: Text(
                'pick_video'.tr(),
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: MediaQuery.of(context).size.width / 20),
              ),
              onTap: () async {
                isImage = false;
                // Call your pickVideo method here
                final pickedVideo = await pickMultipleVideos(context);
                if (pickedVideo != null) {}

                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  //! add to talends
  //
  addNewTalends() {
    selectedTalends.add(SelectedTalends(
      selectedSubCategoty ?? GetCountriesMainModelData(),
      feesPriceController.text,
      selectedCurrency ?? GetCountriesMainModelData(),
    ));
    // selectedSubCategoty = null;
    // selectedCurrency = null;
    feesPriceController.clear();
    emit(AddNewTalendsToEventState(selectedTalends));
  }

  //! remove from talends
  removeFromTalends(int index) {
    selectedTalends.removeAt(index);
    emit(RemoveNewTalendsFromEventState());
  }

  Future eventStore(BuildContext context) async {
    AppWidgets.create2ProgressDialog(context);
    try {
      emit(GetAddNewEventState());
      final result = await api.storeEvent(
        categoryId: selectedCategoty?.id.toString() ?? '',
        selectedTalends: selectedTalends,
        files: [...(myImagesF ?? []), ...validVideos],
        description: descriptionController.text,
        title: titleOfTheEventController.text,
        from: eventDateController.text,
        to: eventToDateController.text,
        location: locationAddressController.text,
        lat: context
                .read<LocationCubit>()
                .selectedLocation
                ?.latitude
                .toString() ??
            '0',
        long: context
                .read<LocationCubit>()
                .selectedLocation
                ?.longitude
                .toString() ??
            '0',
        isPublic: isPublic == true ? '1' : '0',
        eventPrice: isFree ? '0' : ticketPriceController.text,
        eventLimit: eventLimitController.text,
      );
      result.fold((l) {
        errorGetBar(l.toString());

        emit(GetAddNewEventErrorState());
      }, (r) {
        if (r.status == 200) {
          successGetBar(r.msg ?? '');
          currentStep = 2;
          emit(GetAddNewEventSuccessState());
          clearData();
          getCalendarEvent();
        } else {
          errorGetBar(r.msg ?? 'Error occurred');
          emit(GetAddNewEventErrorState());
        }
      });
      Navigator.pop(context);
    } catch (e) {
      errorGetBar(e.toString());
      emit(GetAddNewEventErrorState());
    }
  }

  clearData() {
    eventLimitController.clear();
    ticketPriceController.clear();
    eventToDateController.clear();
    eventToDateController.clear();
    eventDateController.clear();
    locationAddressController.clear();
    titleOfTheEventController.clear();
    descriptionController.clear();
    selectedCategoty = null;
    selectedTalends = [];
    myImagesF = null;
    myImages = null;
    validVideos = [];
  }

  GetMainEventModel? myEventsModel;
  getMyEvents() async {
    try {
      emit(GetMyEventLoadingState());
      final result = await api.getmyEvents();
      result.fold((l) {
        errorGetBar(l.toString());
        emit(GetMyEventErrorState());
      }, (r) {
        if (r.status == 200) {
          myEventsModel = r;
          emit(GetMyEventSuccessState());
        } else {
          errorGetBar(r.msg ?? 'Error occurred');
          emit(GetMyEventErrorState());
        }
      });
    } catch (e) {
      errorGetBar(e.toString());
      emit(GetMyEventErrorState());
    }
  }

  MainCalendarEvent? mainCalendarEvent;
  getCalendarEvent() async {
    try {
      emit(GetMyCalenderEventLoadingState());
      final result = await api.eventCalendar();
      result.fold((l) {
        errorGetBar(l.toString());
        emit(GetMyCalenderEventErrorState());
      }, (r) {
        if (r.status == 200) {
          mainCalendarEvent = r;
          events = r.data ?? [];

          emit(GetMyCalenderEventLoadedState());
        } else {
          errorGetBar(r.msg ?? 'Error occurred');
          emit(GetMyCalenderEventErrorState());
        }
      });
    } catch (e) {
      errorGetBar(e.toString());
      emit(GetMyCalenderEventErrorState());
    }
  }
}
