import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';
import '../shared/shared.dart';
import 'package:intl/intl.dart';
import '../routes/app_pages.dart';

class JadwalPage extends StatefulWidget {
  const JadwalPage({super.key});

  @override
  State<JadwalPage> createState() => _JadwalPageState();
}

class _JadwalPageState extends State<JadwalPage> {
  DateTime today = DateTime.now();

  void _onDaySelected(DateTime day, DateTime focusedDay) {
    setState(() {
      today = day;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: const Text(
          'Jadwal Bimbingan',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // === Kalender ===
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 6,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: TableCalendar(
                locale: 'id_ID',
                rowHeight: 45,
                focusedDay: today,
                firstDay: DateTime.utc(2020, 1, 1),
                lastDay: DateTime.utc(2030, 12, 31),
                selectedDayPredicate: (day) => isSameDay(day, today),
                onDaySelected: _onDaySelected,
                headerStyle: HeaderStyle(
                  formatButtonVisible: false,
                  titleCentered: true,
                  titleTextStyle: TextStyle(
                    color: primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                  leftChevronIcon:
                      Icon(Icons.chevron_left, color: primaryColor),
                  rightChevronIcon:
                      Icon(Icons.chevron_right, color: primaryColor),
                ),
                calendarStyle: CalendarStyle(
                  todayDecoration: BoxDecoration(
                    color: primaryColor.withOpacity(0.3),
                    shape: BoxShape.circle,
                  ),
                  selectedDecoration: BoxDecoration(
                    color: primaryColor,
                    shape: BoxShape.circle,
                  ),
                  weekendTextStyle: TextStyle(color: primaryColor),
                  defaultTextStyle: const TextStyle(color: Colors.black),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // === Kartu Jadwal ===
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.25),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 🗓️ Tanggal - warna hitam
                  Text(
                    DateFormat("EEEE, d MMMM", "id_ID").format(today),
                    style: whiteTextStyle.copyWith(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),

                  // 📅 Item jadwal
                  _buildJadwalItem(
                    time: "10:30",
                    title: "Diskusi Perancangan, TA 10.3",
                  ),
                  _buildJadwalItem(
                    time: "13:30",
                    title: "Ajuan Diskusi BAB I, TA 10.3",
                  ),
                ],
              ),
            ),
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: primaryColor,
        child: const Icon(Icons.add, color: Colors.white),
      ),

      // ✅ Bottom Navigation Bar seragam di semua halaman
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

  Widget _buildJadwalItem({required String time, required String title}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Text(
            time,
            style: whiteTextStyle.copyWith(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              title,
              style: whiteTextStyle.copyWith(color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}

// ✅ Komponen bottom nav item (dipakai semua halaman)
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
