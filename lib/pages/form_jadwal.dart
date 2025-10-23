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

    _judulController.text = "Diskusi Revisi BAB II";
    _dosenController.text = "Dr. Dosen Pembimbing";
    _tanggalController.text = "Rabu, 23 Oktober 2025";
    _waktuController.text = "10:00";
    _lokasiController.text = "Ruang B.203";
  }

  void _showTolakModal(BuildContext context) {
    final TextEditingController alasanCtrl = TextEditingController();

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
          initialChildSize: 0.55,
          minChildSize: 0.4,
          maxChildSize: 0.8,
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
                    const SizedBox(height: 18),
                    const Center(
                      child: Text(
                        "Alasan Penolakan Jadwal",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ),
                    const SizedBox(height: 25),
                    const Text(
                      "Tuliskan alasan Anda menolak jadwal ini:",
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 14,
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: alasanCtrl,
                      maxLines: 4,
                      decoration: InputDecoration(
                        hintText: "Masukkan alasan penolakan...",
                        hintStyle: const TextStyle(
                          fontFamily: 'Poppins',
                          color: Colors.black54,
                        ),
                        filled: true,
                        fillColor: primaryColor.withOpacity(0.2),
                        contentPadding: const EdgeInsets.all(14),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                    const SizedBox(height: 25),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryColor,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: () {
                          Get.back();
                          Get.snackbar(
                            "Ditolak",
                            "Jadwal ditolak dan dikirim ke mahasiswa",
                            backgroundColor: Colors.white, // 🔹 putih
                            colorText: Colors.black, // 🔹 tulisan hitam
                            snackPosition: SnackPosition.TOP,
                            margin: const EdgeInsets.all(16),
                            borderRadius: 12,
                            icon: const Icon(
                              Icons.info_outline,
                              color: Colors.black,
                            ),
                          );
                        },
                        child: const Text(
                          "Kirim Penolakan",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontFamily: 'Poppins',
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        );
      },
    );
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
            fontFamily: 'Poppins',
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            _buildTextField("Judul Bimbingan", _judulController,
                readOnly: isDosenMode),
            _buildTextField("Dosen Pembimbing", _dosenController,
                readOnly: isDosenMode),
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
            _buildTextField("Waktu (contoh: 10:30)", _waktuController,
                readOnly: isDosenMode),
            _buildTextField("Lokasi", _lokasiController,
                readOnly: isDosenMode),
            const SizedBox(height: 25),
            if (!isDosenMode)
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
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
                      fontFamily: 'Poppins',
                    ),
                  ),
                ),
              )
            else
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Get.snackbar(
                          "Diterima",
                          "Jadwal diterima mahasiswa",
                          backgroundColor: Colors.white,
                          colorText: Colors.black,
                          snackPosition: SnackPosition.TOP,
                          margin: const EdgeInsets.all(16),
                          borderRadius: 12,
                          icon: const Icon(
                            Icons.check_circle_outline,
                            color: Colors.black,
                          ),
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
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => _showTolakModal(context),
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
                          fontFamily: 'Poppins',
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
          labelStyle: const TextStyle(fontFamily: 'Poppins'),
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
