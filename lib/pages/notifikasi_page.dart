import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../shared/shared.dart';
import '../routes/app_pages.dart'; // import Routes
import 'form_jadwal.dart';

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
        "type": "ajuan_dosen",
        "title": "Ajuan Jadwal Dosen",
        "message": "Dosen X mengajukan jadwal bimbingan 21 Oktober, 10:00",
        "time": "16:00 – Oktober 19",
        "jadwalId": 123,
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
        "message": "Bimbingan pukul 10:00 di TA 12.4. Jangan sampai telat!",
        "time": "17:00 – April 24",
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
          final bool isClickable = notif["type"] == "ajuan_dosen";

          return GestureDetector(
            onTap: isClickable
                ? () {
                    Get.toNamed(
                      Routes.FORM_JADWAL, // ✅ ganti _Paths jadi Routes
                      arguments: {"jadwalId": notif["jadwalId"]},
                    );
                  }
                : null,
            child: _buildNotificationItem(
              icon: isClickable
                  ? Icons.schedule
                  : notif["type"] == "update"
                      ? Icons.update
                      : Icons.notifications_active_outlined,
              title: notif["title"],
              message: notif["message"],
              time: notif["time"],
              mainBlue: mainBlue,
              isClickable: isClickable,
            ),
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
    required Color mainBlue,
    bool isClickable = false,
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
        border: isClickable ? Border.all(color: mainBlue, width: 1.5) : null,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: mainBlue.withOpacity(0.2),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: mainBlue, size: 26),
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
                  style: TextStyle(
                    color: Colors.black.withOpacity(0.8),
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  time,
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          if (isClickable)
            const Icon(
              Icons.arrow_forward_ios,
              size: 14,
              color: Colors.black54,
            ),
        ],
      ),
    );
  }
}
