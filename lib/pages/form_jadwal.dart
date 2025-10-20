import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../shared/shared.dart'; 

class FormJadwalBimbinganPage extends StatefulWidget {
  final int jadwalId;

  const FormJadwalBimbinganPage({super.key, required this.jadwalId});

  @override
  State<FormJadwalBimbinganPage> createState() => _FormJadwalBimbinganPageState();
}

class _FormJadwalBimbinganPageState extends State<FormJadwalBimbinganPage> {
  final TextEditingController _judulController = TextEditingController();
  final TextEditingController _dosenController = TextEditingController();
  final TextEditingController _tanggalController = TextEditingController();
  final TextEditingController _waktuController = TextEditingController();
  final TextEditingController _lokasiController = TextEditingController();

  @override
  void initState() {
    super.initState();
  
    _judulController.text = "Diskusi TA #${widget.jadwalId}";
    _dosenController.text = "Dosen Pembimbing";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Jadwal Bimbingan #${widget.jadwalId}"),
        backgroundColor: primaryColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Get.back(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
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
                  setState(() {
                    _tanggalController.text =
                        DateFormat('EEEE, dd MMMM yyyy', 'id_ID').format(pickedDate);
                  });
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
            const SizedBox(height: 25),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 4,
                ),
                onPressed: () {
                  Get.back();
                  Get.snackbar(
                    "Berhasil",
                    "Jadwal bimbingan telah disimpan",
                    backgroundColor: primaryColor,
                    colorText: Colors.white,
                    snackPosition: SnackPosition.TOP,
                    margin: const EdgeInsets.all(16),
                    borderRadius: 12,
                  );
                },
                child: const Text(
                  "Simpan",
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label, IconData icon, TextEditingController controller) {
    return TextField(
      controller: controller,
      style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: primaryColor),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade400, width: 1.3),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: primaryColor, width: 2),
        ),
      ),
    );
  }
}
