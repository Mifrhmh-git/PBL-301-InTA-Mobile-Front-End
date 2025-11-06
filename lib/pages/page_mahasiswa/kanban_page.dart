import 'package:flutter/material.dart';
import 'package:get/get.dart';

// Shared & routes (global)
import 'package:inta301/shared/shared.dart';
import 'package:inta301/routes/app_pages.dart';

// Modular (file di folder yang sama)
import 'package:inta301/pages/page_mahasiswa/kanban_card.dart';
import 'package:inta301/pages/page_mahasiswa/kanban_controller.dart';
import 'package:inta301/pages/page_mahasiswa/kanban_modal.dart';

// Gunakan alias supaya tidak konflik dengan MenuController Flutter
import 'package:inta301/controllers/menu_controller.dart' as myCtrl;

class KanbanPage extends GetView<myCtrl.MenuController> {
  final bool hasDosen;

  KanbanPage({super.key, required this.hasDosen});

  // Controller lokal untuk Kanban
  final KanbanController kanbanController = Get.put(KanbanController());

  @override
  Widget build(BuildContext context) {
    // Set halaman aktif saat pertama kali dibuka
    controller.setPage(myCtrl.PageType.kanban);

    // ✅ Jika belum memiliki dosen pembimbing
    if (!hasDosen) {
      return Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text(
            "Papan Kanban",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 20,
              fontFamily: 'Poppins',
            ),
          ),
          centerTitle: true,
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [primaryColor, dangerColor],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
        ),
        body: const Padding(
          padding: EdgeInsets.only(top: 100),
          child: Center(
            child: Text(
              "Belum memiliki dosen pembimbing.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                 color: Color(0xFF616161),
                fontFamily: 'Poppins',
              ),
            ),
          ),
        ),
        bottomNavigationBar: Obx(
          () => _BottomNavBar(currentPage: controller.currentPage.value),
        ),
      );
    }

    // ✅ Jika sudah punya dosen, tampilkan papan Kanban
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
          decoration: const BoxDecoration(
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
              margin: const EdgeInsets.symmetric(
                  horizontal: defaultMargin, vertical: 12),
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
                  _buildKanbanColumn(
                      kanbanController.inProgressTasks, "In Progress"),
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
      bottomNavigationBar:
          Obx(() => _BottomNavBar(currentPage: controller.currentPage.value)),
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
              showEditKanbanModal(
                  context, kanbanController, tasks, index, column);
            },
            child: KanbanCard(task: task),
          );
        },
      ),
    );
  }
}

// --- Bottom Nav Wrapper ---
class _BottomNavBar extends StatelessWidget {
  final myCtrl.PageType currentPage;

  const _BottomNavBar({required this.currentPage});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<myCtrl.MenuController>();
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [primaryColor, dangerColor],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.only(
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
            isActive: currentPage == myCtrl.PageType.home,
            onTap: () {
              controller.setPage(myCtrl.PageType.home);
              Get.offAllNamed(Routes.HOME);
            },
          ),
          _BottomNavItem(
            icon: Icons.calendar_month,
            label: "Jadwal",
            isActive: currentPage == myCtrl.PageType.jadwal,
            onTap: () {
              controller.setPage(myCtrl.PageType.jadwal);
              Get.offAllNamed(Routes.JADWAL);
            },
          ),
          _BottomNavItem(
            icon: Icons.bar_chart_outlined,
            label: "Kanban",
            isActive: currentPage == myCtrl.PageType.kanban,
            onTap: () {
              controller.setPage(myCtrl.PageType.kanban);
              Get.offAllNamed(Routes.KANBAN);
            },
          ),
          _BottomNavItem(
            icon: Icons.description_outlined,
            label: "Dokumen",
            isActive: currentPage == myCtrl.PageType.dokumen,
            onTap: () {
              controller.setPage(myCtrl.PageType.dokumen);
              Get.offAllNamed(Routes.DOKUMEN);
            },
          ),
          _BottomNavItem(
            icon: Icons.person_outline,
            label: "Profil",
            isActive: currentPage == myCtrl.PageType.profile,
            onTap: () {
              controller.setPage(myCtrl.PageType.profile);
              Get.offAllNamed(Routes.PROFILE);
            },
          ),
        ],
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
              fontFamily: 'Poppins',
            ),
          ),
        ],
      ),
    );
  }
}
