import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:inta301/shared/shared.dart';

class FormAjuanBimbinganPage extends StatelessWidget {
  const FormAjuanBimbinganPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController judulController = TextEditingController();
    final TextEditingController dosenController = TextEditingController();
    final TextEditingController tanggalController = TextEditingController();
    final TextEditingController waktuController = TextEditingController();
    final TextEditingController lokasiController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Detail Ajuan Bimbingan",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontFamily: 'Poppins',
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
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

      backgroundColor: backgroundColor,

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(defaultMargin),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildField(
              "Judul Bimbingan",
              judulController,
            ),
            _buildField(
              "Dosen Pembimbing",
              dosenController,
            ),
            _buildDateField(
              context,
              "Tanggal",
              tanggalController,
            ),
            _buildField(
              "Waktu",
              waktuController,
              hintText: "contoh: 10.00 - 11.00",
            ),
            _buildField(
              "Lokasi",
              lokasiController,
              hintText: "contoh: Ruang Dosen A",
            ),

            const SizedBox(height: 30),

            // 🔹 Tombol Setuju & Tolak
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Get.snackbar(
                        "Disetujui",
                        "Ajuan bimbingan berhasil disetujui.",
                        backgroundColor: Colors.white, // putih
                        colorText: Colors.black, // hitam tegas
                        snackPosition: SnackPosition.TOP, // di atas
                        margin: const EdgeInsets.all(10),
                        borderRadius: 10,
                        boxShadows: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            blurRadius: 5,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 3,
                    ),
                    child: const Text(
                      "Setuju",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins',
                        fontSize: 14,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: 10),

                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Get.snackbar(
                        "Ditolak",
                        "Ajuan bimbingan berhasil ditolak.",
                        backgroundColor: Colors.white, // putih
                        colorText: Colors.black, // hitam tegas
                        snackPosition: SnackPosition.TOP, // di atas
                        margin: const EdgeInsets.all(10),
                        borderRadius: 10,
                        boxShadows: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            blurRadius: 5,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 3,
                    ),
                    child: const Text(
                      "Tolak",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins',
                        fontSize: 14,
                        color: Colors.white,
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

  // 🔹 Field umum
  Widget _buildField(
    String label,
    TextEditingController controller, {
    String? hintText,
  }) {
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
              fontSize: 13.5,
            ),
          ),
          const SizedBox(height: 6),
          TextField(
            controller: controller,
            decoration: InputDecoration(
              hintText: hintText,
              filled: true,
              fillColor: primaryColor.withOpacity(0.08),
              contentPadding: const EdgeInsets.symmetric(
                vertical: 12,
                horizontal: 14,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  color: primaryColor.withOpacity(0.4),
                  width: 1,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  color: primaryColor.withOpacity(0.3),
                  width: 1,
                ),
              ),
              focusedBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                borderSide: BorderSide(
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

  // 🔹 Field tanggal
  Widget _buildDateField(
    BuildContext context,
    String label,
    TextEditingController controller,
  ) {
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
              fontSize: 13.5,
            ),
          ),
          const SizedBox(height: 6),
          TextField(
            controller: controller,
            readOnly: true,
            onTap: () async {
              DateTime? picked = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(2024),
                lastDate: DateTime(2030),
              );
              if (picked != null) {
                controller.text =
                    DateFormat('dd MMM yyyy').format(picked);
              }
            },
            decoration: InputDecoration(
              filled: true,
              fillColor: primaryColor.withOpacity(0.08),
              suffixIcon:
                  const Icon(Icons.calendar_today, color: primaryColor),
              contentPadding: const EdgeInsets.symmetric(
                vertical: 12,
                horizontal: 14,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  color: primaryColor.withOpacity(0.3),
                  width: 1,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  color: primaryColor.withOpacity(0.3),
                  width: 1,
                ),
              ),
              focusedBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                borderSide: BorderSide(
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
}
