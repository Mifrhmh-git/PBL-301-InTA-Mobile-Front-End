import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inta301/shared/shared.dart';
import 'package:inta301/routes/app_pages.dart';
import 'package:inta301/controllers/menu_dosen_controller.dart' as myCtrl;
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import 'jadwal_card_dosen_page.dart';

class JadwalDosenPage extends StatefulWidget {
  const JadwalDosenPage({super.key});

  @override
  State<JadwalDosenPage> createState() => _JadwalDosenPageState();
}

class _JadwalDosenPageState extends State<JadwalDosenPage> {
  // gunakan controller Dosen
  late final myCtrl.MenuDosenController controller;

  DateTime focusedDay = DateTime.now();
  DateTime? selectedDay;

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

  DateTime parseTanggal(String tgl) {
    return DateFormat('EEEE, d MMMM yyyy', 'id_ID').parse(tgl);
  }

  @override
  void initState() {
    super.initState();

    // ambil controller
    controller = Get.find<myCtrl.MenuDosenController>();

    // panggil setelah build selesai
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.setPage(myCtrl.PageTypeDosen.jadwal);
    });
  }

  @override
  Widget build(BuildContext context) {
    Map<DateTime, List<Map<String, String>>> events = {};
    for (var jadwal in jadwalList) {
      DateTime date = parseTanggal(jadwal["tanggal"]!);
      if (!events.containsKey(date)) events[date] = [];
      events[date]!.add(jadwal);
    }

    List<Map<String, String>> jadwalHariIni = jadwalList;

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
            fontSize: 20,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),

      // ===== BODY =====
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(defaultMargin),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ========== CALENDAR ==========
              TableCalendar(
                locale: 'id_ID',
                focusedDay: focusedDay,
                firstDay: DateTime.utc(2020, 1, 1),
                lastDay: DateTime.utc(2030, 12, 31),
                selectedDayPredicate: (day) => isSameDay(day, selectedDay),
                onDaySelected: (selected, focused) {
                  setState(() {
                    selectedDay = selected;
                    focusedDay = focused;
                  });
                },
                calendarStyle: const CalendarStyle(
                  todayDecoration: BoxDecoration(
                      color: primaryColor, shape: BoxShape.circle),
                  selectedDecoration: BoxDecoration(
                      color: dangerColor, shape: BoxShape.circle),
                  todayTextStyle: TextStyle(color: Colors.white),
                  selectedTextStyle: TextStyle(color: Colors.white),
                ),
                headerStyle: const HeaderStyle(
                  titleCentered: true,
                  formatButtonVisible: false,
                  titleTextStyle: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.black),
                ),
                calendarBuilders: CalendarBuilders(
                  markerBuilder: (context, date, _) {
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

              // ========== DAFTAR JADWAL ==========
              Expanded(
                child: jadwalHariIni.isEmpty
                    ? const Center(
                        child: Text(
                          "Tidak ada jadwal untuk tanggal ini.",
                          style: TextStyle(color: Colors.grey),
                        ),
                      )
                    : ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemCount: jadwalHariIni.length,
                        itemBuilder: (context, index) {
                          final jadwal = jadwalHariIni[index];
                          return JadwalCard(
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

      // ===== BOTTOM NAVIGATION =====
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
                isActive:
                    controller.currentPage.value == myCtrl.PageTypeDosen.home,
                onTap: () {
                  controller.setPage(myCtrl.PageTypeDosen.home);
                  Get.offAllNamed(Routes.HOME_DOSEN);
                },
              ),
              _BottomNavItem(
                icon: Icons.schedule_outlined,
                label: "Jadwal",
                isActive:
                    controller.currentPage.value == myCtrl.PageTypeDosen.jadwal,
                onTap: () {
                  controller.setPage(myCtrl.PageTypeDosen.jadwal);
                  Get.offAllNamed(Routes.JADWAL_DOSEN);
                },
              ),
              _BottomNavItem(
                icon: Icons.school_outlined,
                label: "Bimbingan",
                isActive: controller.currentPage.value ==
                    myCtrl.PageTypeDosen.bimbingan,
                onTap: () {
                  controller.setPage(myCtrl.PageTypeDosen.bimbingan);
                  Get.offAllNamed(Routes.BIMBINGAN_DOSEN);
                },
              ),
              _BottomNavItem(
                icon: Icons.description_outlined,
                label: "Dokumen",
                isActive: controller.currentPage.value ==
                    myCtrl.PageTypeDosen.dokumen,
                onTap: () {
                  controller.setPage(myCtrl.PageTypeDosen.dokumen);
                  Get.offAllNamed(Routes.DOKUMEN_DOSEN);
                },
              ),
              _BottomNavItem(
                icon: Icons.person_outline,
                label: "Profil",
                isActive: controller.currentPage.value ==
                    myCtrl.PageTypeDosen.profile,
                onTap: () {
                  controller.setPage(myCtrl.PageTypeDosen.profile);
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

// ========== Bottom Navigation Item ==========
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
