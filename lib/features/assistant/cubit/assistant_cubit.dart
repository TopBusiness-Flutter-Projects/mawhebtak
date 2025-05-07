import 'package:easy_localization/easy_localization.dart';
import 'package:mawhebtak/core/exports.dart';
import 'package:mawhebtak/core/preferences/hive/hive.dart';
import 'package:mawhebtak/core/preferences/hive/models/work_model.dart';
import 'package:mawhebtak/features/assistant/cubit/assistant_state.dart';
import 'package:mawhebtak/features/assistant/data/repos/assistant.repo.dart';

class AssistantCubit extends Cubit<AssistantState> {
  AssistantCubit(this.exRepo) : super(AssistantInitial());
  AssistantRepo exRepo;
  TextEditingController workNameController = TextEditingController();
  ScrollController scrollController = ScrollController();
  TextEditingController assistantTitleController = TextEditingController();
  TextEditingController assistantDescriptionController = TextEditingController();

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
  Future<void> addAssistantFromWork(BuildContext context,{required int workId}) async {
    await WorkHiveManager.addAssistantToWork(workId,
        Assistant(
            title: assistantTitleController.text,
            description: assistantDescriptionController.text,
            date: DateTime.now(),
            remindedTime: selectedDate));
    WorkHiveManager.getAllWorks();
    successGetBar("add_assistant_successful".tr());
    assistantDescriptionController.clear();
    assistantTitleController.clear();
    getAllWorks();
    Navigator.pop(context);
    emit(AddAssistantState());
  }

  List<Work>? works;
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
  Future<void>  getAllAssistantFromWork(int workId) async {
    assistants = await WorkHiveManager.getAssistantsFromWork(workId) ;
    final newList = works?.reversed.toList();
    works = newList;
    emit(GetAllWorksState());
  }
}
