import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../shared/shared.dart';
import '../routes/app_pages.dart';

/// --- MODEL ---
class KanbanTask {
  final String title;
  final String dueDate;
  KanbanTask(this.title, this.dueDate);
}

/// --- CONTROLLER ---
class KanbanController extends GetxController {
  var todoTasks = <KanbanTask>[].obs;
  var inProgressTasks = <KanbanTask>[].obs;
  var doneTasks = <KanbanTask>[].obs;

  @override
  void onInit() {
    super.onInit();
    todoTasks.addAll([
      KanbanTask("BAB IV: Implementasi dan Pembahasan", "29 Mei 2025, 23:59"),
      KanbanTask("BAB V: Kesimpulan dan Saran", "3 Juni 2025, 23:59"),
      KanbanTask("Presentasi Sidang", "21 Juni 2025, 23:59"),
    ]);
    inProgressTasks.add(KanbanTask("Revisi BAB III", "15 Mei 2025, 23:59"));
    doneTasks.add(KanbanTask("Pengajuan Judul TA", "15 April 2025, 23:59"));
  }

  void addTask(String title, String dueDate, String column) {
    final newTask = KanbanTask(title, dueDate);
    if (column == "To Do") {
      todoTasks.add(newTask);
    } else if (column == "In Progress") {
      inProgressTasks.add(newTask);
    } else if (column == "Done") {
      doneTasks.add(newTask);
    }
  }
}

/// --- KARTU KANBAN ---
class KanbanCard extends StatelessWidget {
  final KanbanTask task;
  const KanbanCard({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(16),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Judul kartu
          Text(
            task.title,
            style: TextStyle(
              color: blackColor, // ✅ teks hitam
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 8),
          // Isi / due date kartu
          Text(
            "Due: ${task.dueDate}",
            style: TextStyle(
              color: blackColor, // ✅ teks hitam
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }
}

/// --- HALAMAN KANBAN ---
class KanbanPage extends StatelessWidget {
  KanbanPage({super.key});
  final KanbanController controller = Get.put(KanbanController());

  PreferredSizeWidget _buildCustomAppBar() {
    return AppBar(
      backgroundColor: primaryColor,
      centerTitle: true,
      elevation: 0,
      automaticallyImplyLeading: false,
      title: const Text(
        "Papan Kanban",
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
    );
  }

  Widget _buildKanbanColumn(RxList<KanbanTask> tasks) {
    return Obx(
      () => ListView.builder(
        padding: const EdgeInsets.fromLTRB(defaultMargin, 30, defaultMargin, 80),
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          return KanbanCard(task: tasks[index]);
        },
      ),
    );
  }

  void _showAddTaskDialog(BuildContext context, String column) {
    final titleController = TextEditingController();
    final dueController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Tambah Task - $column", style: TextStyle(color: blackColor)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(labelText: "Judul Task"),
              ),
              TextField(
                controller: dueController,
                decoration: const InputDecoration(labelText: "Due Date"),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Batal", style: TextStyle(color: blackColor)),
            ),
            ElevatedButton(
              onPressed: () {
                if (titleController.text.isNotEmpty && dueController.text.isNotEmpty) {
                  controller.addTask(titleController.text, dueController.text, column);
                  Navigator.pop(context);
                }
              },
              child: const Text("Tambah"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: _buildCustomAppBar(),
      body: DefaultTabController(
        length: 3,
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: defaultMargin, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 6,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: TabBar(
                indicatorSize: TabBarIndicatorSize.tab,
                indicator: BoxDecoration(
                  color: primaryColor,
                  borderRadius: const BorderRadius.all(Radius.circular(15)),
                ),
                labelColor: Colors.white,
                unselectedLabelColor: blackColor, // ✅ unselected tab teks hitam
                labelStyle: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  letterSpacing: 0.5,
                ),
                unselectedLabelStyle: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  color: blackColor,
                ),
                tabs: const [
                  Tab(text: "To Do"),
                  Tab(text: "In Progress"),
                  Tab(text: "Done"),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  _buildKanbanColumn(controller.todoTasks),
                  _buildKanbanColumn(controller.inProgressTasks),
                  _buildKanbanColumn(controller.doneTasks),
                ],
              ),
            ),
          ],
        ),
      ),

      // Tombol FloatingActionButton tambah task
      floatingActionButton: FloatingActionButton(
        backgroundColor: primaryColor,
        onPressed: () => _showAddTaskDialog(context, "To Do"),
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),

      // Bottom navigation sama HomePage
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        decoration: BoxDecoration(
          color: primaryColor,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _BottomNavItem(
              icon: Icons.home,
              label: "Beranda",
              onTap: () => Get.offAllNamed(Routes.HOME),
            ),
            _BottomNavItem(
              icon: Icons.calendar_month,
              label: "Jadwal",
              onTap: () => Get.offAllNamed(Routes.JADWAL),
            ),
            _BottomNavItem(
              icon: Icons.bar_chart_outlined,
              label: "Kanban",
              onTap: () {},
            ),
            _BottomNavItem(
              icon: Icons.description_outlined,
              label: "Dokumen",
              onTap: () => Get.offAllNamed(Routes.DOKUMEN),
            ),
            _BottomNavItem(
              icon: Icons.person_outline,
              label: "Profile",
              onTap: () => Get.offAllNamed(Routes.PROFILE),
            ),
          ],
        ),
      ),
    );
  }
}

/// --- Bottom Navigation Item ---
class _BottomNavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _BottomNavItem({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: Colors.white, size: 26),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
