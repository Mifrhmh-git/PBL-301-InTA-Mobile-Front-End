part of 'pages.dart';

class NotifikasiPage extends StatelessWidget {
  const NotifikasiPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
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

      // === BODY ===
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildSectionTitle("Today"),
          _buildNotificationItem(
            icon: Icons.notifications_active_outlined,
            title: "Pengingat!",
            message: "Sidang TA akan segera berlangsung, persiapkan dokumen.",
            time: "17:00 – April 24",
          ),
          _buildNotificationItem(
            icon: Icons.update,
            title: "Update Terbaru",
            message: "Unggah BAB II: Latar Belakang sebelum batas waktu.",
            time: "17:00 – April 24",
          ),
          const SizedBox(height: 20),

          _buildSectionTitle("Yesterday"),
          _buildNotificationItem(
            icon: Icons.notifications_active_outlined,
            title: "Pengingat!",
            message: "Bimbingan pukul 10:00 di TA 12.4. Jangan sampai telat!",
            time: "17:00 – April 24",
          ),
          _buildNotificationItem(
            icon: Icons.notifications_active_outlined,
            title: "Pengingat!",
            message: "Bimbingan online pukul 14:00. Jangan sampai telat!",
            time: "17:00 – April 24",
          ),
          const SizedBox(height: 20),

          _buildSectionTitle("This Weekend"),
          _buildNotificationItem(
            icon: Icons.update,
            title: "Update Terbaru",
            message: "Unggah BAB I: Pendahuluan hari ini.",
            time: "17:00 – April 24",
          ),
          _buildNotificationItem(
            icon: Icons.notifications_active_outlined,
            title: "Pengingat!",
            message: "Bimbingan pukul 13:30 di TA 10.2. Jangan sampai telat!",
            time: "17:00 – April 24",
          ),
        ],
      ),
    );
  }

  // === SECTION TITLE ===
  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text(
        title,
        style: TextStyle(
          color: blackColor,
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
    );
  }

  // === NOTIFICATION ITEM ===
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
        color: whiteColor,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15), // bayangan lebih jelas
            blurRadius: 12, // lebih lembut dan lebar
            spreadRadius: 2, // sedikit menyebar
            offset: const Offset(0, 5), // arah bayangan ke bawah
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // === ICON ===
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: primaryColor.withOpacity(0.2),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: primaryColor, size: 26),
          ),
          const SizedBox(width: 10),

          // === TEXT CONTENT ===
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: blackColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  message,
                  style: TextStyle(
                    color: blackColor.withOpacity(0.8),
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  time,
                  style: TextStyle(
                    color: primaryColor,
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
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
