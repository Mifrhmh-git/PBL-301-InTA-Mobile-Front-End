import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:inta301/shared/shared.dart';

class NotifikasiDosenPage extends StatelessWidget {
  const NotifikasiDosenPage({super.key});

  @override
  Widget build(BuildContext context) {
    const mainBlue = Color(0xFF88BDF2);

    // Fungsi format waktu otomatis Indonesia
    String formatDate(DateTime date) {
      return DateFormat('HH:mm – dd MMMM yyyy', 'id_ID').format(date);
    }

    final List<Map<String, dynamic>> notifications = [
      {
        "type": "ajuan",
        "title": "Ajuan Bimbingan Baru",
        "message":
            "Mahasiswa Putri Balqis mengajukan jadwal bimbingan pada Jumat, 8 November 2025 pukul 13:00.",
        "time": formatDate(DateTime(2025, 11, 5, 9, 30)),
      },
      {
        "type": "diterima",
        "title": "Jadwal Diterima Mahasiswa",
        "message":
            "Mahasiswa Ahmad Rafi telah menyetujui jadwal bimbingan yang Anda ajukan.",
        "time": formatDate(DateTime(2025, 11, 4, 14, 10)),
      },
      {
        "type": "ditolak",
        "title": "Jadwal Ditolak Mahasiswa",
        "message":
            "Mahasiswa Lina Septiani menolak jadwal bimbingan yang Anda ajukan karena bentrok dengan mata kuliah.",
        "time": formatDate(DateTime(2025, 11, 3, 16, 45)),
      },
      {
        "type": "pengingat",
        "title": "Pengingat Bimbingan",
        "message":
            "Bimbingan bersama mahasiswa Andi akan dimulai pukul 10:00 di ruang TA 12.4.",
        "time": formatDate(DateTime(2025, 11, 3, 8, 00)),
      },
      {
        "type": "update",
        "title": "Update Dokumen Mahasiswa",
        "message":
            "Mahasiswa Dini Kurnia telah mengunggah revisi BAB III untuk Anda tinjau.",
        "time": formatDate(DateTime(2025, 11, 2, 19, 20)),
      },
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [primaryColor, dangerColor],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        centerTitle: true,
        title: const Text(
          "Notifikasi",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Get.back(),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          final notif = notifications[index];

          return _buildNotificationItem(
            icon: notif["type"] == "ajuan"
                ? Icons.schedule_send_outlined
                : notif["type"] == "diterima"
                    ? Icons.check_circle_outline
                    : notif["type"] == "ditolak"
                        ? Icons.cancel_outlined
                        : notif["type"] == "update"
                            ? Icons.upload_file_outlined
                            : Icons.notifications_active_outlined,
            title: notif["title"],
            message: notif["message"],
            time: notif["time"],
          );
        },
      ),
    );
  }

  Widget _buildNotificationItem({
    required IconData icon,
    required String title,
    required String message,
    required String time,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.35),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: dangerColor.withOpacity(0.15),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: dangerColor, size: 26),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  message,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 13.5,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  time,
                  style: const TextStyle(
                    color: Color(0xFF616161),
                    fontWeight: FontWeight.w600,
                    fontSize: 12.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
