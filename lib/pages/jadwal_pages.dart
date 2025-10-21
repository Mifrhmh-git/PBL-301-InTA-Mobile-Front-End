import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import '../shared/shared.dart';
import '../routes/app_pages.dart';

class JadwalPage extends StatefulWidget {
  const JadwalPage({super.key});

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

  // === MODAL TAMBAH JADWAL ===
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
                    Center(
                      child: Text(
                        "Ajukan Jadwal Bimbingan",
                        style: TextStyle(
                          color: primaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ),
                    const SizedBox(height: 25),

                    _buildTextField("Judul Bimbingan", Icons.edit_outlined, _judulController),
                    const SizedBox(height: 15),
                    _buildTextField("Dosen Pembimbing", Icons.person_outline, _dosenController),
                    const SizedBox(height: 15),

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
                          _tanggalController.text =
                              DateFormat('EEEE, dd MMMM yyyy', 'id_ID').format(pickedDate);
                        }
                      },
                      child: AbsorbPointer(
                        child: _buildTextField("Tanggal", Icons.calendar_today_outlined, _tanggalController),
                      ),
                    ),
                    const SizedBox(height: 15),

                    _buildTextField("Waktu (contoh: 10:30)", Icons.access_time, _waktuController),
                    const SizedBox(height: 15),
                    _buildTextField("Lokasi", Icons.location_on_outlined, _lokasiController),
                    const SizedBox(height: 30),

                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryColor,
                          padding: const EdgeInsets.symmetric(vertical: 18),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
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
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
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

  Widget _buildTextField(String label, IconData icon, TextEditingController controller) {
    return TextField(
      controller: controller,
      style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w500, fontFamily: 'Poppins'),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(fontFamily: 'Poppins'),
        prefixIcon: Icon(icon, color: primaryColor),
        filled: true,
        fillColor: primaryColor.withOpacity(0.08),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: primaryColor.withOpacity(0.3), width: 1.3),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: primaryColor, width: 2),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
      floatingActionButton: FloatingActionButton(
        backgroundColor: primaryColor,
        onPressed: () => _showTambahJadwalModal(context),
        child: const Icon(Icons.add, color: Colors.white),
      ),
      bottomNavigationBar: _BottomNavBar(),
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
              Get.toNamed(Routes.FORM_JADWAL,
                  arguments: {"jadwalId": item["jadwalId"], "mode": "dosen"});
            }
          : null,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: statusColor.withOpacity(0.8), width: 1.8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(item["judul"],
                style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                    fontFamily: 'Poppins')),
            const SizedBox(height: 8),
            Text("Dosen: ${item["dosen"]}",
                style: const TextStyle(fontSize: 13.5, color: Colors.black87, fontFamily: 'Poppins')),
            Text("Tanggal: ${item["tanggal"]}",
                style: const TextStyle(fontSize: 13.5, color: Colors.black87, fontFamily: 'Poppins')),
            Text("Waktu: ${item["waktu"]}",
                style: const TextStyle(fontSize: 13.5, color: Colors.black87, fontFamily: 'Poppins')),
            Text("Lokasi: ${item["lokasi"]}",
                style: const TextStyle(fontSize: 13.5, color: Colors.black87, fontFamily: 'Poppins')),
            const SizedBox(height: 10),
            Align(
              alignment: Alignment.centerRight,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: statusColor.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  status,
                  style: TextStyle(
                      color: statusColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                      fontFamily: 'Poppins'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BottomNavBar extends StatelessWidget {
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
          _BottomNavItem(icon: Icons.home, label: "Beranda", onTap: () => Get.offAllNamed(Routes.HOME)),
          _BottomNavItem(icon: Icons.calendar_month, label: "Jadwal", onTap: () => Get.offAllNamed(Routes.JADWAL)),
          _BottomNavItem(icon: Icons.bar_chart_outlined, label: "Kanban", onTap: () => Get.offAllNamed(Routes.KANBAN)),
          _BottomNavItem(icon: Icons.description_outlined, label: "Dokumen", onTap: () => Get.offAllNamed(Routes.DOKUMEN)),
          _BottomNavItem(icon: Icons.person_outline, label: "Profile", onTap: () => Get.offAllNamed(Routes.PROFILE)),
        ],
      ),
    );
  }
}

class _BottomNavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _BottomNavItem({required this.icon, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: Colors.white, size: 26),
          const SizedBox(height: 4),
          Text(label,
              style: const TextStyle(
                  color: Colors.white, fontSize: 12, fontFamily: 'Poppins')),
        ],
      ),
    );
  }
}
