import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inta301/pages/modal_tambah_dokumen.dart';
import 'package:inta301/pages/modal_edit_dokumen.dart';
import 'package:inta301/pages/modal_revisi_dokumen.dart';
import '../shared/shared.dart';
import 'dokumen_controller.dart';
import 'dokumen_card.dart';
import '../routes/app_pages.dart';

class DokumenPage extends StatelessWidget {
  DokumenPage({super.key});
  final DokumenController controller = Get.put(DokumenController());

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: backgroundColor,

        // === APP BAR ===
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

        // === BODY ===
        body: Column(
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

            // --- Daftar Dokumen per tab ---
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
        ),

        // === TOMBOL TAMBAH ===
        floatingActionButton: FloatingActionButton(
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
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,

        // === BOTTOM NAVIGATION ===
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
                onTap: () => Get.offAllNamed(Routes.KANBAN),
              ),
              _BottomNavItem(
                icon: Icons.description_outlined,
                label: "Dokumen",
                onTap: () {},
              ),
              _BottomNavItem(
                icon: Icons.person_outline,
                label: "Profile",
                onTap: () => Get.offAllNamed(Routes.PROFILE),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // --- Build List per Tab ---
  Widget _buildTabList(RxList<DokumenModel> list, BuildContext context) {
    void _confirmDelete(DokumenModel dokumen) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
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
              child: const Text("Hapus", style: TextStyle(color: Colors.red)),
            ),
          ],
        ),
      );
    }

    return Obx(
      () => ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: defaultMargin),
        itemCount: list.length,
        itemBuilder: (context, index) {
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
            onDelete: () {
              _confirmDelete(dokumen);
            },
            onDownload: () {
              // logika download dokumen
            },
            onViewRevisi: dokumen.status.toLowerCase() == "revisi"
                ? () {
                    showRevisiModal(context, dokumen);
                  }
                : null,
          );
        },
      ),
    );
  }
}

// --- Bottom Navigation Item ---
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
