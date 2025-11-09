import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inta301/shared/shared.dart';
import 'package:inta301/routes/app_pages.dart';
import 'package:inta301/pages/page_mahasiswa/logout_mahasiswa_modal.dart';

class ProfilePage extends StatelessWidget {
  final bool hasDosen;
  ProfilePage({super.key, required this.hasDosen});

  final RxInt selectedIndex = 4.obs;
  final RxBool pushNotification = true.obs; // nilai switch

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: const Text(
          "Profile",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),

      body: Column(
        children: [
          // HEADER
          Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [primaryColor, dangerColor],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 100, bottom: 25),
              child: Column(
                children: [
                  const CircleAvatar(
                    radius: 45,
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.person,
                      color: primaryColor,
                      size: 60,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Putri Balqis",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    "Mahasiswa",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 25),

          // MENU LIST
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              children: [
                // === PUSH NOTIFICATION (DENGAN SWITCH) ===
                Obx(
                  () => _ProfileMenuItem(
                    icon: Icons.notifications_active,
                    label: "Push Notifications",
                    trailing: Switch(
                      value: pushNotification.value,
                      onChanged: (val) => pushNotification.value = val,

                      // WARNA SWITCH (sesuai gambar)
                      thumbColor: WidgetStateProperty.all(primaryColor),
                      trackColor: WidgetStateProperty.all(
                        primaryColor.withOpacity(0.35),
                      ),
                    ),
                    onTap: () {},
                  ),
                ),
                const SizedBox(height: 20),

                // === KELOLA AKUN ===
                _ProfileMenuItem(
                  icon: Icons.manage_accounts,
                  label: "Kelola Akun",
                  onTap: () => Get.toNamed(Routes.KELOLA_AKUN),
                ),
                const SizedBox(height: 20),

                // === DINAMIS SESUAI DOSEN ===
                hasDosen
                    ? _ProfileMenuItem(
                        icon: Icons.person_search,
                        label: "Informasi Dosen Pembimbing",
                        onTap: () => Get.toNamed(Routes.INFORMASI_DOSPEM),
                      )
                    : _ProfileMenuItem(
                        icon: Icons.search,
                        label: "Cari Dosen Pembimbing",
                        onTap: () => Get.toNamed(Routes.PILIH_DOSEN),
                      ),

                const SizedBox(height: 20),

                // === LOGOUT ===
                _ProfileMenuItem(
                  icon: Icons.logout,
                  label: "Keluar",
                  onTap: () => showLogoutMahasiswaModal(context),
                ),
              ],
            ),
          ),
        ],
      ),

      // === BOTTOM NAV ===
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
                onTap: () {
                  selectedIndex.value = 0;
                  Get.offAllNamed(Routes.HOME);
                },
              ),
              _BottomNavItem(
                icon: Icons.calendar_month,
                label: "Jadwal",
                isActive: selectedIndex.value == 1,
                onTap: () {
                  selectedIndex.value = 1;
                  Get.offAllNamed(Routes.JADWAL);
                },
              ),
              _BottomNavItem(
                icon: Icons.bar_chart_outlined,
                label: "Kanban",
                isActive: selectedIndex.value == 2,
                onTap: () {
                  selectedIndex.value = 2;
                  Get.offAllNamed(Routes.KANBAN);
                },
              ),
              _BottomNavItem(
                icon: Icons.description_outlined,
                label: "Dokumen",
                isActive: selectedIndex.value == 3,
                onTap: () {
                  selectedIndex.value = 3;
                  Get.offAllNamed(Routes.DOKUMEN);
                },
              ),
              _BottomNavItem(
                icon: Icons.person_outline,
                label: "Profile",
                isActive: selectedIndex.value == 4,
                onTap: () => selectedIndex.value = 4,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ===================================================================
//                           MENU ITEM
// ===================================================================
class _ProfileMenuItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final Widget? trailing;

  const _ProfileMenuItem({
    required this.icon,
    required this.label,
    required this.onTap,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(15),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              blurRadius: 10,
              spreadRadius: 2,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundColor: primaryColor.withOpacity(0.9),
              child: Icon(icon, color: Colors.white, size: 22),
            ),
            const SizedBox(width: 15),

            Expanded(
              child: Text(
                label,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: blackColor,
                ),
              ),
            ),

            if (trailing != null) trailing!,
          ],
        ),
      ),
    );
  }
}

// ===================================================================
//                           BOTTOM NAV ITEM
// ===================================================================
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
