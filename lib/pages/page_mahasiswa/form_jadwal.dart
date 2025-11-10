import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

// global
import 'package:inta301/shared/shared.dart';

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
  final _judulController = TextEditingController();
  final _dosenController = TextEditingController();
  final _tanggalController = TextEditingController();
  final _waktuController = TextEditingController();
  final _lokasiController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _judulController.text = "Diskusi Revisi BAB II";
    _dosenController.text = "Dr. Fitriani, M.Kom";
    _tanggalController.text = "Senin, 21 Oktober 2025";
    _waktuController.text = "09:00";
    _lokasiController.text = "Ruang B-203";
  }

  // ======================================================
  //                     MODAL TOLAK
  // ======================================================
  void _showTolakModal(BuildContext context) {
    final alasanCtrl = TextEditingController();

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
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 10),

                    TextField(
                      controller: alasanCtrl,
                      maxLines: 4,
                      decoration:
                          _fieldDecoration("Masukkan alasan penolakan..."),
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
                            backgroundColor: Colors.white,
                            colorText: Colors.black,
                            snackPosition: SnackPosition.TOP,
                            margin: const EdgeInsets.all(16),
                            borderRadius: 12,
                            icon: const Icon(Icons.info_outline, color: Colors.black),
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

  // ======================================================
  //                     BUILD UI
  // ======================================================
  @override
  Widget build(BuildContext context) {
    final bool isDosenMode = widget.mode == 'dosen';

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
        title: Text(
          isDosenMode ? "Ajuan Dosen" : "Ajukan Jadwal Bimbingan",
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontFamily: 'Poppins',
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Get.back(),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildLabeledField("Judul Bimbingan", _judulController,
                readOnly: isDosenMode),
            _buildLabeledField("Dosen Pembimbing", _dosenController,
                readOnly: isDosenMode),
            _buildTanggalField(isDosenMode),
            _buildLabeledField("Waktu (contoh: 10:30)", _waktuController,
                readOnly: isDosenMode),
            _buildLabeledField("Lokasi", _lokasiController,
                readOnly: isDosenMode),
            const SizedBox(height: 25),

            // =============================================
            //              BUTTON SECTION
            // =============================================
            if (!isDosenMode)
              _buildButtonAjukan()
            else
              _buildButtonDosen(),
          ],
        ),
      ),
    );
  }

  // ======================================================
  //               COMPONENT / WIDGET BUILDER
  // ======================================================

  Widget _buildButtonAjukan() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: dangerColor,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
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
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontFamily: 'Poppins',
          ),
        ),
      ),
    );
  }

  Widget _buildButtonDosen() {
    return Row(
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
                icon: const Icon(Icons.check_circle_outline, color: Colors.black),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
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
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
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
    );
  }

  Widget _buildLabeledField(String label, TextEditingController controller,
      {bool readOnly = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 6),
          TextFormField(
            controller: controller,
            readOnly: readOnly,
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontSize: 14,
            ),
            decoration: _fieldDecoration(""),
          ),
        ],
      ),
    );
  }

  Widget _buildTanggalField(bool isDosenMode) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Tanggal",
            style: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 6),
          GestureDetector(
            onTap: isDosenMode
                ? null
                : () async {
                    FocusScope.of(context).unfocus();

                    final pickedDate = await showDatePicker(
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
              child: TextFormField(
                controller: _tanggalController,
                decoration: _fieldDecoration("Pilih tanggal bimbingan").copyWith(
                  suffixIcon: const Icon(Icons.calendar_today_rounded,
                      color: Colors.grey),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ======================================================
  //                   DECORATION
  // ======================================================
  InputDecoration _fieldDecoration(String hint) {
    return InputDecoration(
      hintText: hint.isEmpty ? null : hint,
      hintStyle: const TextStyle(fontFamily: 'Poppins', color: Colors.black54),
      filled: true,
      fillColor: primaryColor.withOpacity(0.15),
      contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide.none,
      ),
    );
  }
}
