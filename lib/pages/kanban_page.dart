import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../shared/shared.dart';
import '../routes/app_pages.dart';

// Modular
import 'kanban_card.dart';
import 'kanban_controller.dart';
import 'kanban_modal.dart';

// Gunakan alias supaya tidak konflik dengan MenuController Flutter
import '../controllers/menu_controller.dart' as myCtrl;

class KanbanPage extends GetView<myCtrl.MenuController> {
  KanbanPage({super.key});

  // Controller lokal untuk Kanban
  final KanbanController kanbanController = Get.put(KanbanController());

  @override
  Widget build(BuildContext context) {
    // Set halaman aktif saat pertama kali dibuka
    controller.setPage(myCtrl.PageType.kanban);

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
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
      ),
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
                  _buildKanbanColumn(kanbanController.todoTasks, "To Do"),
                  _buildKanbanColumn(kanbanController.inProgressTasks, "In Progress"),
                  _buildKanbanColumn(kanbanController.doneTasks, "Done"),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: dangerColor,
        onPressed: () {
          showAddKanbanModal(context, kanbanController, "To Do");
        },
        child: const Icon(Icons.add, color: Colors.white),
      ),
      bottomNavigationBar: Obx(() => Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
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
                  isActive: controller.currentPage.value == myCtrl.PageType.home,
                  onTap: () {
                    controller.setPage(myCtrl.PageType.home);
                    Get.offAllNamed(Routes.HOME);
                  },
                ),
                _BottomNavItem(
                  icon: Icons.calendar_month,
                  label: "Jadwal",
                  isActive: controller.currentPage.value == myCtrl.PageType.jadwal,
                  onTap: () {
                    controller.setPage(myCtrl.PageType.jadwal);
                    Get.offAllNamed(Routes.JADWAL);
                  },
                ),
                _BottomNavItem(
                  icon: Icons.bar_chart_outlined,
                  label: "Kanban",
                  isActive: controller.currentPage.value == myCtrl.PageType.kanban,
                  onTap: () {
                    controller.setPage(myCtrl.PageType.kanban);
                    Get.offAllNamed(Routes.KANBAN);
                  },
                ),
                _BottomNavItem(
                  icon: Icons.description_outlined,
                  label: "Dokumen",
                  isActive: controller.currentPage.value == myCtrl.PageType.dokumen,
                  onTap: () {
                    controller.setPage(myCtrl.PageType.dokumen);
                    Get.offAllNamed(Routes.DOKUMEN);
                  },
                ),
                _BottomNavItem(
                  icon: Icons.person_outline,
                  label: "Profil",
                  isActive: controller.currentPage.value == myCtrl.PageType.profile,
                  onTap: () {
                    controller.setPage(myCtrl.PageType.profile);
                    Get.offAllNamed(Routes.PROFILE);
                  },
                ),
              ],
            ),
          )),
    );
  }

  Widget _buildKanbanColumn(RxList<KanbanTask> tasks, String column) {
    return Obx(
      () => ListView.builder(
        padding: const EdgeInsets.fromLTRB(defaultMargin, 6, defaultMargin, 16),
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          final task = tasks[index];
          return GestureDetector(
            onTap: () {
              showEditKanbanModal(context, kanbanController, tasks, index, column);
            },
            child: KanbanCard(task: task),
          );
        },
      ),
    );
  }
}

// --- Bottom Nav Item ---
class _BottomNavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool isActive;

  const _BottomNavItem({
    required this.icon,
    required this.label,
    required this.onTap,
    this.isActive = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: isActive ? Colors.yellow : Colors.white, size: 26),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: isActive ? Colors.yellow : Colors.white,
              fontSize: 12,
              fontWeight: isActive ? FontWeight.bold : FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
