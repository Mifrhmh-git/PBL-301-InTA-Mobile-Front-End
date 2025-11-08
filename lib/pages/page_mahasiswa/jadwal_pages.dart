import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

// global import
import 'package:inta301/shared/shared.dart';
import 'package:inta301/routes/app_pages.dart';

class JadwalPage extends StatefulWidget {
  final bool hasDosen; 
  const JadwalPage({super.key, this.hasDosen = true}); // default false/true

  @override
  State<JadwalPage> createState() => _JadwalPageState();
}

class _JadwalPageState extends State<JadwalPage> {
  DateTime today = DateTime.now();

  final TextEditingController _judulController = TextEditingController();
  final TextEditingController _dosenController = TextEditingController();
  final TextEditingController _tanggalController = TextEditingController();
  final TextEditingController _waktuController = TextEditingController();
  final TextEditingController _lokasiController = TextEditingController();

  void _onDaySelected(DateTime day, DateTime focusedDay) {
    setState(() {
      today = day;
    });
  }

  void _showTambahJadwalModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      builder: (context) {
        return DraggableScrollableSheet(
          expand: false,
          initialChildSize: 0.75,
          minChildSize: 0.4,
          maxChildSize: 0.95,
          builder: (context, scrollController) {
            return Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
              ),
              child: SingleChildScrollView(
                controller: scrollController,
                padding: EdgeInsets.only(
                  left: 20,
                  right: 20,
                  top: 20,
                  bottom: MediaQuery.of(context).viewInsets.bottom + 20,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Container(
                        width: 60,
                        height: 5,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Center(
                      child: Text(
                        "Ajukan Jadwal Bimbingan",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ),
                    const SizedBox(height: 25),

                    _buildLabel("Judul Bimbingan"),
                    _buildField(_judulController),
                    const SizedBox(height: 15),

                    _buildLabel("Dosen Pembimbing"),
                    _buildField(_dosenController),
                    const SizedBox(height: 15),

                    _buildLabel("Tanggal"),
                    GestureDetector(
                      onTap: () async {
                        FocusScope.of(context).unfocus();
                        DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2020),
                          lastDate: DateTime(2030),
                          locale: const Locale('id', 'ID'),
                          builder: (context, child) {
                            return Theme(
                              data: Theme.of(context).copyWith(
                                colorScheme: ColorScheme.light(
                                  primary: primaryColor,
                                  onPrimary: Colors.white,
                                  onSurface: Colors.black,
                                ),
                              ),
                              child: child!,
                            );
                          },
                        );
                        if (pickedDate != null) {
                          _tanggalController.text = DateFormat(
                            'EEEE, dd MMMM yyyy',
                            'id_ID',
                          ).format(pickedDate);
                        }
                      },
                      child: AbsorbPointer(
                        child: TextField(
                          controller: _tanggalController,
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Poppins',
                          ),
                          decoration: _fieldDecoration().copyWith(
                            suffixIcon: Icon(
                              Icons.calendar_today_outlined,
                              color: primaryColor,
                            ),
                            hintText: "Pilih tanggal bimbingan",
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide(
                                  color: primaryColor.withOpacity(0.3),
                                  width: 1),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(16)),
                              borderSide:
                                  BorderSide(color: primaryColor, width: 1.5),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),

                    _buildLabel("Waktu (contoh: 10:30)"),
                    _buildField(_waktuController),
                    const SizedBox(height: 15),

                    _buildLabel("Lokasi"),
                    _buildField(_lokasiController),
                    const SizedBox(height: 30),

                    SizedBox(
                      width: double.infinity,
                      height: 55,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: dangerColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        onPressed: () {
                          Get.back();
                          Get.snackbar(
                            "Berhasil",
                            "Jadwal bimbingan berhasil diajukan",
                            backgroundColor: Colors.white,
                            colorText: Colors.black,
                            snackPosition: SnackPosition.TOP,
                            margin: const EdgeInsets.all(16),
                            borderRadius: 12,
                          );
                        },
                        child: const Text(
                          "Ajukan",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                            fontFamily: 'Poppins',
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  InputDecoration _fieldDecoration() {
    return InputDecoration(
      filled: true,
      fillColor: primaryColor.withOpacity(0.2),
      contentPadding:
          const EdgeInsets.symmetric(vertical: 12, horizontal: 15),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide:
            BorderSide(color: primaryColor.withOpacity(0.3), width: 1),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide:
            BorderSide(color: primaryColor.withOpacity(0.3), width: 1),
      ),
      focusedBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(16)),
        borderSide: BorderSide(color: primaryColor, width: 1.5),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 14,
        fontFamily: 'Poppins',
      ),
    );
  }

  Widget _buildField(TextEditingController controller) {
    return TextField(
      controller: controller,
      style: const TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.w500,
        fontFamily: 'Poppins',
      ),
      decoration: _fieldDecoration(),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Jika belum punya dosen, tampilkan pesan tengah saja
    if (!widget.hasDosen) {
      return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text(
            "Jadwal Bimbingan",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontFamily: 'Poppins',
            ),
          ),
          centerTitle: true,
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [primaryColor, dangerColor],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
        ),
        body: const Padding(
  padding: EdgeInsets.only(top: 100),
  child: Center(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          "Belum memiliki dosen pembimbing.",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Color(0xFF616161),
            fontFamily: 'Poppins',
          ),
        ),
      ],
    ),
  ),
),
bottomNavigationBar: const _BottomNavBar(),
floatingActionButton: null, // FAB tidak muncul
);
}


    // Jika punya dosen, tampilkan jadwal
    final List<Map<String, dynamic>> jadwalList = [
      {
        "judul": "Diskusi Awal Proposal",
        "status": "Menunggu",
        "dosen": "Dr. Fitriani, M.Kom",
        "tanggal": "Senin, 21 Oktober 2025",
        "waktu": "09:00",
        "lokasi": "Ruang B-203",
      },
      {
        "judul": "Revisi Bab II",
        "status": "Diterima",
        "dosen": "Dr. Adi Nugroho",
        "tanggal": "Selasa, 22 Oktober 2025",
        "waktu": "10:30",
        "lokasi": "Lab Komputer 2",
      },
      {
        "judul": "Bimbingan Bab III",
        "status": "Ditolak",
        "dosen": "Dr. Siti Marlina",
        "tanggal": "Rabu, 23 Oktober 2025",
        "waktu": "13:00",
        "lokasi": "Ruang Dosen 1",
      },
      {
        "judul": "Ajuan Jadwal Dosen",
        "status": "Ajuan Dosen",
        "dosen": "Dr. Bambang Setiawan",
        "tanggal": "Kamis, 24 Oktober 2025",
        "waktu": "15:00",
        "lokasi": "Zoom Meeting",
        "jadwalId": 123,
      },
    ];

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          "Jadwal Bimbingan",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontFamily: 'Poppins',
          ),
        ),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [primaryColor, dangerColor],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
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
                headerStyle: const HeaderStyle(
                  formatButtonVisible: false,
                  titleCentered: true,
                  titleTextStyle: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins',
                  ),
                ),
                calendarStyle: const CalendarStyle(
                  todayDecoration: BoxDecoration(
                    color: primaryColor,
                    shape: BoxShape.circle,
                  ),
                  selectedDecoration: BoxDecoration(
                    color: primaryColor,
                    shape: BoxShape.circle,
                  ),
                  todayTextStyle: TextStyle(color: Colors.white),
                  selectedTextStyle: TextStyle(color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: jadwalList.length,
                itemBuilder: (context, index) {
                  return _buildJadwalCard(jadwalList[index]);
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: widget.hasDosen
          ? FloatingActionButton(
              backgroundColor: dangerColor,
              onPressed: () => _showTambahJadwalModal(context),
              child: const Icon(Icons.add, color: Colors.white),
            )
          : null,
      bottomNavigationBar: const _BottomNavBar(),
    );
  }

  Widget _buildJadwalCard(Map<String, dynamic> item) {
    final status = item["status"];
    Color statusColor;

    switch (status) {
      case "Diterima":
        statusColor = Colors.green;
        break;
      case "Ditolak":
        statusColor = Colors.red;
        break;
      case "Menunggu":
        statusColor = Colors.blueAccent;
        break;
      case "Ajuan Dosen":
        statusColor = Colors.orange;
        break;
      default:
        statusColor = Colors.grey;
    }

    return GestureDetector(
      onTap: status == "Ajuan Dosen"
          ? () {
              Get.toNamed(
                Routes.FORM_JADWAL,
                arguments: {"jadwalId": item["jadwalId"], "mode": "dosen"},
              );
            }
          : null,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.25),
              blurRadius: 8,
              spreadRadius: 2,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              item["judul"],
              style: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w800,
                color: dangerColor,
                fontFamily: 'Poppins',
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "Dosen: ${item["dosen"]}",
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black,
                fontWeight: FontWeight.w600,
                fontFamily: 'Poppins',
              ),
            ),
            Text(
              "Tanggal: ${item["tanggal"]}",
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black,
                fontWeight: FontWeight.w600,
                fontFamily: 'Poppins',
              ),
            ),
            Text(
              "Waktu: ${item["waktu"]}",
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black,
                fontWeight: FontWeight.w600,
                fontFamily: 'Poppins',
              ),
            ),
            Text(
              "Lokasi: ${item["lokasi"]}",
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black,
                fontWeight: FontWeight.w600,
                fontFamily: 'Poppins',
              ),
            ),
            const SizedBox(height: 10),
            Align(
              alignment: Alignment.centerRight,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: statusColor.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  status,
                  style: TextStyle(
                    color: statusColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                    fontFamily: 'Poppins',
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BottomNavBar extends StatefulWidget {
  const _BottomNavBar();

  @override
  State<_BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<_BottomNavBar> {
  String currentPage = Routes.JADWAL;

  void _onTap(String route) {
    if (route == currentPage) return;
    setState(() {
      currentPage = route;
    });

    // Kirim hasDosen ke halaman Jadwal
    if (route == Routes.JADWAL) {
      final bool hasDosen = false; // <--- ambil dari user data sebenarnya
      Get.offAllNamed(route, arguments: hasDosen);
    } else {
      Get.offAllNamed(route);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
            isActive: currentPage == Routes.HOME,
            onTap: () => _onTap(Routes.HOME),
          ),
          _BottomNavItem(
            icon: Icons.calendar_month,
            label: "Jadwal",
            isActive: currentPage == Routes.JADWAL,
            onTap: () => _onTap(Routes.JADWAL),
          ),
          _BottomNavItem(
            icon: Icons.bar_chart_outlined,
            label: "Kanban",
            isActive: currentPage == Routes.KANBAN,
            onTap: () => _onTap(Routes.KANBAN),
          ),
          _BottomNavItem(
            icon: Icons.description_outlined,
            label: "Dokumen",
            isActive: currentPage == Routes.DOKUMEN,
            onTap: () => _onTap(Routes.DOKUMEN),
          ),
          _BottomNavItem(
            icon: Icons.person_outline,
            label: "Profil",
            isActive: currentPage == Routes.PROFILE,
            onTap: () => _onTap(Routes.PROFILE),
          ),
        ],
      ),
    );
  }
}

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
              fontFamily: 'Poppins',
            ),
          ),
        ],
      ),
    );
  }
}
