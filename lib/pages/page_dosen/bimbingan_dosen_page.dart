import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inta301/shared/shared.dart';
import 'package:inta301/routes/app_pages.dart';
import 'package:inta301/controllers/menu_dosen_controller.dart';

class BimbinganDosenPage extends GetView<MenuDosenController> {
  const BimbinganDosenPage({super.key});

  @override
  Widget build(BuildContext context) {
    controller.setPage(PageTypeDosen.bimbingan);

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        elevation: 0,
        title: const Text(
          "Daftar Mahasiswa",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18,
            fontFamily: 'Poppins',
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
                  horizontal: defaultMargin, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 6,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: const TabBar(
                indicatorSize: TabBarIndicatorSize.tab,
                indicator: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(width: 2, color: primaryColor),
                  ),
                ),
                labelColor: blackColor,
                labelStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  fontFamily: 'Poppins',
                ),
                tabs: [
                  Tab(text: "Daftar Mahasiswa"),
                  Tab(text: "Daftar Bimbingan"),
                  Tab(text: "Daftar Ajuan"),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  _buildDaftarMahasiswa(),
                  _buildDaftarBimbingan(),
                  _buildDaftarAjuan(),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Obx(() => _BottomNavDosen(
            currentPage: controller.currentPage.value,
          )),
    );
  }

  // --- Tab 1: Daftar Mahasiswa ---
  Widget _buildDaftarMahasiswa() {
    return ListView.builder(
      padding: const EdgeInsets.all(defaultMargin),
      itemCount: 3,
      itemBuilder: (context, index) {
        return _MahasiswaCard(
          nama: "Putri Balqis",
          nim: "4342401011",
          prodi: "Teknik Informatika",
        );
      },
    );
  }

  // --- Tab 2: Daftar Bimbingan ---
  Widget _buildDaftarBimbingan() {
    return const Center(
      child: Text("Daftar Bimbingan akan ditampilkan di sini."),
    );
  }

  // --- Tab 3: Daftar Ajuan ---
  Widget _buildDaftarAjuan() {
    return const Center(
      child: Text("Daftar Ajuan mahasiswa akan ditampilkan di sini."),
    );
  }
}

// --- Card Mahasiswa ---
class _MahasiswaCard extends StatelessWidget {
  final String nama;
  final String nim;
  final String prodi;

  const _MahasiswaCard({
    required this.nama,
    required this.nim,
    required this.prodi,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFB0D6FF),
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 6,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 25,
            backgroundColor: Colors.white,
            child: Icon(Icons.person, color: primaryColor, size: 30),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  nama,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    fontFamily: 'Poppins',
                  ),
                ),
                Text(
                  "$nim - $prodi",
                  style: const TextStyle(
                    fontSize: 13,
                    color: Colors.black87,
                    fontFamily: 'Poppins',
                  ),
                ),
              ],
            ),
          ),
          const Icon(Icons.arrow_forward_ios, color: Colors.black54),
        ],
      ),
    );
  }
}

// --- Bottom Navigation Dosen ---
class _BottomNavDosen extends StatelessWidget {
  final PageTypeDosen currentPage;

  const _BottomNavDosen({required this.currentPage});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<MenuDosenController>();

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
            isActive: currentPage == PageTypeDosen.home,
            onTap: () => Get.offAllNamed(Routes.HOME_DOSEN),
          ),
          _BottomNavItem(
            icon: Icons.calendar_month,
            label: "Jadwal",
            isActive: currentPage == PageTypeDosen.jadwal,
            onTap: () => Get.offAllNamed(Routes.JADWAL_DOSEN),
          ),
          _BottomNavItem(
            icon: Icons.bar_chart_outlined,
            label: "Bimbingan",
            isActive: currentPage == PageTypeDosen.bimbingan,
            onTap: () => Get.offAllNamed(Routes.BIMBINGAN_DOSEN),
          ),
          _BottomNavItem(
            icon: Icons.description_outlined,
            label: "Dokumen",
            isActive: currentPage == PageTypeDosen.dokumen,
            onTap: () => Get.offAllNamed(Routes.DOKUMEN_DOSEN),
          ),
          _BottomNavItem(
            icon: Icons.person_outline,
            label: "Profil",
            isActive: currentPage == PageTypeDosen.profile,
            onTap: () => Get.offAllNamed(Routes.PROFILE_DOSEN),
          ),
        ],
      ),
    );
  }
}

// --- Bottom Nav Item (reusable) ---
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

