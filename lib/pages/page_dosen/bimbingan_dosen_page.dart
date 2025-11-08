import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inta301/shared/shared.dart';
import 'package:inta301/routes/app_pages.dart';
import 'package:inta301/controllers/menu_dosen_controller.dart';

// Import card & modal yang sudah kamu buat
import 'package:inta301/pages/page_dosen/mahasiswa_card.dart';
import 'package:inta301/pages/page_dosen/ajukan_bimbingan_modal.dart';
import 'package:inta301/pages/page_dosen/bimbingan_card.dart';
import 'package:inta301/pages/page_dosen/form_ajuan_bimbingan_page.dart';
import 'package:inta301/pages/page_dosen/ajuan_dospem_card.dart';
import 'package:inta301/pages/page_dosen/form_ajuan_dospem.dart';


class BimbinganDosenPage extends GetView<MenuDosenController> {
  const BimbinganDosenPage({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.setPage(PageTypeDosen.bimbingan);
    });

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        elevation: 0,
        title: const Text(
          "Bimbingan Mahasiswa",
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
              child: TabBar(
                indicator: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(15),
                ),
                labelColor: Colors.white,
                unselectedLabelColor: Colors.black,
                indicatorSize: TabBarIndicatorSize.tab,
                labelStyle: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                  fontFamily: 'Poppins',
                ),
                tabs: const [
                  Tab(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Daftar", style: TextStyle(fontSize: 12)),
                        SizedBox(height: 2),
                        Text("Mahasiswa",
                            style: TextStyle(
                                fontSize: 13, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                  Tab(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Daftar", style: TextStyle(fontSize: 12)),
                        SizedBox(height: 2),
                        Text("Bimbingan",
                            style: TextStyle(
                                fontSize: 13, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                  Tab(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Daftar", style: TextStyle(fontSize: 12)),
                        SizedBox(height: 2),
                        Text("Ajuan",
                            style: TextStyle(
                                fontSize: 13, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  _buildDaftarMahasiswa(context),
                  _buildDaftarBimbingan(),
                  _buildDaftarAjuan(), // 🔥 TAB 3 YANG BARU
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
  Widget _buildDaftarMahasiswa(BuildContext context) {
    final mahasiswaList = [
      {"nama": "Putri Balqis", "nim": "4342401011", "prodi": "Teknik Informatika"},
      {"nama": "Ahmad Fauzi", "nim": "4342401022", "prodi": "Teknik Informatika"},
      {"nama": "Rina Sari", "nim": "4342401033", "prodi": "Teknik Informatika"},
    ];

    return ListView.builder(
      padding: const EdgeInsets.all(defaultMargin),
      itemCount: mahasiswaList.length,
      itemBuilder: (context, index) {
        final mhs = mahasiswaList[index];
        return MahasiswaCard(
          nama: mhs["nama"]!,
          nim: mhs["nim"]!,
          prodi: mhs["prodi"]!,
          onAjukanBimbingan: () {
            showAjukanBimbinganModal(
              context: context,
              onSubmit: (judul, dosen, tanggal, waktu, lokasi) {
                print("Ajukan bimbingan ke ${mhs["nama"]}: "
                    "$judul, $dosen, $tanggal, $waktu, $lokasi");
              },
            );
          },
        );
      },
    );
  }

  // --- Tab 2: Daftar Bimbingan ---
  Widget _buildDaftarBimbingan() {
    final list = [
      {"nama": "Putri Balqis", "nim": "4342401011", "prodi": "Teknik Informatika"},
      {"nama": "Ahmad Fauzi", "nim": "4342401022", "prodi": "Teknik Informatika"},
    ];

    return ListView(
      padding: const EdgeInsets.all(defaultMargin),
      children: list.map((mhs) {
        return BimbinganCard(
          nama: mhs["nama"]!,
          nim: mhs["nim"]!,
          prodi: mhs["prodi"]!,
          onTap: () {
            Get.to(() => const FormAjuanBimbinganPage());
          },
        );
      }).toList(),
    );
  }

  // --- Tab 3: Daftar Ajuan ---
 Widget _buildDaftarAjuan() {
  final listAjuan = [
    {"nama": "Siti Rahma", "nim": "4342401055", "prodi": "Teknik Informatika"},
    {"nama": "Dimas Pratama", "nim": "4342401033", "prodi": "Teknik Informatika"},
  ];

  return ListView(
    padding: const EdgeInsets.all(defaultMargin),
    children: listAjuan.map((mhs) {
      return AjuanDospemCard(
        nama: mhs["nama"]!,
        nim: mhs["nim"]!,
        prodi: mhs["prodi"]!,
       onTap: () {
  Get.to(() => const FormAjuanDospemPage());
},

      );
    }).toList(),
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
