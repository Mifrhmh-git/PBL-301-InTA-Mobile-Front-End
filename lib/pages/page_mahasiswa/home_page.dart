import 'package:flutter/material.dart';
import 'package:get/get.dart';

// Import global
import 'package:inta301/shared/shared.dart';
import 'package:inta301/routes/app_pages.dart';

// Import controller global 
import 'package:inta301/controllers/menu_controller.dart' as myCtrl;

// =========================
// HomePage menggunakan GetView agar controller otomatis tersedia
// =========================
class HomePage extends StatefulWidget {
  final bool hasDosen; // parameter untuk cek status dosen

  const HomePage({super.key, required this.hasDosen});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final controller = Get.find<myCtrl.MenuController>();

  // Status mahasiswa: 'belum', 'menunggu', atau 'sudah'
  String status = 'sudah';

  @override
  Widget build(BuildContext context) {
    const mainBlue = Color(0xFF88BDF2);

    // Pastikan halaman aktif saat HomePage dibuka
    controller.setPage(myCtrl.PageType.home);

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
              // Halo Mahasiswa
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

              // 🔥 Jika sudah punya dosen, tampilkan Progress TA dulu
              if (status == 'sudah') _buildProgressTA(),

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
                  children: const [
                    _InfoCard(title: "Template Laporan", mainBlue: mainBlue),
                    SizedBox(width: 12),
                    _InfoCard(title: "Jadwal Sidang", mainBlue: mainBlue),
                    SizedBox(width: 12),
                    _InfoCard(title: "Panduan Sidang", mainBlue: mainBlue),
                  ],
                ),
              ),
              const SizedBox(height: 25),

              // 🔥 Jika sudah punya dosen, tampilkan Upcoming setelah Pengumuman
              if (status == 'sudah') _buildUpcoming(),

              // 🔥 Kondisi lain
              if (status == 'belum') _buildBelumPunyaDosen(),
              if (status == 'menunggu') _buildCardStatusPengajuan(),
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

  // ================= Jika belum punya dosen =================
  Widget _buildBelumPunyaDosen() {
    return const Padding(
      padding: EdgeInsets.only(top: 100),
      child: Center(
        child: Text(
          "Belum memiliki dosen pembimbing",
          style: TextStyle(
            fontSize: 16,
            color: Color(0xFF616161),
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  // ================= Jika status pengajuan sedang menunggu =================
 Widget _buildCardStatusPengajuan() {
  return Padding(
    padding: const EdgeInsets.only(top: 12), 
    child: Container(
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
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Status Pengajuan Dosen Pembimbing",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: dangerColor,
              fontSize: 16,
            ),
          ),
         SizedBox(height: 10),
Text(
  "Nama Dosen: Sukma Evadini, S.T., M.Kom",
  style: TextStyle(
    color: Colors.black, 
    fontWeight: FontWeight.w500,
  ),
),
Text(
  "Tanggal Pengajuan: 4 November 2025",
  style: TextStyle(
    color: Colors.black, 
    fontWeight: FontWeight.w500,
  ),
),
Text(
  "Jam Pengajuan: 14:30",
  style: TextStyle(
    color: Colors.black, 
    fontWeight: FontWeight.w500,
  ),
),

          SizedBox(height: 8),
          Text(
            "Status: Menunggu Konfirmasi Dosen",
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.orange,
            ),
          ),
        ],
      ),
    ),
  );
}



  // ================= Progress TA =================
  Widget _buildProgressTA() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
      ],
    );
  }

  // ================= Upcoming =================
  Widget _buildUpcoming() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text(
          "Upcoming",
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10),
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
      ],
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
            blurRadius: 15,
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
              Text(date,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 14.5,
                    fontWeight: FontWeight.w500,
                  )),
            ],
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              const Icon(Icons.access_time, color: Colors.black, size: 18),
              const SizedBox(width: 6),
              Text(time,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 14.5,
                    fontWeight: FontWeight.w500,
                  )),
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
