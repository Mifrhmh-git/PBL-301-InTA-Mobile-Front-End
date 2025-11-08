import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:inta301/shared/shared.dart';

class FormAjuanBimbinganPage extends StatelessWidget {
  const FormAjuanBimbinganPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Dummy data, wajib ada isi
    final judulBimbingan = "Analisis Sistem Informasi Akademik";
    final dosenPembimbing = "Dr. Budi Santoso";
    final tanggal = DateFormat('dd MMM yyyy').format(DateTime.now());
    final waktu = "10.00 - 11.00";
    final lokasi = "Ruang Dosen A";

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
          iconTheme: const IconThemeData(
    color: Colors.white, // <-- panah back jadi putih
  ),
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
      body: Padding(
        padding: const EdgeInsets.all(defaultMargin),
        child: SingleChildScrollView(
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            elevation: 5,
            shadowColor: Colors.grey.withOpacity(0.3),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildReadonlyField("Judul Bimbingan", judulBimbingan),
                  _buildReadonlyField("Dosen Pembimbing", dosenPembimbing),
                  _buildReadonlyField("Tanggal", tanggal),
                  _buildReadonlyField("Waktu", waktu),
                  _buildReadonlyField("Lokasi", lokasi),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            Get.snackbar(
                              "Ditolak",
                              "Ajuan bimbingan ditolak",
                              backgroundColor: Colors.white,
                              colorText: Colors.black,
                              snackPosition: SnackPosition.TOP,
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                          ),
                          child: const Text(
                            "Tolak",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, color: Colors.white),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            Get.snackbar(
                              "Disetujui",
                              "Ajuan bimbingan disetujui",
                              backgroundColor: Colors.white,
                              colorText: Colors.black,
                              snackPosition: SnackPosition.TOP,
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                          ),
                          child: const Text(
                            "Setuju",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildReadonlyField(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label,
              style: const TextStyle(
                  fontFamily: 'Poppins', fontWeight: FontWeight.w600, fontSize: 14)),
          const SizedBox(height: 6),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(value.isNotEmpty ? value : "Belum diisi",
                style: regularTextStyle),
          ),
        ],
      ),
    );
  }
}
