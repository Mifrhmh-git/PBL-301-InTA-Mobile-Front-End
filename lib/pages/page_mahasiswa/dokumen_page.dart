import 'package:flutter/material.dart';
import 'package:get/get.dart';

// Pages & Modal
import 'package:inta301/pages/page_mahasiswa/modal_tambah_dokumen.dart';
import 'package:inta301/pages/page_mahasiswa/modal_edit_dokumen.dart';
import 'package:inta301/pages/page_mahasiswa/modal_revisi_dokumen.dart';
import 'package:inta301/pages/page_mahasiswa/dokumen_controller.dart';
import 'package:inta301/pages/page_mahasiswa/dokumen_card.dart';

// Global
import 'package:inta301/shared/shared.dart';
import 'package:inta301/routes/app_pages.dart';

class DokumenPage extends StatelessWidget {
  final bool hasDosen;

  DokumenPage({super.key, required this.hasDosen});

  final DokumenController controller = Get.put(DokumenController());
  final RxInt selectedIndex = 3.obs; // Tab dokumen ada di index 3

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: backgroundColor,

        // ===================== APP BAR =====================
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          automaticallyImplyLeading: false,
          title: const Text(
            "Dokumen",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 20,
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

        // ===================== BODY =====================
        body: hasDosen
            ? Column(
                children: [
                  // ==== TAB BAR ====
                  Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: defaultMargin,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: const TabBar(
                      indicatorSize: TabBarIndicatorSize.tab,
                      indicator: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                      ),
                      labelColor: Colors.white,
                      unselectedLabelColor: blackColor,
                      tabs: [
                        Tab(text: "Menunggu"),
                        Tab(text: "Revisi"),
                        Tab(text: "Selesai"),
                      ],
                    ),
                  ),

                  // ==== TAB CONTENT ====
                  Expanded(
                    child: TabBarView(
                      children: [
                        _buildTabList(controller.menungguList, context),
                        _buildTabList(controller.revisiList, context),
                        _buildTabList(controller.selesaiList, context),
                      ],
                    ),
                  ),
                ],
              )
            : const Padding(
                padding: EdgeInsets.only(top: 100),
                child: Center(
                  child: Text(
                    "Belum memiliki dosen pembimbing",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Poppins',
                    ),
                  ),
                ),
              ),

        // ===================== FAB (TAMBAH) =====================
        floatingActionButton: hasDosen
            ? FloatingActionButton(
                backgroundColor: dangerColor,
                onPressed: () {
                  showModalBottomSheet(
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                    context: context,
                    builder: (_) => const TambahDokumenModal(),
                  );
                },
                child: const Icon(Icons.add, color: Colors.white),
              )
            : null,

        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,

        // ===================== BOTTOM NAVIGATION =====================
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
                  label: "Beranda",
                  isActive: selectedIndex.value == 0,
                  onTap: () => _navigate(0, Routes.HOME),
                ),
                _BottomNavItem(
                  icon: Icons.calendar_month,
                  label: "Jadwal",
                  isActive: selectedIndex.value == 1,
                  onTap: () => _navigate(1, Routes.JADWAL),
                ),
                _BottomNavItem(
                  icon: Icons.bar_chart_outlined,
                  label: "Kanban",
                  isActive: selectedIndex.value == 2,
                  onTap: () => _navigate(2, Routes.KANBAN),
                ),
                _BottomNavItem(
                  icon: Icons.description_outlined,
                  label: "Dokumen",
                  isActive: selectedIndex.value == 3,
                  onTap: () => _navigate(3, Routes.DOKUMEN),
                ),
                _BottomNavItem(
                  icon: Icons.person_outline,
                  label: "Profile",
                  isActive: selectedIndex.value == 4,
                  onTap: () => _navigate(4, Routes.PROFILE),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _navigate(int index, String route) {
    selectedIndex.value = index;
    Get.offAllNamed(route);
  }

  // ===================== TAB LIST BUILDER =====================
  Widget _buildTabList(RxList<DokumenModel> list, BuildContext context) {
    void confirmDelete(DokumenModel dokumen) {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text("Konfirmasi Hapus"),
          content: const Text("Apakah Anda yakin ingin menghapus dokumen ini?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Batal"),
            ),
            TextButton(
              onPressed: () {
                Get.find<DokumenController>().deleteDokumen(dokumen);
                Navigator.pop(context);

                Get.snackbar(
                  "Dihapus",
                  "Dokumen berhasil dihapus",
                  backgroundColor: Colors.red.shade600,
                  colorText: Colors.white,
                  snackPosition: SnackPosition.BOTTOM,
                  margin: const EdgeInsets.all(16),
                );
              },
              child: const Text(
                "Hapus",
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        ),
      );
    }

    return Obx(
      () => ListView.builder(
        padding: const EdgeInsets.symmetric(
          vertical: 8,
          horizontal: defaultMargin,
        ),
        itemCount: list.length,
        itemBuilder: (_, index) {
          final dokumen = list[index];

          return DokumenCard(
            dokumen: dokumen,
            onAdd: () {},
            onEdit: () {
              showModalBottomSheet(
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
                context: context,
                builder: (_) => EditModal(dokumen: dokumen),
              );
            },
            onDelete: () => confirmDelete(dokumen),
            onDownload: () {},
            onViewRevisi: dokumen.status.toLowerCase() == "revisi"
                ? () => showRevisiModal(context, dokumen)
                : null,
          );
        },
      ),
    );
  }
}

// ===================== BOTTOM NAV ITEM =====================
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
              fontWeight: FontWeight.w500,
              fontFamily: 'Poppins',
            ),
          ),
        ],
      ),
    );
  }
}
