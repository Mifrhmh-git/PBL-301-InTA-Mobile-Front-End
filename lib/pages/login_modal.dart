import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:inta301/shared/shared.dart';
import 'text_field_builder.dart';
import 'dart:convert';
import 'package:crypto/crypto.dart';
import '../routes/app_pages.dart';

void showLoginModal(BuildContext context) {
  final idC = TextEditingController();
  final passC = TextEditingController();

  String hash(String pass) => sha256.convert(utf8.encode(pass)).toString();

  Future<void> login() async {
    final prefs = await SharedPreferences.getInstance();

    String? savedId = prefs.getString('id_learning');
    String? savedPass = prefs.getString('password');

    if (idC.text == savedId && hash(passC.text) == savedPass) {
      Get.snackbar(
        "Success",
        "Login Berhasil ✅",
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );

      prefs.setBool('isLoggedIn', true);
      Get.offAllNamed(Routes.HOME);
    } else {
      Get.snackbar(
        "Error",
        "ID Learning / Password salah",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  showModalBottomSheet(
    isScrollControlled: true,
    context: context,
    backgroundColor: Colors.transparent,
    builder: (_) => DraggableScrollableSheet(
      initialChildSize: 0.75,
      maxChildSize: 0.9,
      builder: (_, scroll) {
        return Container(
          padding: EdgeInsets.symmetric(
            horizontal: defaultMargin,
            vertical: 25,
          ),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Login",
                style: blackTextStyle.copyWith(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 25),

              buildTextField(
                "ID Learning",
                Icons.badge_outlined,
                controller: idC,
              ),
              const SizedBox(height: 15),
              buildTextField(
                "Password",
                Icons.lock_outline,
                controller: passC,
                isPassword: true,
              ),
              const SizedBox(height: 25),

              SizedBox(
                height: 55,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: login,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    "Masuk",
                    style: whiteTextStyle.copyWith(fontSize: 18),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    ),
  );
}
