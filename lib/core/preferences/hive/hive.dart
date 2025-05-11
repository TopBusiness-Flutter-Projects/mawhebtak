import 'package:hive_flutter/hive_flutter.dart';
import 'package:mawhebtak/core/preferences/hive/models/work_model.dart';

class WorkHiveManager {
  static const String workBoxName = 'workBox';



  static Future<void> saveWork(WorkModel work) async {
    final box = Hive.box(workBoxName);
    List<WorkModel> works =
        box.get('works', defaultValue: []).cast<WorkModel>();
    works.add(work);
    await box.put('works', works);
  }

  static List<WorkModel> getWorks() {
    final box = Hive.box(workBoxName);
    return box.get('works', defaultValue: []).cast<WorkModel>();
  }

  static Future<void> removeWork(int workId) async {
    final box = Hive.box(workBoxName);
    List<WorkModel> works =
        box.get('works', defaultValue: []).cast<WorkModel>();
    works.removeWhere((work) => work.id == workId);
    await box.put('works', works);
  }

  static Future<void> addWork(String workName) async {
    final box = Hive.box(workBoxName);
    List<WorkModel> works =
        box.get('works', defaultValue: []).cast<WorkModel>();

    final newWork = WorkModel(
      id: DateTime.now().millisecondsSinceEpoch,
      title: workName,
      assistants: [],
    );

    works.add(newWork);

    await box.put('works', works);
  }

  static Future<void> updateWork({
    required int workId,
    required String newTitle,
  }) async {
    final box = Hive.box(workBoxName);
    List<WorkModel> works =
        box.get('works', defaultValue: []).cast<WorkModel>();

    final index = works.indexWhere((work) => work.id == workId);
    if (index != -1) {
      works[index] = WorkModel(
        id: works[index].id,
        title: newTitle,
        assistants: works[index].assistants,
      );

      await box.put('works', works);
    }
  }

  static Future<void> clearWorks() async {
    final box = Hive.box(workBoxName);
    await box.delete('works');
  }

  //! Assistant methods

  static Future<void> addAssistant(int workId, Assistant assistant) async {
    final box = Hive.box(workBoxName);
    List<WorkModel> works =
        box.get('works', defaultValue: []).cast<WorkModel>();
    int index = works.indexWhere((work) => work.id == workId);
    if (index != -1) {
      works[index].assistants ??= [];
      works[index].assistants!.add(assistant);
      await box.put('works', works);
    }
  }

  static Future<void> removeAssistant(
      int workId, int assistantId) async {
    final box = Hive.box(workBoxName);
    List<WorkModel> works =
        box.get('works', defaultValue: []).cast<WorkModel>();
    int index = works.indexWhere((work) => work.id == workId);
    if (index != -1) {
      works[index]
          .assistants
          ?.removeWhere((assistant) => assistant.id == assistantId);
      await box.put('works', works);
    }
  }

  static Future<void> updateAssistant(int workId, Assistant assistant) async {
    final box = Hive.box(workBoxName);
    List<WorkModel> works =
    box.get('works', defaultValue: []).cast<WorkModel>();

    int workIndex = works.indexWhere((work) => work.id == workId);
    if (workIndex != -1) {
      List<Assistant>? assistants = works[workIndex].assistants;

      if (assistants != null) {
        int assistantIndex = assistants.indexWhere((a) => a.id == assistant.id);
        if (assistantIndex != -1) {
          assistants[assistantIndex] = assistant; // ✅ استبدال القديم بالجديد
          works[workIndex] = WorkModel(
            id: works[workIndex].id,
            title: works[workIndex].title,
            assistants: assistants,
          );
          await box.put('works', works); // ✅ حفظ التحديث
        }
      }
    }
  }


  static Future<List<Assistant>?> getAssistants(int workId) async {
    final box = Hive.box(workBoxName);
    List<WorkModel> works =
        box.get('works', defaultValue: []).cast<WorkModel>();
    int index = works.indexWhere((work) => work.id == workId);

    if (index != -1) {
      return works[index].assistants;
    } else {
      return null;
    }
  }
}
