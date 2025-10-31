import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:inta301/shared/shared.dart';
import 'text_field_builder.dart';
import 'dart:convert';
import 'package:crypto/crypto.dart';

void showRegisterModal(BuildContext context) {

  final TextEditingController namaC = TextEditingController();
  final TextEditingController emailC = TextEditingController();
  final TextEditingController idC = TextEditingController();
  final TextEditingController prodiC = TextEditingController();
  final TextEditingController passC = TextEditingController();
  final TextEditingController confirmC = TextEditingController();

  bool validatePassword(String pass) {
    return pass.length >= 8 &&
        RegExp(r'[A-Z]').hasMatch(pass) &&
        RegExp(r'[a-z]').hasMatch(pass) &&
        RegExp(r'[0-9]').hasMatch(pass) &&
        RegExp(r'[!@#\$&*~%]').hasMatch(pass);
  }

  String hash(String pass) => sha256.convert(utf8.encode(pass)).toString();

  Future<void> saveAccount() async {
    if (namaC.text.isEmpty ||
        emailC.text.isEmpty ||
        idC.text.isEmpty ||
        prodiC.text.isEmpty ||
        passC.text.isEmpty) {

      Get.snackbar("Error", "Semua field harus diisi",
          backgroundColor: Colors.red, colorText: Colors.white);
      return;
    }

    if (passC.text != confirmC.text) {
      Get.snackbar("Error", "Konfirmasi password tidak cocok",
          backgroundColor: Colors.red, colorText: Colors.white);
      return;
    }

    if (!validatePassword(passC.text)) {
      Get.snackbar("Error", "Password harus 8+ char, uppercase, angka & simbol",
          backgroundColor: Colors.red, colorText: Colors.white);
      return;
    }

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('nama', namaC.text);
    await prefs.setString('email', emailC.text);
    await prefs.setString('id_learning', idC.text);
    await prefs.setString('prodi', prodiC.text);
    await prefs.setString('role', 'Mahasiswa');
    await prefs.setString('password', hash(passC.text));

    Get.snackbar("Sukses", "Akun berhasil dibuat ✅",
        backgroundColor: Colors.green, colorText: Colors.white);

    Navigator.pop(context);
  }

  showModalBottomSheet(
    isScrollControlled: true,
    context: context,
    backgroundColor: Colors.transparent,
    builder: (context) {
      return DraggableScrollableSheet(
        initialChildSize: 0.85,
        maxChildSize: 0.95,
        builder: (_, scroll) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: defaultMargin, vertical: 25),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
            child: SingleChildScrollView(
              controller: scroll,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Buat Akun Baru",
                      style: blackTextStyle.copyWith(
                        fontSize: 22, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 25),

                  buildTextField("Nama Lengkap", Icons.person_outline, controller: namaC),
                  const SizedBox(height: 15),
                  buildTextField("Email", Icons.email_outlined, controller: emailC),
                  const SizedBox(height: 15),
                  buildTextField("ID Learning", Icons.badge_outlined, controller: idC),
                  const SizedBox(height: 15),
                  buildTextField("Program Studi", Icons.school_outlined, controller: prodiC),
                  const SizedBox(height: 15),
                  buildTextField("Password", Icons.lock_outline, controller: passC, isPassword: true),
                  const SizedBox(height: 15),
                  buildTextField("Konfirmasi Password", Icons.lock_outline, controller: confirmC, isPassword: true),
                  const SizedBox(height: 25),

                  SizedBox(
                    height: 55,
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: saveAccount,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text("Daftar", style: whiteTextStyle.copyWith(fontSize: 18)),
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