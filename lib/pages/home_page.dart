import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../shared/shared.dart';
import '../routes/app_pages.dart';

// Gunakan alias supaya tidak konflik dengan MenuController Flutter
import '../controllers/menu_controller.dart' as myCtrl;

// =========================
// HomePage menggunakan GetView agar controller otomatis tersedia
// =========================
class HomePage extends GetView<myCtrl.MenuController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    const mainBlue = Color(0xFF88BDF2);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 6,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [primaryColor, dangerColor],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        title: const Text(
          'Beranda',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none, color: Colors.white),
            onPressed: () => Get.toNamed(Routes.NOTIFIKASI),
          ),
        ],
      ),

      // ================= BODY =================
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(defaultMargin),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Halo Balqis
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.45),
                      blurRadius: 12,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: const Text(
                  "Halo, Balqis! 👋",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(height: 25),

              // Progress TA
              const Text(
                "Progress TA",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Stack(
                alignment: Alignment.centerLeft,
                children: [
                  Container(
                    height: 10,
                    decoration: BoxDecoration(
                      color: dangerColor.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  LayoutBuilder(
                    builder: (context, constraints) {
                      double progressWidth = constraints.maxWidth * 0.6;
                      return Container(
                        width: progressWidth,
                        height: 10,
                        decoration: BoxDecoration(
                          color: dangerColor,
                          borderRadius: BorderRadius.circular(8),
                        ),
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(height: 8),
              const Text("60%", style: TextStyle(color: Colors.black)),

              const SizedBox(height: 25),

              // Pengumuman
              const Text(
                "Pengumuman",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 160,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    _InfoCard(title: "Template Laporan", mainBlue: mainBlue),
                    const SizedBox(width: 12),
                    _InfoCard(title: "Jadwal Sidang", mainBlue: mainBlue),
                    const SizedBox(width: 12),
                    _InfoCard(title: "Panduan Sidang", mainBlue: mainBlue),
                  ],
                ),
              ),
              const SizedBox(height: 25),

              // Upcoming
              const Text(
                "Upcoming",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Column(
                children: const [
                  _UpcomingCard(
                    title: "Bimbingan Revisi Bab 2",
                    date: "Selasa, 7 Oktober 2025",
                    time: "10:30",
                  ),
                  SizedBox(height: 12),
                  _UpcomingCard(
                    title: "Diskusi Desain UI",
                    date: "Rabu, 9 Oktober 2025",
                    time: "13:00",
                  ),
                  SizedBox(height: 12),
                  _UpcomingCard(
                    title: "Pengumpulan Proposal Final",
                    date: "Jumat, 11 Oktober 2025",
                    time: "09:00",
                  ),
                  SizedBox(height: 12),
                  _UpcomingCard(
                    title: "Sidang Akhir Tugas Akhir",
                    date: "Senin, 14 Oktober 2025",
                    time: "08:30",
                  ),
                ],
              ),
            ],
          ),
        ),
      ),

      // ================= Bottom Navigation =================
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
                    Get.toNamed(Routes.HOME);
                  },
                ),
                _BottomNavItem(
                  icon: Icons.calendar_month,
                  label: "Jadwal",
                  isActive: controller.currentPage.value == myCtrl.PageType.jadwal,
                  onTap: () {
                    controller.setPage(myCtrl.PageType.jadwal);
                    Get.toNamed(Routes.JADWAL);
                  },
                ),
                _BottomNavItem(
                  icon: Icons.bar_chart_outlined,
                  label: "Kanban",
                  isActive: controller.currentPage.value == myCtrl.PageType.kanban,
                  onTap: () {
                    controller.setPage(myCtrl.PageType.kanban);
                    Get.toNamed(Routes.KANBAN);
                  },
                ),
                _BottomNavItem(
                  icon: Icons.description_outlined,
                  label: "Dokumen",
                  isActive: controller.currentPage.value == myCtrl.PageType.dokumen,
                  onTap: () {
                    controller.setPage(myCtrl.PageType.dokumen);
                    Get.toNamed(Routes.DOKUMEN);
                  },
                ),
                _BottomNavItem(
                  icon: Icons.person_outline,
                  label: "Profil",
                  isActive: controller.currentPage.value == myCtrl.PageType.profile,
                  onTap: () {
                    controller.setPage(myCtrl.PageType.profile);
                    Get.toNamed(Routes.PROFILE);
                  },
                ),
              ],
            ),
          )),
    );
  }
}

// ================= InfoCard =================
class _InfoCard extends StatelessWidget {
  final String title;
  final Color mainBlue;

  const _InfoCard({required this.title, required this.mainBlue});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      margin: const EdgeInsets.only(right: 8),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.45),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: dangerColor,
              fontWeight: FontWeight.w700,
              fontSize: 15,
            ),
          ),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: mainBlue,
              minimumSize: const Size(100, 40),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              elevation: 3,
            ),
            child: const Text(
              "Lihat",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ================= UpcomingCard =================
class _UpcomingCard extends StatelessWidget {
  final String title;
  final String date;
  final String time;

  const _UpcomingCard({
    required this.title,
    required this.date,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.45),
            blurRadius: 12,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: dangerColor,
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              const Icon(Icons.calendar_today, color: Colors.black, size: 18),
              const SizedBox(width: 6),
              Text(
                date,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 14.5,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              const Icon(Icons.access_time, color: Colors.black, size: 18),
              const SizedBox(width: 6),
              Text(
                time,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 14.5,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ================= BottomNavItem =================
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
