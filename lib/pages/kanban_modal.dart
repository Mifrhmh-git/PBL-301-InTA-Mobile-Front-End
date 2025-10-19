import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'kanban_controller.dart';
import '../shared/shared.dart';

void showAddKanbanModal(BuildContext context, KanbanController controller, String defaultColumn) {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final dueController = TextEditingController();
  String selectedColumn = defaultColumn;

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(25))),
    builder: (context) {
      return DraggableScrollableSheet(
        expand: false,
        initialChildSize: 0.6,
        minChildSize: 0.4,
        maxChildSize: 0.95,
        builder: (context, scrollController) {
          return Container(
            decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.vertical(top: Radius.circular(25))),
            padding: EdgeInsets.only(left: 20, right: 20, top: 20, bottom: MediaQuery.of(context).viewInsets.bottom + 20),
            child: SingleChildScrollView(
              controller: scrollController,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(width: 60, height: 5, decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(10))),
                  ),
                  const SizedBox(height: 16),
                  const Text("Tambah Task Kanban", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                  const SizedBox(height: 20),
                  // Dropdown Status
                  DropdownButtonFormField<String>(
                    value: selectedColumn,
                    dropdownColor: Colors.white, // menu dropdown putih
                    decoration: const InputDecoration(
                      labelText: "Status",
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(),
                    ),
                    style: const TextStyle(color: Colors.black), // teks dropdown hitam
                    items: ["To Do", "In Progress", "Done"]
                        .map((e) => DropdownMenuItem(value: e, child: Text(e, style: const TextStyle(color: Colors.black))))
                        .toList(),
                    onChanged: (value) { if (value != null) selectedColumn = value; },
                  ),
                  const SizedBox(height: 15),
                  // Judul / Bab
                  TextField(controller: titleController, decoration: const InputDecoration(labelText: "Judul / Bab", border: OutlineInputBorder())),
                  const SizedBox(height: 15),
                  // Keterangan
                  TextField(controller: descriptionController, decoration: const InputDecoration(labelText: "Keterangan", border: OutlineInputBorder())),
                  const SizedBox(height: 15),
                  // Due Date
                  TextField(controller: dueController, decoration: const InputDecoration(labelText: "Due Date", border: OutlineInputBorder())),
                  const SizedBox(height: 25),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      onPressed: () {
                        if (titleController.text.isNotEmpty && dueController.text.isNotEmpty) {
                          controller.addTaskWithDescription(
                            titleController.text,
                            dueController.text,
                            selectedColumn,
                            descriptionController.text,
                          );
                          Navigator.pop(context);
                        }
                      },
                      child: const Text("Tambah", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)), // tombol putih
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    },
  );
}

void showEditKanbanModal(BuildContext context, KanbanController controller, RxList<KanbanTask> tasks, int index, String column) {
  final task = tasks[index];
  final titleController = TextEditingController(text: task.title);
  final descriptionController = TextEditingController(text: task.description);
  final dueController = TextEditingController(text: task.dueDate);
  String selectedColumn = column;

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(25))),
    builder: (context) {
      return DraggableScrollableSheet(
        expand: false,
        initialChildSize: 0.6,
        minChildSize: 0.4,
        maxChildSize: 0.95,
        builder: (context, scrollController) {
          return Container(
            decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.vertical(top: Radius.circular(25))),
            padding: EdgeInsets.only(left: 20, right: 20, top: 20, bottom: MediaQuery.of(context).viewInsets.bottom + 20),
            child: SingleChildScrollView(
              controller: scrollController,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(width: 60, height: 5, decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(10))),
                  ),
                  const SizedBox(height: 16),
                  const Text("Edit Task Kanban", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                  const SizedBox(height: 20),
                  // Dropdown Status
                  DropdownButtonFormField<String>(
                    value: selectedColumn,
                    dropdownColor: Colors.white,
                    decoration: const InputDecoration(
                      labelText: "Status",
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(),
                    ),
                    style: const TextStyle(color: Colors.black),
                    items: ["To Do", "In Progress", "Done"]
                        .map((e) => DropdownMenuItem(value: e, child: Text(e, style: const TextStyle(color: Colors.black))))
                        .toList(),
                    onChanged: (value) { if (value != null) selectedColumn = value; },
                  ),
                  const SizedBox(height: 15),
                  // Judul / Bab
                  TextField(controller: titleController, decoration: const InputDecoration(labelText: "Judul / Bab", border: OutlineInputBorder())),
                  const SizedBox(height: 15),
                  // Keterangan
                  TextField(controller: descriptionController, decoration: const InputDecoration(labelText: "Keterangan", border: OutlineInputBorder())),
                  const SizedBox(height: 15),
                  // Due Date
                  TextField(controller: dueController, decoration: const InputDecoration(labelText: "Due Date", border: OutlineInputBorder())),
                  const SizedBox(height: 25),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(backgroundColor: Colors.red, padding: const EdgeInsets.symmetric(vertical: 16), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                          onPressed: () {
                            controller.deleteTask(tasks, index);
                            Navigator.pop(context);
                          },
                          child: const Text("Hapus", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(backgroundColor: primaryColor, padding: const EdgeInsets.symmetric(vertical: 16), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                          onPressed: () {
                            if (titleController.text.isNotEmpty && dueController.text.isNotEmpty) {
                              controller.updateTaskWithDescription(
                                tasks,
                                index,
                                titleController.text,
                                dueController.text,
                                descriptionController.text,
                              );
                              Navigator.pop(context);
                            }
                          },
                          child: const Text("Simpan", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      );
    },
  );
}
