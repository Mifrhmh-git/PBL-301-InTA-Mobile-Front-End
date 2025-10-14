import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../shared/shared.dart';
import '../routes/app_pages.dart';

/// --- MODEL ---
class DokumenTask {
  final String title;
  final String date;
  final String status;
  final String description;

  DokumenTask({
    required this.title,
    required this.date,
    required this.status,
    this.description = "-",
  });
}

/// --- CONTROLLER ---
class DokumenController extends GetxController {
  var dokumenList = <DokumenTask>[].obs;

  @override
  void onInit() {
    super.onInit();
    dokumenList.addAll([
      DokumenTask(
        title: "BAB III: Analisis dan Perancangan",
        date: "20 September 2025, 13.00",
        status: "Menunggu",
      ),
      DokumenTask(
        title: "BAB II: Landasan Teori",
        date: "18 September 2025, 13.00",
        status: "Revisi",
        description: "Struktur penulisan kurang sistematis.",
      ),
      DokumenTask(
        title: "BAB I: Pendahuluan",
        date: "15 September 2025, 12.00",
        status: "Disetujui",
        description: "Pendahuluan sudah sesuai dengan topik penelitian",
      ),
      DokumenTask(
        title: "Proposal Tugas Akhir",
        date: "10 September 2025, 10.00",
        status: "Disetujui",
        description: "Siap dilanjutkan ke BAB I",
      ),
    ]);
  }

  void addDokumen(String title, String date, String status, String description) {
    final newDokumen = DokumenTask(
      title: title,
      date: date,
      status: status,
      description: description,
    );
    dokumenList.insert(0, newDokumen);
  }
}

/// --- KARTU DOKUMEN ---
class DokumenCard extends StatelessWidget {
  final DokumenTask task;
  const DokumenCard({super.key, required this.task});

  Color _getStatusColor(String status) {
    switch (status) {
      case "Menunggu":
        return Colors.amber.shade600;
      case "Revisi":
        return Colors.red.shade400;
      case "Disetujui":
        return Colors.green.shade400;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    Color statusColor = _getStatusColor(task.status);

    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white, // Card putih
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.4),
            blurRadius: 12,
            spreadRadius: 2,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Judul & status
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  task.title,
                  style: TextStyle(
                    color: blackColor, // ✅ teks hitam
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: blackColor.withOpacity(0.1), // background status lebih soft
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  task.status,
                  style: TextStyle(
                    color: statusColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          // Tanggal
          Row(
            children: [
              Icon(Icons.access_time, color: blackColor, size: 14), // ✅ hitam
              const SizedBox(width: 4),
              Text(
                task.date,
                style: TextStyle(
                  color: blackColor, // ✅ hitam
                  fontSize: 13,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          // Keterangan
          Text(
            "Keterangan : ${task.description}",
            style: TextStyle(
              color: blackColor, // ✅ hitam
              fontSize: 13,
            ),
          ),
          const SizedBox(height: 10),
          // Aksi
          Row(
            children: [
              Icon(Icons.download, color: blackColor, size: 24),
              const SizedBox(width: 15),
              Icon(Icons.edit, color: blackColor, size: 24),
              if (task.status != "Disetujui") ...[
                const SizedBox(width: 15),
                Icon(Icons.delete, color: blackColor, size: 24),
              ]
            ],
          ),
        ],
      ),
    );
  }
}

/// --- HALAMAN DOKUMEN ---
class DokumenPage extends StatelessWidget {
  DokumenPage({super.key});
  final DokumenController controller = Get.put(DokumenController());

  PreferredSizeWidget _buildCustomAppBar() {
    return AppBar(
      backgroundColor: primaryColor,
      centerTitle: true,
      elevation: 0,
      automaticallyImplyLeading: false,
      title: const Text(
        "Dokumen Tugas Akhir",
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
    );
  }

  void _showAddDokumenDialog(BuildContext context) {
    final titleController = TextEditingController();
    final dateController = TextEditingController();
    final descriptionController = TextEditingController();
    String selectedStatus = "Menunggu";

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Upload Dokumen Baru"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(labelText: "Judul Dokumen"),
              ),
              TextField(
                controller: dateController,
                decoration: const InputDecoration(
                    labelText: "Tanggal Upload (cth: 22 Oktober 2025, 10.00)"),
              ),
              TextField(
                controller: descriptionController,
                decoration: const InputDecoration(labelText: "Keterangan"),
              ),
              const SizedBox(height: 10),
              DropdownButtonFormField<String>(
                value: selectedStatus,
                decoration: const InputDecoration(labelText: "Status Awal"),
                items: <String>['Menunggu', 'Revisi', 'Disetujui']
                    .map((value) => DropdownMenuItem(
                          value: value,
                          child: Text(value),
                        ))
                    .toList(),
                onChanged: (newValue) {
                  selectedStatus = newValue ?? "Menunggu";
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Batal"),
            ),
            ElevatedButton(
              onPressed: () {
                if (titleController.text.isNotEmpty &&
                    dateController.text.isNotEmpty) {
                  controller.addDokumen(
                    titleController.text,
                    dateController.text,
                    selectedStatus,
                    descriptionController.text.isEmpty
                        ? "-"
                        : descriptionController.text,
                  );
                  Navigator.pop(context);
                }
              },
              child: const Text("Upload"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildCustomAppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: defaultMargin),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 15),
              Text(
                "Sudah Upload",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: blackColor, // ✅ hitam
                ),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: Obx(
                  () => ListView.builder(
                    itemCount: controller.dokumenList.length,
                    itemBuilder: (context, index) {
                      return DokumenCard(task: controller.dokumenList[index]);
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: primaryColor,
        onPressed: () => _showAddDokumenDialog(context),
        child: const Icon(Icons.add, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        decoration: BoxDecoration(
          color: primaryColor,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _BottomNavItem(icon: Icons.home, label: "Beranda", onTap: () => Get.offAllNamed(Routes.HOME)),
            _BottomNavItem(icon: Icons.calendar_month, label: "Jadwal", onTap: () => Get.offAllNamed(Routes.JADWAL)),
            _BottomNavItem(icon: Icons.bar_chart_outlined, label: "Kanban", onTap: () => Get.offAllNamed(Routes.KANBAN)),
            _BottomNavItem(icon: Icons.description_outlined, label: "Dokumen", onTap: () {}),
            _BottomNavItem(icon: Icons.person_outline, label: "Profile", onTap: () => Get.offAllNamed(Routes.PROFILE)),
          ],
        ),
      ),
    );
  }
}

/// --- Bottom Navigation Item ---
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
