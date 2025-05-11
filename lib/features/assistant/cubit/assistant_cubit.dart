import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:mawhebtak/core/exports.dart';
import 'package:mawhebtak/core/preferences/hive/hive.dart';
import 'package:mawhebtak/core/preferences/hive/models/work_model.dart';
import 'package:mawhebtak/core/widgets/media_picker.dart';
import 'package:mawhebtak/features/assistant/cubit/assistant_state.dart';
import 'package:mawhebtak/features/assistant/data/repos/assistant.repo.dart';

class AssistantCubit extends Cubit<AssistantState> {
  AssistantCubit(this.assistantRepository) : super(AssistantInitial());
  AssistantRepo assistantRepository;
  TextEditingController workNameController = TextEditingController();
  ScrollController scrollController = ScrollController();
  TextEditingController assistantTitleController = TextEditingController();
  TextEditingController assistantDescriptionController = TextEditingController();

  DateTime? selectedReminderDate;
  void updateSelectedDate(DateTime date) {
    selectedReminderDate = date;
    emit(UpdateSelectedDateState());
  }
  void clearSelectedDate() {
    selectedReminderDate = null;
    emit(UpdateSelectedDateState());
  }
  Future<void> refreshWorks() async {
    await getWorks();
  }
  List<WorkModel>? works;
  Future<void> deleteWork(BuildContext context, {required int workId}) async {
    await WorkHiveManager.removeWork(workId);
    refreshWorks();
    successGetBar("delete_work_successful");
    clearWorksInput();
    emit(DeleteNewWorkState());
  }

  Future<void> updateWork(BuildContext context,
      {required int workId, required String newTitle}) async {
    await WorkHiveManager.updateWork(workId: workId, newTitle: newTitle);

    successGetBar("update_work_successful");
    clearWorksInput();
    emit(DeleteNewWorkState());
  }

  Future<void> getWorks() async {
    works = WorkHiveManager.getWorks();
    final newList = works?.reversed.toList();
    works = newList;
    emit(GetAllWorksState());
  }

  Future<void> addWork(BuildContext context) async {
    await WorkHiveManager.addWork(workNameController.text);

    successGetBar("add_work_successful");
    clearWorksInput();

    if (scrollController.hasClients) {
      scrollController.animateTo(
        0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
    emit(AddNewWorkState());
  }

  List<Assistant>? assistants;
  Future<void> addAssistant(BuildContext context,
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
      remindedTime: selectedReminderDate,
      isActive: selectedReminderDate != null && selectedReminderDate!.isAfter(now),
      image: selectedImage?.path ?? "",
    );
    await WorkHiveManager.addAssistant(workId, newAssistant);
    clearAssistantInput();
    successGetBar("add_assistant_successful".tr());
    clearMedia();
    clearAssistantInput();
    Navigator.pop(context, true);
    await refreshWorks();
    await getAssistants(workId);
    emit(AddAssistantState());
  }

  Future<List<Assistant>?> getAssistants(int workId) async {
    assistants = await WorkHiveManager.getAssistants(workId);
    final newList = works?.reversed.toList();
    works = newList;
    emit(GetAllAssistantState());
  }

  Future<void> deleteAssistant(BuildContext context,
      {required int workId, required int assistantId}) async {
    await WorkHiveManager.removeAssistant(workId, assistantId);
    successGetBar("delete_assistant_successful".tr());
    await getAssistants(workId);
    refreshWorks();
    clearAssistantInput();
    emit(DeleteAssistantState());
  }

  Future<void> updateAssistant(
      BuildContext context, {
        required int workId,
        required Assistant oldAssistant,
      }) async {


    final now = DateTime.now();
    final updatedAssistant = Assistant(
      id: oldAssistant.id,
      title: assistantTitleController.text.trim(),
      description: assistantDescriptionController.text.trim(),
      date: now,
      remindedTime: selectedReminderDate,
      isActive: selectedReminderDate != null && selectedReminderDate!.isAfter(now),
      image: selectedImage?.path.isNotEmpty == true
          ? selectedImage!.path
          : oldAssistant.image,
    );
    await WorkHiveManager.updateAssistant(workId, updatedAssistant);
    successGetBar("update_assistant_successful".tr());
    await getAssistants(workId);
    await refreshWorks();
    clearAssistantInput();
    clearMedia();
    Navigator.pop(context);
    emit(UpdateAssistantState());
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
  void clearAssistantInput() {
    assistantTitleController.clear();
    assistantDescriptionController.clear();
  }
  void clearWorksInput() {
    workNameController.clear();
  }

  void clearMedia() {
    selectedImage = null;
    selectedVideo = null;
  }

}
