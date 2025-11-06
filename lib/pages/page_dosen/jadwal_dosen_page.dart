import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inta301/shared/shared.dart';
import 'package:inta301/routes/app_pages.dart';
import 'package:inta301/controllers/menu_controller.dart' as myCtrl;
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

class JadwalDosenPage extends GetView<myCtrl.MenuController> {
  const JadwalDosenPage({super.key});

  @override
  Widget build(BuildContext context) {
    controller.setPage(myCtrl.PageType.jadwal);

    // Data jadwal
    final List<Map<String, String>> jadwalList = [
      {
        "title": "Bimbingan BAB 1",
        "mahasiswa": "Putri Balqis",
        "tanggal": "Rabu, 6 November 2025",
        "waktu": "13:00",
        "lokasi": "Ruang TA 12.3",
      },
      {
        "title": "Revisi BAB 2",
        "mahasiswa": "Ahmad Rafi",
        "tanggal": "Kamis, 7 November 2025",
        "waktu": "10:00",
        "lokasi": "Zoom Meeting",
      },
      {
        "title": "Diskusi BAB 3",
        "mahasiswa": "Dini Kurnia",
        "tanggal": "Jumat, 8 November 2025",
        "waktu": "09:30",
        "lokasi": "Ruang TA 12.1",
      },
    ];

    DateTime selectedDay = DateTime.now();

    // Parsing string ke DateTime
    DateTime parseTanggal(String tgl) {
      return DateFormat('EEEE, d MMMM yyyy', 'id_ID').parse(tgl);
    }

    // Buat map event untuk kalender
    Map<DateTime, List<Map<String, String>>> events = {};
    for (var jadwal in jadwalList) {
      DateTime date = parseTanggal(jadwal["tanggal"]!);
      if (!events.containsKey(date)) events[date] = [];
      events[date]!.add(jadwal);
    }

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
          'Jadwal Bimbingan',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none, color: Colors.white),
            onPressed: () => Get.toNamed(Routes.DOSEN_NOTIFIKASI),
          ),
        ],
      ),

      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(defaultMargin),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ================= CALENDAR =================
              TableCalendar(
                locale: 'id_ID',
                focusedDay: selectedDay,
                firstDay: DateTime.utc(2020, 1, 1),
                lastDay: DateTime.utc(2030, 12, 31),
                selectedDayPredicate: (day) => isSameDay(day, selectedDay),
                onDaySelected: (day, focusedDay) {
                  selectedDay = day;
                },
                calendarStyle: const CalendarStyle(
                  todayDecoration:
                      BoxDecoration(color: primaryColor, shape: BoxShape.circle),
                  selectedDecoration:
                      BoxDecoration(color: dangerColor, shape: BoxShape.circle),
                  todayTextStyle: TextStyle(color: Colors.white),
                  selectedTextStyle: TextStyle(color: Colors.white),
                ),
                headerStyle: const HeaderStyle(
                  titleCentered: true,
                  formatButtonVisible: false,
                  titleTextStyle:
                      TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                ),
                calendarBuilders: CalendarBuilders(
                  markerBuilder: (context, date, eventsList) {
                    if (events.containsKey(date)) {
                      return Positioned(
                        bottom: 1,
                        child: Container(
                          width: 6,
                          height: 6,
                          decoration: const BoxDecoration(
                            color: primaryColor,
                            shape: BoxShape.circle,
                          ),
                        ),
                      );
                    }
                    return const SizedBox();
                  },
                ),
              ),
              const SizedBox(height: 16),

              const Text(
                "Daftar Jadwal Bimbingan",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 16),

              // ====== DAFTAR BIMBINGAN ======
              Expanded(
                child: ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  itemCount: jadwalList.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 14),
                  itemBuilder: (context, index) {
                    final jadwal = jadwalList[index];
                    return _JadwalCard(
                      title: jadwal["title"]!,
                      mahasiswa: jadwal["mahasiswa"]!,
                      tanggal: jadwal["tanggal"]!,
                      waktu: jadwal["waktu"]!,
                      lokasi: jadwal["lokasi"]!,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),

      // ====== Bottom Navigation ======
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
                isActive: controller.currentPage.value == myCtrl.PageType.home,
                onTap: () {
                  controller.setPage(myCtrl.PageType.home);
                  Get.offAllNamed(Routes.HOME_DOSEN);
                },
              ),
              _BottomNavItem(
                icon: Icons.schedule_outlined,
                label: "Jadwal",
                isActive: controller.currentPage.value == myCtrl.PageType.jadwal,
                onTap: () {
                  controller.setPage(myCtrl.PageType.jadwal);
                  Get.offAllNamed(Routes.JADWAL_DOSEN);
                },
              ),
              _BottomNavItem(
                icon: Icons.people_outline,
                label: "Mahasiswa",
                isActive: false,
                onTap: () {
                  Get.offAllNamed(Routes.MAHASISWA_DOSEN);
                },
              ),
              _BottomNavItem(
                icon: Icons.description_outlined,
                label: "Dokumen",
                isActive: controller.currentPage.value == myCtrl.PageType.dokumen,
                onTap: () {
                  controller.setPage(myCtrl.PageType.dokumen);
                  Get.offAllNamed(Routes.DOKUMEN_DOSEN);
                },
              ),
              _BottomNavItem(
                icon: Icons.person_outline,
                label: "Profil",
                isActive: controller.currentPage.value == myCtrl.PageType.profile,
                onTap: () {
                  controller.setPage(myCtrl.PageType.profile);
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

// ================= CARD JADWAL DOSEN =================
class _JadwalCard extends StatelessWidget {
  final String title;
  final String mahasiswa;
  final String tanggal;
  final String waktu;
  final String lokasi;

  const _JadwalCard({
    required this.title,
    required this.mahasiswa,
    required this.tanggal,
    required this.waktu,
    required this.lokasi,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.4),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Judul bimbingan
          Text(
            title,
            style: const TextStyle(
              color: dangerColor,
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),

          // Info mahasiswa
          Row(
            children: [
              const Icon(Icons.person_outline, size: 20, color: Colors.black),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  "Mahasiswa: $mahasiswa",
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 14.5,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),

          // Info tanggal
          Row(
            children: [
              const Icon(Icons.calendar_today_outlined, size: 18, color: Colors.black),
              const SizedBox(width: 6),
              Text(
                tanggal,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 14.5,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),

          // Info waktu
          Row(
            children: [
              const Icon(Icons.access_time, size: 18, color: Colors.black),
              const SizedBox(width: 6),
              Text(
                waktu,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 14.5,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),

          // Info lokasi
          Row(
            children: [
              const Icon(Icons.location_on_outlined, size: 18, color: Colors.black),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  lokasi,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 14.5,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ================= BottomNavItem =================
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
