import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inta301/shared/shared.dart';
import '../routes/app_pages.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        bottom: false,
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: defaultMargin, vertical: 20),
          children: [
            const SizedBox(height: 30),
            Center(
              child: Image.asset(
                'assets/images/login-image.png',
                height: 250,
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(height: 30),
            Text(
              "Selamat Datang di InTA",
              style: blackTextStyle.copyWith(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            Text(
              "Aplikasi informasi tugas akhir mahasiswa Polibatam.",
              style: greyTextStyle.copyWith(fontSize: 15),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 50),

            // 🔹 Tombol Create Account
            SizedBox(
              height: 55,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => _showRegisterModal(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: Text(
                  "Create Account",
                  style: whiteTextStyle.copyWith(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 15),

            // 🔹 Tombol Login
            SizedBox(
              height: 55,
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () => _showLoginModal(context),
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: primaryColor, width: 2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: Text(
                  "Login",
                  style: blackTextStyle.copyWith(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 40),
            Text(
              "All rights reserved ©2025",
              textAlign: TextAlign.center,
              style: greyTextStyle.copyWith(fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }

  // 🔹 Modal Register
  void _showRegisterModal(BuildContext context) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.85,
          maxChildSize: 0.95,
          expand: false,
          builder: (context, scrollController) {
            return Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              padding: EdgeInsets.symmetric(horizontal: defaultMargin, vertical: 25),
              child: SingleChildScrollView(
                controller: scrollController,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Buat Akun Baru",
                          style: blackTextStyle.copyWith(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: const Icon(Icons.close, color: Colors.grey),
                        ),
                      ],
                    ),
                    const SizedBox(height: 25),

                    // 🔸 Form Registrasi
                    _buildTextField("Nama Lengkap", Icons.person_outline),
                    const SizedBox(height: 15),
                    _buildTextField("Email", Icons.email_outlined),
                    const SizedBox(height: 15),
                    _buildTextField("ID Learning", Icons.badge_outlined),
                    const SizedBox(height: 15),
                    _buildTextField("Program Studi", Icons.school_outlined),
                    const SizedBox(height: 15),
                    _buildTextField("Password", Icons.lock_outline, isPassword: true),
                    const SizedBox(height: 15),
                    _buildTextField("Konfirmasi Password", Icons.lock_outline, isPassword: true),

                    const SizedBox(height: 30),

                    // 🔹 Tombol Daftar
                    SizedBox(
                      height: 55,
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          Get.offAllNamed(Routes.HOME);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        child: Text(
                          "Daftar",
                          style: whiteTextStyle.copyWith(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
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

  // 🔹 Modal Login
  void _showLoginModal(BuildContext context) {
    String selectedUser = "Mahasiswa";

    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return StatefulBuilder(builder: (context, setState) {
          return DraggableScrollableSheet(
            initialChildSize: 0.75,
            maxChildSize: 0.9,
            expand: false,
            builder: (context, scrollController) {
              return Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                padding: EdgeInsets.symmetric(horizontal: defaultMargin, vertical: 25),
                child: SingleChildScrollView(
                  controller: scrollController,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Login",
                            style: blackTextStyle.copyWith(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: const Icon(Icons.close, color: Colors.grey),
                          ),
                        ],
                      ),
                      const SizedBox(height: 25),

                      // 🔸 Dropdown Jenis User
                      Text("Jenis Pengguna", style: greyTextStyle),
                      const SizedBox(height: 5),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade400),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: DropdownButton<String>(
                          value: selectedUser,
                          isExpanded: true,
                          underline: const SizedBox(),
                          dropdownColor: Colors.white, // ✅ warna putih saat ditekan
                          items: const [
                            DropdownMenuItem(value: "Mahasiswa", child: Text("Mahasiswa")),
                            DropdownMenuItem(value: "Dosen", child: Text("Dosen")),
                          ],
                          onChanged: (value) {
                            setState(() => selectedUser = value!);
                          },
                        ),
                      ),
                      const SizedBox(height: 15),

                      // 🔸 Form Login
                      _buildTextField("ID Learning", Icons.badge_outlined),
                      const SizedBox(height: 15),
                      _buildTextField("Password", Icons.lock_outline, isPassword: true),
                      const SizedBox(height: 25),

                      // 🔹 Tombol Masuk
                      SizedBox(
                        height: 55,
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            Get.offAllNamed(Routes.HOME);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: primaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          child: Text(
                            "Masuk",
                            style: whiteTextStyle.copyWith(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
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
        });
      },
    );
  }

  // 🔹 Reusable Input Field
  Widget _buildTextField(String label, IconData icon, {bool isPassword = false}) {
    return TextField(
      obscureText: isPassword,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: primaryColor),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade400, width: 1.3),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: primaryColor, width: 2),
        ),
      ),
    );
  }
}
