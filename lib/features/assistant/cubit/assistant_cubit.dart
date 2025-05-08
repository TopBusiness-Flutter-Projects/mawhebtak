import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:mawhebtak/core/exports.dart';
import 'package:mawhebtak/core/preferences/hive/hive.dart';
import 'package:mawhebtak/core/preferences/hive/models/work_model.dart';
import 'package:mawhebtak/core/widgets/media_picker.dart';
import 'package:mawhebtak/features/assistant/cubit/assistant_state.dart';
import 'package:mawhebtak/features/assistant/data/repos/assistant.repo.dart';

class AssistantCubit extends Cubit<AssistantState> {
  AssistantCubit(this.exRepo) : super(AssistantInitial());
  AssistantRepo exRepo;
  TextEditingController workNameController = TextEditingController();
  ScrollController scrollController = ScrollController();
  TextEditingController assistantTitleController = TextEditingController();
  TextEditingController assistantDescriptionController =
      TextEditingController();

  DateTime? selectedDate;
  void updateSelectedDate(DateTime date) {
    selectedDate = date;
    emit(UpdateSelectedDateState());
  }

  Future<void> addNewWork(BuildContext context) async {
    await WorkHiveManager.addWork(workNameController.text);
    WorkHiveManager.getAllWorks();
    successGetBar("add_work_successful");
    workNameController.clear();
    getAllWorks();
    if (scrollController.hasClients) {
      scrollController.animateTo(
        0,
        duration: const Duration(milliseconds: 300), // مدة الرسوم المتحركة
        curve: Curves.easeInOut,
      );
    }
    emit(AddNewWorkState());
  }

  File? selectedImage;
  File? selectedVideo;

  Future<void> pickMedia(BuildContext context) async {
    MediaPickerHelper.pickMedia(
      context: context,
      onImagePicked: (image) {
        selectedImage = image;
        selectedVideo = null;
        emit(ImagePickedState());
      },
      onVideoPicked: (video) {
        selectedVideo = video;
        selectedImage = null;
        emit(VideoPickedState());
      },
    );
  }

  Future<void> addAssistantFromWork(BuildContext context,
      {required int workId}) async {
    if (assistantTitleController.text.trim().isEmpty) {
      errorGetBar("assistant_title_required".tr());
      return;
    }

    final now = DateTime.now();

    final newAssistant = Assistant(
      id: DateTime.now().millisecondsSinceEpoch,
      title: assistantTitleController.text.trim(),
      description: assistantDescriptionController.text.trim(),
      date: now,
      remindedTime: selectedDate,
      isActive: selectedDate != null && selectedDate!.isBefore(now),
      images: selectedImage != null ? [selectedImage!.path] : [],
    );

    await WorkHiveManager.addAssistantToWork(workId, newAssistant);

    successGetBar("add_assistant_successful".tr());
    assistantTitleController.clear();
    assistantDescriptionController.clear();
    selectedImage = null;
    selectedVideo = null;

    await getAllWorks();
    await getAllAssistantFromWork(workId);
    emit(AddAssistantState());

    if (context.mounted) Navigator.pop(context);
  }

  List<WorkModel>? works;
  List<Assistant>? assistants;

  Future<void> deleteWork(BuildContext context, {required int workId}) async {
    await WorkHiveManager.removeWork(workId);
    WorkHiveManager.getAllWorks();
    successGetBar("delete_work_successful");
    getAllWorks();
    workNameController.clear();
    emit(DeleteNewWorkState());
  }

  Future<void> updateWork(BuildContext context,
      {required int workId, required String newTitle}) async {
    await WorkHiveManager.updateWork(workId: workId, newTitle: newTitle);
    WorkHiveManager.getAllWorks();
    successGetBar("update_work_successful");
    getAllWorks();
    workNameController.clear();
    emit(DeleteNewWorkState());
  }

  Future<void> getAllWorks() async {
    works = WorkHiveManager.getAllWorks();
    final newList = works?.reversed.toList();
    works = newList;
    emit(GetAllWorksState());
  }

  Future<List<Assistant>?> getAllAssistantFromWork(int workId) async {
    assistants = await WorkHiveManager.getAssistantsFromWork(workId);
    final newList = works?.reversed.toList();
    works = newList;
    emit(GetAllAssistantState());
  }
}
