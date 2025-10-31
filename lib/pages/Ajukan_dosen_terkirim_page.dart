import 'package:flutter/material.dart';
import '../shared/shared.dart';
import 'ajukan_dosen_menunggu_page.dart'; // 🔹 tambahkan import halaman selanjutnya

class AjukanDosenTerkirimPage extends StatelessWidget {
  const AjukanDosenTerkirimPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Gambar ilustrasi
                Image.asset(
                  'assets/images/kirim-image.png',
                  height: 200,
                ),
                const SizedBox(height: 30),

                // Judul
                const Text(
                  "TERKIRIM",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 8),

                // Deskripsi
                const Text(
                  "Permintaan pengajuan dosen pembimbing mu sudah terkirim",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 40),

                // Tombol
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2F3E52), // warna abu gelap sesuai gambar
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {
                      // ✅ ubahan hanya di sini
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const AjukanDosenMenungguPage(),
                        ),
                      );
                    },
                    child: const Text(
                      "Lihat Status Pengajuan",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
