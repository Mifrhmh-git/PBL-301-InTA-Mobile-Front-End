import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inta301/shared/shared.dart';
import 'package:inta301/routes/app_pages.dart';
import 'package:inta301/controllers/menu_dosen_controller.dart' as myCtrl;
import 'package:inta301/pages/page_dosen/dokumen_dosen_card.dart';
import 'package:inta301/pages/page_dosen/detail_dokumen_mhs_page.dart';

class DokumenDosenPage extends StatefulWidget {
  const DokumenDosenPage({super.key});

  @override
  State<DokumenDosenPage> createState() => _DokumenDosenPageState();
}

class _DokumenDosenPageState extends State<DokumenDosenPage> {
  late final myCtrl.MenuDosenController controller;

  final List<Map<String, String>> dokumenList = [
    {"nama": "Putri Balqis", "nim": "4342401011", "jurusan": "Teknik Informatika"},
    {"nama": "Ahmad Rafi", "nim": "4342401012", "jurusan": "Teknik Informatika"},
    {"nama": "Dini Kurnia", "nim": "4342401013", "jurusan": "Teknik Informatika"},
  ];

  @override
  void initState() {
    super.initState();
    controller = Get.find<myCtrl.MenuDosenController>();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.setPage(myCtrl.PageTypeDosen.dokumen);
    });
  }

  @override
  Widget build(BuildContext context) {
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
          'Dokumen Tugas Akhir',
          style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(defaultMargin),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Sudah Upload",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              const SizedBox(height: 12),
              Expanded(
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: dokumenList.length,
                  itemBuilder: (context, index) {
                    final mhs = dokumenList[index];
                    return DokumenDosenCard(
                      nama: mhs["nama"]!,
                      nim: mhs["nim"]!,
                      jurusan: mhs["jurusan"]!,
                      onTap: () {
                       Get.to(() => DokumenMahasiswaPage(
  nama: mhs["nama"]!,
  nim: mhs["nim"]!,
  jurusan: mhs["jurusan"]!,
));


                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Obx(
        () => Container(
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
                label: "Home",
                isActive:
                    controller.currentPage.value == myCtrl.PageTypeDosen.home,
                onTap: () {
                  controller.setPage(myCtrl.PageTypeDosen.home);
                  Get.offAllNamed(Routes.HOME_DOSEN);
                },
              ),
              _BottomNavItem(
                icon: Icons.schedule_outlined,
                label: "Jadwal",
                isActive:
                    controller.currentPage.value == myCtrl.PageTypeDosen.jadwal,
                onTap: () {
                  controller.setPage(myCtrl.PageTypeDosen.jadwal);
                  Get.offAllNamed(Routes.JADWAL_DOSEN);
                },
              ),
              _BottomNavItem(
                icon: Icons.school_outlined,
                label: "Bimbingan",
                isActive:
                    controller.currentPage.value == myCtrl.PageTypeDosen.bimbingan,
                onTap: () {
                  controller.setPage(myCtrl.PageTypeDosen.bimbingan);
                  Get.offAllNamed(Routes.BIMBINGAN_DOSEN);
                },
              ),
              _BottomNavItem(
                icon: Icons.description_outlined,
                label: "Dokumen",
                isActive:
                    controller.currentPage.value == myCtrl.PageTypeDosen.dokumen,
                onTap: () {
                  controller.setPage(myCtrl.PageTypeDosen.dokumen);
                  Get.offAllNamed(Routes.DOKUMEN_DOSEN);
                },
              ),
              _BottomNavItem(
                icon: Icons.person_outline,
                label: "Profil",
                isActive:
                    controller.currentPage.value == myCtrl.PageTypeDosen.profile,
                onTap: () {
                  controller.setPage(myCtrl.PageTypeDosen.profile);
                  Get.offAllNamed(Routes.PROFILE_DOSEN);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ================= Bottom Nav Item =================
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
