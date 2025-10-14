part of 'pages.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        elevation: 6, // 🔹 bayangan appbar
        shadowColor: Colors.black.withOpacity(0.3),
        title: const Text(
          'Beranda',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none, color: Colors.white),
            onPressed: () => Get.toNamed(Routes.NOTIFIKASI),
          ),
        ],
      ),

      // === BODY ===
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(defaultMargin),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // === Header Mahasiswa ===
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    const CircleAvatar(
                      radius: 25,
                      backgroundImage: AssetImage('assets/images/avatar.png'),
                    ),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Putri Balqis",
                          style: whiteTextStyle.copyWith(
                            color: blackColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "Mahasiswa",
                          style: whiteTextStyle.copyWith(
                            color: blackColor.withOpacity(0.7),
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 25),

              // === Sapaan ===
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: whiteColor,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      blurRadius: 10,
                      spreadRadius: 2,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Text(
                  "Halo, Balqis!",
                  style: whiteTextStyle.copyWith(
                    color: blackColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(height: 25),

              // === Progress TA ===
              Text(
                "Progress TA",
                style: whiteTextStyle.copyWith(
                  color: blackColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    flex: 6,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: LinearProgressIndicator(
                        value: 0.6,
                        backgroundColor: secondaryColor.withOpacity(0.2),
                        color: primaryColor,
                        minHeight: 10,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    "60%",
                    style: whiteTextStyle.copyWith(
                      color: blackColor,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 25),

              // === Pengumuman (Horizontal Scroll) ===
              Text(
                "Pengumuman",
                style: whiteTextStyle.copyWith(
                  color: blackColor,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),

              // 🔹 Horizontal Scroll Cards
              SizedBox(
                height: 160,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    _InfoCard(
                      title: "Template Laporan",
                      onPressed: () {
                        // Arahkan ke halaman template nanti
                        Get.snackbar(
                          "Template Laporan",
                          "Fitur ini sedang dikembangkan!",
                          backgroundColor: Colors.white,
                          colorText: blackColor,
                        );
                      },
                    ),
                    const SizedBox(width: 12),
                    _InfoCard(
                      title: "Jadwal Sidang",
                      onPressed: () => Get.toNamed(Routes.JADWAL),
                    ),
                    const SizedBox(width: 12),
                    _InfoCard(
                      title: "Panduan Sidang",
                      onPressed: () {},
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 25),

              // === Upcoming ===
              Text(
                "Upcoming",
                style: whiteTextStyle.copyWith(
                  color: blackColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 10),

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: whiteColor,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      blurRadius: 10,
                      spreadRadius: 2,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Selasa, 7 Oktober",
                      style: whiteTextStyle.copyWith(
                        color: blackColor,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        Icon(Icons.access_time, color: primaryColor, size: 18),
                        const SizedBox(width: 6),
                        Text(
                          "10:30",
                          style: whiteTextStyle.copyWith(color: blackColor),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text(
                      "Diskusi Perancangan, TA 10.3",
                      style: whiteTextStyle.copyWith(
                        color: blackColor,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),

      // === Bottom Navigation Bar ===
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        decoration: BoxDecoration(
          color: primaryColor,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 12,
              offset: const Offset(0, -3),
            ),
          ],
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
              onTap: () => Get.offAllNamed(Routes.DOKUMEN),
            ),
            _BottomNavItem(
              icon: Icons.person_outline,
              label: "Profile",
              onTap: () => Get.offAllNamed(Routes.PROFILE),
            ),
          ],
        ),
      ),
    );
  }
}

// === Info Card ===
class _InfoCard extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;

  const _InfoCard({required this.title, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160, // 🔹 Lebar pas untuk horizontal scroll
      margin: const EdgeInsets.only(right: 6),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.4),
            blurRadius: 8,
            spreadRadius: 2,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: whiteTextStyle.copyWith(
              color: blackColor,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
          const Spacer(),
          Align(
            alignment: Alignment.bottomRight,
            child: ElevatedButton(
              onPressed: onPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 3,
              ),
              child: Text(
                "Lihat",
                style: whiteTextStyle.copyWith(
                  color: blackColor,
                  fontSize: 12,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// === Bottom Nav Item ===
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
