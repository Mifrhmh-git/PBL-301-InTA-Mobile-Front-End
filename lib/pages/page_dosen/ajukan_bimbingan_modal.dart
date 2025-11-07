import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inta301/shared/shared.dart';
import 'package:intl/intl.dart';

void showAjukanBimbinganModal({
  required BuildContext context,
  Function(String judul, String dosen, String tanggal, String waktu, String lokasi)? onSubmit,
}) {
  final TextEditingController judulCtrl = TextEditingController();
  final TextEditingController dosenCtrl = TextEditingController();
  final TextEditingController tanggalCtrl = TextEditingController();
  final TextEditingController waktuCtrl = TextEditingController();
  final TextEditingController lokasiCtrl = TextEditingController();

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
        initialChildSize: 0.85, // tinggi supaya tombol terlihat
        minChildSize: 0.5,
        maxChildSize: 0.95,
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
              physics: const ClampingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Handle kecil atas modal
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
                  // Judul modal
                  const Center(
                    child: Text(
                      "Ajukan Bimbingan",
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ),
                  const SizedBox(height: 25),
                  // Field
                  _buildField("Judul Bimbingan", judulCtrl),
                  _buildField("Dosen Pembimbing", dosenCtrl),
                  _buildTanggalField(context, tanggalCtrl),
                  _buildField("Waktu (contoh: 10:30)", waktuCtrl),
                  _buildField("Lokasi", lokasiCtrl),
                  const SizedBox(height: 25),
                  // Tombol Ajukan (warna dangerColor)
                 SizedBox(
  width: double.infinity, // sama lebar dengan field
  height: 52, // tinggi sama seperti field
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
      backgroundColor: dangerColor, // warna tombol
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16), // sama dengan field
      ),
      elevation: 0, // optional, bisa disesuaikan
    ),
    child: const Text(
      "Ajukan",
      style: TextStyle(
        color: Colors.white,
        fontSize: 16, // sama proporsinya dengan teks di field
        fontWeight: FontWeight.w600,
        fontFamily: 'Poppins',
      ),
    ),
  ),
),

                  const SizedBox(height: 10),
                ],
              ),
            ),
          );
        },
      );
    },
  );
}

Widget _buildField(String label, TextEditingController ctrl) {
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
          decoration: InputDecoration(
            filled: true,
            fillColor: primaryColor.withOpacity(0.2), // warna field sama seperti modal Kanban
            contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(
                color: primaryColor.withOpacity(0.3),
                width: 1,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(
                color: primaryColor.withOpacity(0.3),
                width: 1,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(
                color: primaryColor,
                width: 1.5,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildTanggalField(BuildContext context, TextEditingController ctrl) {
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
          onTap: () async {
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
            child: TextFormField(
              controller: ctrl,
              decoration: InputDecoration(
                filled: true,
                fillColor: primaryColor.withOpacity(0.2), // warna sama seperti modal Kanban
                contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(
                    color: primaryColor.withOpacity(0.3),
                    width: 1,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(
                    color: primaryColor.withOpacity(0.3),
                    width: 1,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: const BorderSide(
                    color: primaryColor,
                    width: 1.5,
                  ),
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
