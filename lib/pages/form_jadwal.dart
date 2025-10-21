import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../shared/shared.dart';

class FormJadwalBimbinganPage extends StatefulWidget {
  final int jadwalId;
  final String mode; // 'mahasiswa' atau 'dosen'

  const FormJadwalBimbinganPage({
    super.key,
    required this.jadwalId,
    required this.mode,
  });

  @override
  State<FormJadwalBimbinganPage> createState() =>
      _FormJadwalBimbinganPageState();
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

    // === Contoh data ajuan dosen ===
    _judulController.text = "Diskusi Revisi BAB II";
    _dosenController.text = "Dr. Dosen Pembimbing";
    _tanggalController.text = "Rabu, 23 Oktober 2025";
    _waktuController.text = "10:00";
    _lokasiController.text = "Ruang B.203";
  }

  @override
  Widget build(BuildContext context) {
    final bool isDosenMode = widget.mode == 'dosen';

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          isDosenMode ? "Ajuan Dosen" : "Ajukan Jadwal Bimbingan",
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: primaryColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Get.back(),
        ),
      ),

      // === BODY ===
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            _buildTextField(
              "Judul Bimbingan",
              _judulController,
              readOnly: isDosenMode,
            ),
            _buildTextField(
              "Dosen Pembimbing",
              _dosenController,
              readOnly: isDosenMode,
            ),

            // === Tanggal ===
            GestureDetector(
              onTap: isDosenMode
                  ? null
                  : () async {
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
                            DateFormat('EEEE, dd MMMM yyyy', 'id_ID')
                                .format(pickedDate);
                      }
                    },
              child: AbsorbPointer(
                absorbing: isDosenMode,
                child: _buildTextField("Tanggal", _tanggalController),
              ),
            ),

            _buildTextField(
              "Waktu (contoh: 10:30)",
              _waktuController,
              readOnly: isDosenMode,
            ),
            _buildTextField(
              "Lokasi",
              _lokasiController,
              readOnly: isDosenMode,
            ),

            const SizedBox(height: 25),

            // === TOMBOL AKSI ===
            if (!isDosenMode)
              // === MODE MAHASISWA ===
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 3,
                  ),
                  onPressed: () {
                    FocusScope.of(context).unfocus();
                    Get.back();
                    Get.snackbar(
                      "Berhasil",
                      "Jadwal bimbingan telah diajukan ke dosen",
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
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              )
            else
              // === MODE DOSEN ===
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        FocusScope.of(context).unfocus();
                        Get.snackbar(
                          "Diterima",
                          "Jadwal diterima mahasiswa",
                          backgroundColor: Colors.green,
                          colorText: Colors.white,
                          snackPosition: SnackPosition.TOP,
                          margin: const EdgeInsets.all(16),
                          borderRadius: 12,
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        "Terima",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        final TextEditingController alasanCtrl =
                            TextEditingController();
                        Get.defaultDialog(
                          title: "Tolak Jadwal",
                          titleStyle: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                          contentPadding: const EdgeInsets.all(16),
                          content: TextField(
                            controller: alasanCtrl,
                            maxLines: 3,
                            decoration: const InputDecoration(
                              hintText: "Masukkan alasan penolakan...",
                              border: OutlineInputBorder(),
                            ),
                          ),
                          textConfirm: "Kirim",
                          confirmTextColor: Colors.white,
                          buttonColor: primaryColor,
                          onConfirm: () {
                            Get.back();
                            Get.snackbar(
                              "Ditolak",
                              "Jadwal ditolak dan dikirim ke dosen",
                              backgroundColor: Colors.red,
                              colorText: Colors.white,
                              snackPosition: SnackPosition.TOP,
                              margin: const EdgeInsets.all(16),
                              borderRadius: 12,
                            );
                          },
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        "Tolak",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller,
      {bool readOnly = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18),
      child: TextFormField(
        controller: controller,
        readOnly: readOnly,
        decoration: InputDecoration(
          labelText: label,
          filled: true,
          fillColor: primaryColor.withOpacity(0.1),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 14, horizontal: 15),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
