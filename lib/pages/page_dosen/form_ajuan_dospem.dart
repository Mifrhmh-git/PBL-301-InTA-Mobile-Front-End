import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inta301/shared/shared.dart';

class FormAjuanDospemPage extends StatelessWidget {
  const FormAjuanDospemPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Dummy data
    final dosenPembimbing = "Belum ada (diisi oleh mahasiswa)";
    final alasan = "Ingin dibimbing karena dosen ahli di bidang ...";
    final judulTA = "Sistem Informasi Akademik";
    final deskripsi = "Rencana TA tentang pengembangan aplikasi sistem informasi akademik...";
    final filePortofolio = "porto_mahasiswa.pdf";

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Detail Ajuan",
          style: TextStyle(
            fontWeight: FontWeight.bold, // Tulisan tebal
            fontSize: 20,                // Ukuran lebih besar
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        foregroundColor: Colors.white,
        elevation: 0,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [primaryColor, dangerColor], // Gradasi header
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(defaultMargin),
        child: SingleChildScrollView(
          child: Card(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 8,
            margin: const EdgeInsets.only(bottom: 20),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // --- DOSEN PEMBIMBING ---
                  Text("Dosen Pembimbing", style: boldTextStyle.copyWith(fontSize: 16)),
                  const SizedBox(height: 6),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(dosenPembimbing, style: regularTextStyle),
                  ),
                  const SizedBox(height: 16),
                  // --- ALASAN ---
                  Text("Alasan Memilih Dosen", style: boldTextStyle.copyWith(fontSize: 16)),
                  const SizedBox(height: 6),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(alasan, style: regularTextStyle),
                  ),
                  const SizedBox(height: 16),
                  // --- RENCANA JUDUL ---
                  Text("Rencana Judul TA", style: boldTextStyle.copyWith(fontSize: 16)),
                  const SizedBox(height: 6),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(judulTA, style: regularTextStyle),
                  ),
                  const SizedBox(height: 16),
                  // --- DESKRIPSI ---
                  Text("Deskripsi TA", style: boldTextStyle.copyWith(fontSize: 16)),
                  const SizedBox(height: 6),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(deskripsi, style: regularTextStyle),
                  ),
                  const SizedBox(height: 16),
                  // --- FILE PORTOFOLIO ---
                  Text("Portofolio Mahasiswa", style: boldTextStyle.copyWith(fontSize: 16)),
                  const SizedBox(height: 6),
                  GestureDetector(
                    onTap: () {
                      Get.snackbar("Download", "File $filePortofolio berhasil diunduh");
                    },
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.download, color: primaryColor),
                          const SizedBox(width: 12),
                          Expanded(child: Text(filePortofolio, style: regularTextStyle)),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  // --- TOMBOL TERIMA / TOLAK ---
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            Get.snackbar("Ditolak", "Ajuan dospem ditolak");
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            textStyle: const TextStyle(
                              fontWeight: FontWeight.bold, // Tulisan tombol tebal
                            ),
                          ),
                          child: const Text("Tolak"),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            Get.snackbar("Disetujui", "Ajuan dospem diterima");
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            textStyle: const TextStyle(
                              fontWeight: FontWeight.bold, // Tulisan tombol tebal
                            ),
                          ),
                          child: const Text("Setuju"),
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
}
