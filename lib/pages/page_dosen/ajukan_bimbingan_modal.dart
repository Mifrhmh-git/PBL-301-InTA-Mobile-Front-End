import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inta301/shared/shared.dart';
import 'package:intl/intl.dart';

void showAjukanBimbinganModal({
  required BuildContext context,
  required String mode, // 'mahasiswa' atau 'dosen'
  required String mahasiswaNama, // opsional, untuk dosen ajukan ke mahasiswa
  Function(String judul, String dosen, String tanggal, String waktu, String lokasi)? onSubmit,
}) {
  final TextEditingController judulCtrl = TextEditingController();
  final TextEditingController dosenCtrl = TextEditingController();
  final TextEditingController tanggalCtrl = TextEditingController();
  final TextEditingController waktuCtrl = TextEditingController();
  final TextEditingController lokasiCtrl = TextEditingController();

  bool isDosenMode = mode == 'dosen';

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
        initialChildSize: 0.65,
        minChildSize: 0.4,
        maxChildSize: 0.9,
        builder: (context, scrollController) {
          return Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
            ),
            padding: EdgeInsets.only(
              left: 20,
              right: 20,
              top: 20,
              bottom: MediaQuery.of(context).viewInsets.bottom + 20,
            ),
            child: SingleChildScrollView(
              controller: scrollController,
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
                  Center(
                    child: Text(
                      isDosenMode
                          ? "Ajukan Bimbingan ke $mahasiswaNama"
                          : "Ajukan Bimbingan",
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ),
                  const SizedBox(height: 25),
                  _buildField("Judul Bimbingan", judulCtrl, readOnly: false),
                  _buildField("Dosen Pembimbing", dosenCtrl, readOnly: isDosenMode),
                  _buildTanggalField(context, tanggalCtrl, isDosenMode),
                  _buildField("Waktu (contoh: 10:30)", waktuCtrl, readOnly: false),
                  _buildField("Lokasi", lokasiCtrl, readOnly: false),
                  const SizedBox(height: 25),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        if (onSubmit != null) {
                          onSubmit(
                            judulCtrl.text,
                            dosenCtrl.text,
                            tanggalCtrl.text,
                            waktuCtrl.text,
                            lokasiCtrl.text,
                          );
                        }
                        Get.back();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        isDosenMode ? "Ajukan ke Mahasiswa" : "Ajukan",
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
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

Widget _buildField(String label, TextEditingController ctrl, {bool readOnly = false}) {
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
          controller: ctrl,
          readOnly: readOnly,
          decoration: InputDecoration(
            filled: true,
            fillColor: primaryColor.withOpacity(0.15),
            contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildTanggalField(BuildContext context, TextEditingController ctrl, bool readOnly) {
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
          onTap: readOnly
              ? null
              : () async {
                  FocusScope.of(context).unfocus();
                  DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2020),
                    lastDate: DateTime(2030),
                    locale: const Locale('id', 'ID'),
                  );
                  if (picked != null) {
                    ctrl.text = DateFormat('EEEE, dd MMMM yyyy', 'id_ID').format(picked);
                  }
                },
          child: AbsorbPointer(
            absorbing: readOnly,
            child: TextFormField(
              controller: ctrl,
              decoration: InputDecoration(
                filled: true,
                fillColor: primaryColor.withOpacity(0.15),
                contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
                suffixIcon: const Icon(Icons.calendar_today_rounded, color: Colors.grey),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
