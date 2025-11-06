import 'package:get/get.dart';

class KanbanTask {
  final String title;
  final String description;
  final String dueDate;

  KanbanTask(this.title, this.dueDate, {this.description = ""});
}

class KanbanController extends GetxController {
  var todoTasks = <KanbanTask>[].obs;
  var inProgressTasks = <KanbanTask>[].obs;
  var doneTasks = <KanbanTask>[].obs;

  @override
  void onInit() {
    super.onInit();
    todoTasks.addAll([
      KanbanTask("BAB IV: Implementasi dan Pembahasan", "29 Mei 2025, 23:59", description: "Kerjakan bab implementasi"),
      KanbanTask("BAB V: Kesimpulan dan Saran", "3 Juni 2025, 23:59"),
      KanbanTask("Presentasi Sidang", "21 Juni 2025, 23:59"),
    ]);
    inProgressTasks.add(KanbanTask("Revisi BAB III", "15 Mei 2025, 23:59"));
    doneTasks.add(KanbanTask("Pengajuan Judul TA", "15 April 2025, 23:59"));
  }

  void addTaskWithDescription(String title, String dueDate, String column, String description) {
    final newTask = KanbanTask(title, dueDate, description: description);
    if (column == "To Do") {
      todoTasks.add(newTask);
    } else if (column == "In Progress") {
      inProgressTasks.add(newTask);
    } else if (column == "Done") {
      doneTasks.add(newTask);
    }
  }

  void updateTaskWithDescription(RxList<KanbanTask> columnTasks, int index, String newTitle, String newDue, String newDescription) {
    columnTasks[index] = KanbanTask(newTitle, newDue, description: newDescription);
  }

  void deleteTask(RxList<KanbanTask> columnTasks, int index) {
    columnTasks.removeAt(index);
  }
}
