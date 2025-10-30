import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../shared/shared.dart';

class CariDosenPage extends StatelessWidget {
  const CariDosenPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/cari-image.png',
                height: 200,
              ),
              const SizedBox(height: 24),
              const Text(
                "Yah, kamu belum memiliki dosen pembimbing nih",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // Arahkan ke halaman pilih dosen pembimbing
                    Get.toNamed('/pilih-dosen');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueGrey[800],
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16), // ✅ ubah jadi 16
                    ),
                    elevation: 4, // opsional: bayangan halus
                  ),
                  child: const Text(
                    "Cari Dosen Pembimbing",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
