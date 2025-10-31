import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../shared/shared.dart';
import '../routes/app_pages.dart';

// Modular
import 'kanban_card.dart';
import 'kanban_controller.dart';
import 'kanban_modal.dart';

class KanbanPage extends StatelessWidget {
  KanbanPage({super.key});
  final KanbanController controller = Get.put(KanbanController());

  // --- Custom AppBar ---
  PreferredSizeWidget _buildCustomAppBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
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
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [primaryColor, dangerColor],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
      ),
    );
  }

  // --- Build Kanban Column ---
  Widget _buildKanbanColumn(RxList<KanbanTask> tasks, String column) {
    return Obx(
      () => ListView.builder(
        padding: const EdgeInsets.fromLTRB(defaultMargin, 6, defaultMargin, 16), // ✅ jarak rapat
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          final task = tasks[index];
          return GestureDetector(
            onTap: () {
              showEditKanbanModal(context, controller, tasks, index, column);
            },
            child: KanbanCard(task: task),
          );
        },
      ),
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
            // --- TabBar ---
            Container(
              margin: const EdgeInsets.symmetric(
                horizontal: defaultMargin,
                vertical: 12,
              ),
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
                // ✅ Ubah warna aktif (indikator) jadi dangerColor
                indicator: BoxDecoration(
                  color: dangerColor,
                  borderRadius: const BorderRadius.all(Radius.circular(15)),
                ),
                labelColor: Colors.white,
                unselectedLabelColor: blackColor,
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
                  _buildKanbanColumn(controller.todoTasks, "To Do"),
                  _buildKanbanColumn(controller.inProgressTasks, "In Progress"),
                  _buildKanbanColumn(controller.doneTasks, "Done"),
                ],
              ),
            ),
          ],
        ),
      ),
      // --- FAB Tambah Task ---
      floatingActionButton: FloatingActionButton(
        // ✅ ganti ke primaryColor
        backgroundColor: primaryColor,
        onPressed: () {
          showAddKanbanModal(context, controller, "To Do");
        },
        child: const Icon(Icons.add, color: Colors.white),
      ),
      // --- Bottom Navigation ---
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [primaryColor, dangerColor],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
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

// --- Bottom Nav Item ---
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
