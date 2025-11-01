import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'kanban_controller.dart';
import '../shared/shared.dart';

void showAddKanbanModal(
  BuildContext context,
  KanbanController controller,
  String defaultColumn,
) {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final dueController = TextEditingController();
  String selectedColumn = defaultColumn;

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
    ),
    builder: (context) {
      return DraggableScrollableSheet(
        expand: false,
        initialChildSize: 0.7,
        minChildSize: 0.45,
        maxChildSize: 0.95,
        builder: (context, scrollController) {
          return Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
            ),
            padding: EdgeInsets.only(
              left: 20,
              right: 20,
              top: 20,
              bottom: MediaQuery.of(context).viewInsets.bottom + 20,
            ),
            child: SingleChildScrollView(
              controller: scrollController,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: 60,
                      height: 5,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Center(
                    child: Text(
                      "Tambah Task Kanban",
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Status Field
                  const Text(
                    "Status",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 6),
                  DropdownButtonFormField<String>(
                    initialValue: selectedColumn,
                    dropdownColor: Colors.white,
                    decoration: _fieldDecoration(),
                    style: const TextStyle(color: Colors.black),
                    items: ["To Do", "In Progress", "Done"]
                        .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                        .toList(),
                    onChanged: (value) {
                      if (value != null) selectedColumn = value;
                    },
                  ),
                  const SizedBox(height: 15),

                  //  Judul / Bab
                  const Text(
                    "Judul / Bab",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 6),
                  _buildField(controller: titleController),
                  const SizedBox(height: 15),

                  // Keterangan
                  const Text(
                    "Keterangan",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 6),
                  _buildField(controller: descriptionController, maxLines: 2),
                  const SizedBox(height: 15),

                  //  Due Date
                  const Text(
                    "Due Date",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 6),
                  _buildField(
                    controller: dueController,
                    hintText: "contoh: 22 September 2025, 23:59",
                  ),
                  const SizedBox(height: 25),

                  // Tombol Tambah (full width seperti field)
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: dangerColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 3,
                      ),
                      onPressed: () {
                        if (titleController.text.isEmpty ||
                            dueController.text.isEmpty) {
                          Get.snackbar(
                            "Gagal",
                            "Judul dan tanggal harus diisi!",
                            backgroundColor: Colors.redAccent,
                            colorText: Colors.white,
                            snackPosition: SnackPosition.TOP,
                          );
                          return;
                        }

                        controller.addTaskWithDescription(
                          titleController.text,
                          dueController.text,
                          selectedColumn,
                          descriptionController.text,
                        );
                        Navigator.pop(context);
                      },
                      child: const Text(
                        "Tambah",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                          fontSize: 16,
                          letterSpacing: 0.8,
                        ),
                      ),
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

// Modal Edit Task Kanban
void showEditKanbanModal(
  BuildContext context,
  KanbanController controller,
  RxList<KanbanTask> tasks,
  int index,
  String column,
) {
  final task = tasks[index];
  final titleController = TextEditingController(text: task.title);
  final descriptionController = TextEditingController(text: task.description);
  final dueController = TextEditingController(text: task.dueDate);
  String selectedColumn = column;

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
    ),
    builder: (context) {
      return DraggableScrollableSheet(
        expand: false,
        initialChildSize: 0.7,
        minChildSize: 0.45,
        maxChildSize: 0.95,
        builder: (context, scrollController) {
          return Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
            ),
            padding: EdgeInsets.only(
              left: 20,
              right: 20,
              top: 20,
              bottom: MediaQuery.of(context).viewInsets.bottom + 20,
            ),
            child: SingleChildScrollView(
              controller: scrollController,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: 60,
                      height: 5,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Center(
                    child: Text(
                      "Edit Task Kanban",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  const Text("Status",
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
                  const SizedBox(height: 6),
                  DropdownButtonFormField<String>(
                    initialValue: selectedColumn,
                    dropdownColor: Colors.white,
                    decoration: _fieldDecoration(),
                    style: const TextStyle(color: Colors.black),
                    items: ["To Do", "In Progress", "Done"]
                        .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                        .toList(),
                    onChanged: (value) {
                      if (value != null) selectedColumn = value;
                    },
                  ),
                  const SizedBox(height: 15),

                  const Text("Judul / Bab",
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
                  const SizedBox(height: 6),
                  _buildField(controller: titleController),
                  const SizedBox(height: 15),

                  const Text("Keterangan",
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
                  const SizedBox(height: 6),
                  _buildField(controller: descriptionController, maxLines: 2),
                  const SizedBox(height: 15),

                  const Text("Due Date",
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
                  const SizedBox(height: 6),
                  _buildField(
                    controller: dueController,
                    hintText: "contoh: 22 September 2025, 23:59",
                  ),
                  const SizedBox(height: 25),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 140,
                        height: 45,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: dangerColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          onPressed: () {
                            controller.deleteTask(tasks, index);
                            Navigator.pop(context);
                          },
                          child: const Text(
                            "Hapus",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      SizedBox(
                        width: 140,
                        height: 45,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: primaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          onPressed: () {
                            if (titleController.text.isEmpty ||
                                dueController.text.isEmpty) {
                              Get.snackbar(
                                "Gagal",
                                "Judul dan tanggal harus diisi!",
                                backgroundColor: Colors.redAccent,
                                colorText: Colors.white,
                                snackPosition: SnackPosition.TOP,
                              );
                              return;
                            }

                            controller.updateTaskWithDescription(
                              tasks,
                              index,
                              titleController.text,
                              dueController.text,
                              descriptionController.text,
                            );
                            Navigator.pop(context);
                          },
                          child: const Text(
                            "Simpan",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
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

//  Reusable Field Decoration
InputDecoration _fieldDecoration() {
  return InputDecoration(
    filled: true,
    fillColor: primaryColor.withOpacity(0.2),
    contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 15),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(
        color: primaryColor.withOpacity(0.3),
        width: 1,
      ),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(
        color: primaryColor.withOpacity(0.3),
        width: 1,
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(
        color: primaryColor,
        width: 1.5,
      ),
    ),
  );
}

//  Field Builder
Widget _buildField({
  required TextEditingController controller,
  String? hintText,
  int maxLines = 1,
}) {
  return TextField(
    controller: controller,
    maxLines: maxLines,
    decoration: _fieldDecoration().copyWith(hintText: hintText),
  );
}
