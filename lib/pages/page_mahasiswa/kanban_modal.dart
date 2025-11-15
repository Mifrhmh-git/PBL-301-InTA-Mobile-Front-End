import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inta301/pages/page_mahasiswa/kanban_controller.dart';
import 'package:inta301/shared/shared.dart';
import 'package:dropdown_button2/dropdown_button2.dart';


// Modal Task Kanban

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
                  /// --- Drag Indicator ---
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

                  /// --- Judul Modal ---
                  const Center(
                    child: Text(
                      "Tambah Task Kanban",
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 17,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                   // status

                  const Text(
                    "Status",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                  ),
                  const SizedBox(height: 6),

 StatefulBuilder(
  builder: (context, localSetState) {
    return DropdownButtonFormField2<String>(
      value: selectedColumn, // <<< WAJIB, INI YANG BIKIN ERROR KAMU HILANG

      decoration: _fieldDecoration().copyWith(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 14,
        ),
      ),

      isExpanded: true,

      buttonStyleData: const ButtonStyleData(
        padding: EdgeInsets.symmetric(horizontal: 8),
      ),

      menuItemStyleData: const MenuItemStyleData(
        padding: EdgeInsets.symmetric(horizontal: 8),
      ),

      dropdownStyleData: DropdownStyleData(
        maxHeight: 200,
        decoration: BoxDecoration(
          color: Color(0xFFDDEEFF),
          borderRadius: BorderRadius.circular(16),
        ),
      ),

      items: ["To Do", "In Progress", "Done"]
          .map((item) => DropdownMenuItem(
                value: item,
                child: Text(item),
              ))
          .toList(),

      onChanged: (value) {
        localSetState(() {
          selectedColumn = value!;
        });
      },
    );
  },
),

const SizedBox(height: 15),




                 // Judul / Bab
                  const Text(
                    "Judul / Bab",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                  ),
                  const SizedBox(height: 6),

                  _buildField(controller: titleController),
                  const SizedBox(height: 15),

                 // Keterangan
                  const Text(
                    "Keterangan",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                  ),
                  const SizedBox(height: 6),

                  _buildField(controller: descriptionController, maxLines: 2),
                  const SizedBox(height: 15),

                  // Due Date
                  const Text(
                    "Due Date",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                  ),
                  const SizedBox(height: 6),

                  _buildField(
                    controller: dueController,
                    hintText: "contoh: 22 September 2025, 23:59",
                  ),
                  const SizedBox(height: 25),

                  // Tombol Tambah
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: dangerColor,
                        elevation: 3,
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
                  /// --- Drag Indicator ---
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

                  /// --- Judul Modal ---
                  const Center(
                    child: Text(
                      "Edit Task Kanban",
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 17,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // status
                  const Text(
                    "Status",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                  ),
                  const SizedBox(height: 6),

        StatefulBuilder(
  builder: (context, localSetState) {
    return DropdownButtonFormField2<String>(
      decoration: _fieldDecoration().copyWith(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 14,
        ),
      ),

      isExpanded: true,

      buttonStyleData: const ButtonStyleData(
        padding: EdgeInsets.zero,
      ),

      dropdownStyleData: DropdownStyleData(
        maxHeight: 200,
        decoration: BoxDecoration(
          color: Color(0xFFDDEEFF),
          borderRadius: BorderRadius.circular(12),
        ),
      ),

      value: selectedColumn,
      items: ["To Do", "In Progress", "Done"]
          .map((item) => DropdownMenuItem(
                value: item,
                child: Text(item),
              ))
          .toList(),

      onChanged: (value) {
        localSetState(() {
          selectedColumn = value!;
        });
      },
    );
  },
),
                  const SizedBox(height: 15),

                  // Judul / Bab  
                  const Text(
                    "Judul / Bab",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                  ),
                  const SizedBox(height: 6),

                  _buildField(controller: titleController),
                  const SizedBox(height: 15),


                  const Text(
                    "Keterangan",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                  ),
                  const SizedBox(height: 6),

                  _buildField(controller: descriptionController, maxLines: 2),
                  const SizedBox(height: 15),

                  // Due Date
                  const Text(
                    "Due Date",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                  ),
                  const SizedBox(height: 6),

                  _buildField(
                    controller: dueController,
                    hintText: "contoh: 22 September 2025, 23:59",
                  ),
                  const SizedBox(height: 25),

                    
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      /// Hapus
                      Expanded(
                        child: SizedBox(
                          height: 50,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: dangerColor,
                              elevation: 3,
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
                                fontWeight: FontWeight.w800,
                                fontSize: 16,
                                letterSpacing: 0.8,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),

                      /// Simpan
                      Expanded(
                        child: SizedBox(
                          height: 50,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: primaryColor,
                              elevation: 3,
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
                                fontWeight: FontWeight.w800,
                                fontSize: 16,
                                letterSpacing: 0.8,
                              ),
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

// FIELD DECORATION
InputDecoration _fieldDecoration() {
  return InputDecoration(
    filled: true,
    fillColor: primaryColor.withOpacity(0.2),
    contentPadding:
        const EdgeInsets.symmetric(vertical: 12, horizontal: 15),
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

// FIELD INPUT
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
