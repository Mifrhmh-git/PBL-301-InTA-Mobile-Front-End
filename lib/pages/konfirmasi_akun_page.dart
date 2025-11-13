import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inta301/shared/shared.dart';
import 'package:inta301/pages/password_baru_page.dart';


class KonfirmasiAkunPage extends StatelessWidget {
  const KonfirmasiAkunPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<TextEditingController> otpControllers =
        List.generate(6, (index) => TextEditingController());

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // 🔹 Background gradient (sama seperti halaman lupa sandi)
          Container(
            height: 300,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFF88BDF2),
                  Color(0xFF384959),
                ],
              ),
            ),
          ),

          // 🔹 Isi halaman
          SafeArea(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                const SizedBox(height: 40),

                // 🔹 Header
                const Column(
                  children: [
                    Text(
                      "Konfirmasi Akun Anda",
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),

                const SizedBox(height: 35),

                // 🔹 Card putih di bawah
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(60),
                      topRight: Radius.circular(60),
                    ),
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: defaultMargin,
                    vertical: 40,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        "Masukkan Kode",
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF384959),
                        ),
                      ),
                      const SizedBox(height: 25),

                      // 🔹 Enam kotak kode OTP
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: List.generate(
                          6,
                          (index) => SizedBox(
                            width: 45,
                            child: TextField(
                              controller: otpControllers[index],
                              textAlign: TextAlign.center,
                              maxLength: 1,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                counterText: "",
                                filled: true,
                                fillColor:
                                    const Color(0xFF88BDF2).withOpacity(0.3),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(
                                    color: const Color(0xFF88BDF2)
                                        .withOpacity(0.5),
                                  ),
                                ),
                                focusedBorder: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12)),
                                  borderSide: BorderSide(
                                    color: Color(0xFF384959),
                                    width: 1.5,
                                  ),
                                ),
                              ),
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF384959),
                              ),
                              onChanged: (value) {
                                if (value.isNotEmpty && index < 5) {
                                  FocusScope.of(context).nextFocus();
                                }
                              },
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 40),

                      // 🔹 Tombol lanjutkan (full width, konsisten)
                      SizedBox(
                        height: 50,
                        width: double.infinity,
                        child: ElevatedButton(
               onPressed: () {
  Get.to(() => const PasswordBaruPage());
},



                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF384959),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          child: const Text(
                            "Lanjutkan",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 15),

                      // 🔹 Kirim kode lagi (snackbar putih + teks tegas)
                      TextButton(
                        onPressed: () {
                          Get.snackbar(
                            "",
                            "",
                            backgroundColor: Colors.white,
                            snackPosition: SnackPosition.TOP,
                            margin: const EdgeInsets.all(12),
                            borderRadius: 12,
                            titleText: const Text(
                              "Berhasil",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Colors.black,
                              ),
                            ),
                            messageText: const Text(
                              "Kode verifikasi baru telah dikirim ke email kamu.",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                                color: Colors.black87,
                              ),
                            ),
                          );
                        },
                        child: const Text(
                          "Kirim kode lagi",
                          style: TextStyle(
                            color: Color(0xFF384959),
                            fontSize: 13,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
