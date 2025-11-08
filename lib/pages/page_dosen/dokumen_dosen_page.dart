import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inta301/shared/shared.dart';
import 'package:inta301/routes/app_pages.dart';
import 'package:inta301/controllers/menu_dosen_controller.dart' as myCtrl;

class DokumenDosenPage extends StatefulWidget {
  const DokumenDosenPage({super.key});

  @override
  State<DokumenDosenPage> createState() => _DokumenDosenPageState();
}

class _DokumenDosenPageState extends State<DokumenDosenPage> {
  late final myCtrl.MenuDosenController controller;

  final List<Map<String, String>> dokumenList = [
    {
      "nama": "Putri Balqis",
      "nim": "4342401011",
      "jurusan": "Teknik Informatika",
    },
    {
      "nama": "Ahmad Rafi",
      "nim": "4342401012",
      "jurusan": "Teknik Informatika",
    },
    {
      "nama": "Dini Kurnia",
      "nim": "4342401013",
      "jurusan": "Teknik Informatika",
    },
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
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),

      // ===== BODY =====
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(defaultMargin),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Sudah Upload",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 12),

              Expanded(
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: dokumenList.length,
                  itemBuilder: (context, index) {
                    final mhs = dokumenList[index];
                    return GestureDetector(
                      onTap: () {
                        Get.to(() => DetailDokumenMahasiswaPage(
                              nama: mhs["nama"]!,
                              nim: mhs["nim"]!,
                              jurusan: mhs["jurusan"]!,
                            ));
                      },
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 10),
                        decoration: BoxDecoration(
                          color: primaryColor.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            const CircleAvatar(
                              radius: 22,
                              backgroundColor: Colors.white,
                              child: Icon(Icons.person, color: primaryColor),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    mhs["nama"]!,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  Text(
                                    "${mhs["nim"]!} - ${mhs["jurusan"]!}",
                                    style: const TextStyle(fontSize: 14),
                                  ),
                                ],
                              ),
                            ),
                            const Icon(Icons.arrow_forward_ios_rounded,
                                color: Colors.black54),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),

      // ===== BOTTOM NAVIGATION =====
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
                isActive: controller.currentPage.value ==
                    myCtrl.PageTypeDosen.bimbingan,
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

// ========== Bottom Navigation Item ==========
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

// ===============================================
// ========== Detail Dokumen Mahasiswa ==========
// ===============================================
class DetailDokumenMahasiswaPage extends StatelessWidget {
  final String nama;
  final String nim;
  final String jurusan;

  const DetailDokumenMahasiswaPage({
    super.key,
    required this.nama,
    required this.nim,
    required this.jurusan,
  });

  @override
  Widget build(BuildContext context) {
    final tabController = ValueNotifier<int>(0);

    final dokumenList = [
      {
        "judul": "BAB I: Pendahuluan",
        "tanggal": "3 Juni 2025, 12:00",
        "status": "Disetujui",
        "keterangan": "Pendahuluan sudah sesuai dan bagus",
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Dokumen Mahasiswa"),
        backgroundColor: primaryColor,
      ),
      body: Column(
        children: [
          Container(
            color: primaryColor.withOpacity(0.2),
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                const CircleAvatar(
                  radius: 28,
                  backgroundColor: Colors.white,
                  child: Icon(Icons.person, color: primaryColor, size: 30),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      nama,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    Text("$nim - $jurusan"),
                  ],
                ),
              ],
            ),
          ),

          // ===== TAB =====
          ValueListenableBuilder<int>(
            valueListenable: tabController,
            builder: (context, index, _) {
              return Column(
                children: [
                  Container(
                    color: Colors.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _TabButton(
                          title: "Menunggu",
                          isActive: index == 0,
                          onTap: () => tabController.value = 0,
                        ),
                        _TabButton(
                          title: "Disetujui",
                          isActive: index == 1,
                          onTap: () => tabController.value = 1,
                        ),
                        _TabButton(
                          title: "Revisi",
                          isActive: index == 2,
                          onTap: () => tabController.value = 2,
                        ),
                      ],
                    ),
                  ),
                  const Divider(height: 0, thickness: 1),

                  // ===== CARD DOKUMEN =====
                  if (index == 1)
                    Padding(
                      padding: const EdgeInsets.all(12),
                      child: Container(
                        decoration: BoxDecoration(
                          color: primaryColor.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 4,
                              offset: Offset(0, 2),
                            )
                          ],
                        ),
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  dokumenList[0]["judul"]!,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: Colors.green[100],
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: const Text(
                                    "Disetujui",
                                    style: TextStyle(
                                        color: Colors.green,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 6),
                            Text("Diunggah: ${dokumenList[0]["tanggal"]}"),
                            const SizedBox(height: 4),
                            Text(
                                "Keterangan: ${dokumenList[0]["keterangan"]}"),
                            const SizedBox(height: 8),
                            const Divider(),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: IconButton(
                                icon: const Icon(Icons.download_rounded),
                                onPressed: () {},
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

class _TabButton extends StatelessWidget {
  final String title;
  final bool isActive;
  final VoidCallback onTap;

  const _TabButton({
    required this.title,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onTap,
      child: Text(
        title,
        style: TextStyle(
          color: isActive ? primaryColor : Colors.black54,
          fontWeight: isActive ? FontWeight.bold : FontWeight.w500,
        ),
      ),
    );
  }
}
