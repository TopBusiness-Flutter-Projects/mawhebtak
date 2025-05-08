import 'package:hive_flutter/hive_flutter.dart';
import 'package:mawhebtak/core/preferences/hive/models/work_model.dart';

class WorkHiveManager {
  static const String workBoxName = 'workBox';

  static Future<void> initialize() async {
    await Hive.initFlutter();
    Hive.registerAdapter(WorkAdapter());
    Hive.registerAdapter(AssistantAdapter());

    await Hive.openBox(workBoxName);
  }

  //! Work methods

  static Future<void> saveWork(Work work) async {
    final box = Hive.box(workBoxName);
    List<Work> works = box.get('works', defaultValue: []).cast<Work>();
    works.add(work);
    await box.put('works', works);
  }

  static List<Work> getAllWorks() {
    final box = Hive.box(workBoxName);
    return box.get('works', defaultValue: []).cast<Work>();
  }

  static Future<void> removeWork(int workId) async {
    final box = Hive.box(workBoxName);
    List<Work> works = box.get('works', defaultValue: []).cast<Work>();
    works.removeWhere((work) => work.id == workId);
    await box.put('works', works);
  }

  static Future<void> addWork(String workName) async {
    final box = Hive.box(workBoxName);
    List<Work> works = box.get('works', defaultValue: []).cast<Work>();

    final newWork = Work(
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
    List<Work> works = box.get('works', defaultValue: []).cast<Work>();

    final index = works.indexWhere((work) => work.id == workId);
    if (index != -1) {
      works[index] = Work(
        id: works[index].id, // احتفظ بنفس الـ id
        title: newTitle,
        assistants: works[index].assistants,
      );

      await box.put('works', works);
    }
  }

  static Future<void> clearAllWorks() async {
    final box = Hive.box(workBoxName);
    await box.delete('works');
  }

  //! Assistant methods

  static Future<void> addAssistantToWork(
      int workId, Assistant assistant) async {
    final box = Hive.box(workBoxName);
    List<Work> works = box.get('works', defaultValue: []).cast<Work>();
    int index = works.indexWhere((work) => work.id == workId);
    if (index != -1) {
      works[index].assistants ??= [];
      works[index].assistants!.add(assistant);
      await box.put('works', works);
    }
  }

  static Future<void> removeAssistantFromWork(
      int workId, int assistantId) async {
    final box = Hive.box(workBoxName);
    List<Work> works = box.get('works', defaultValue: []).cast<Work>();
    int index = works.indexWhere((work) => work.id == workId);
    if (index != -1) {
      works[index]
          .assistants
          ?.removeWhere((assistant) => assistant.id == assistantId);
      await box.put('works', works);
    }
  }

  static Future<void> updateAssistantsInWork(
      int workId, Assistant assistant) async {
    final box = Hive.box(workBoxName);
    List<Work> works = box.get('works', defaultValue: []).cast<Work>();
    int index = works.indexWhere((work) => work.id == workId);
    if (index != -1) {
      works[index].assistants ??= [];
      if (!works[index].assistants!.any((a) => a.id == assistant.id)) {
        works[index].assistants!.add(assistant);
        await box.put('works', works);
      }
    }
  }

  static Future<List<Assistant>?> getAssistantsFromWork(int workId) async {
    final box = Hive.box(workBoxName);
    List<Work> works = box.get('works', defaultValue: []).cast<Work>();
    int index = works.indexWhere((work) => work.id == workId);

    if (index != -1) {
      return works[index].assistants;
    } else {
      return null; // لا يوجد مساعدين للعمل المعين
    }
  }
}
