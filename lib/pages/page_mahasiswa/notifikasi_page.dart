import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inta301/shared/shared.dart';


class NotifikasiPage extends StatelessWidget {
  const NotifikasiPage({super.key});

  @override
  Widget build(BuildContext context) {
    const mainBlue = Color(0xFF88BDF2);

    final List<Map<String, dynamic>> notifications = [
      {
        "type": "pengingat",
        "title": "Pengingat!",
        "message": "Sidang TA akan segera berlangsung, persiapkan dokumen.",
        "time": "17:00 – April 24",
      },
      {
        "type": "update",
        "title": "Update Terbaru",
        "message": "Unggah BAB II: Latar Belakang sebelum batas waktu.",
        "time": "15:00 – April 24",
      },
      {
        "type": "pengingat",
        "title": "Pengingat!",
        "message": "Bimbingan pukul 10:00 di ruang TA 12.4. Jangan sampai telat!",
        "time": "09:00 – Oktober 21",
      },
      {
        "type": "ajuan",
        "title": "Ajuan Jadwal Bimbingan",
        "message":
            "Dosen pembimbing mengajukan jadwal bimbingan baru pada Rabu, 6 November 2025 pukul 14:00.",
        "time": "10:30 – November 4",
      },
      {
        "type": "diterima",
        "title": "Ajuan Diterima",
        "message":
            "Pengajuan jadwal bimbinganmu telah disetujui oleh dosen pembimbing.",
        "time": "12:15 – November 5",
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
            icon: notif["type"] == "update"
                ? Icons.update
                : notif["type"] == "ajuan"
                    ? Icons.schedule_send_outlined
                    : notif["type"] == "diterima"
                        ? Icons.check_circle_outline
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
            child: Icon(icon, color: dangerColor, size: 26), // ✅ pakai dangerColor
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
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
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
