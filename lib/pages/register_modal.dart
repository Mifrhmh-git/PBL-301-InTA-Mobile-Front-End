import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inta301/shared/shared.dart';
import '../routes/app_pages.dart';
import 'text_field_builder.dart';

void showRegisterModal(BuildContext context) {
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

                  // Form Registrasi
                  buildTextField("Nama Lengkap", Icons.person_outline),
                  const SizedBox(height: 15),
                  buildTextField("Email", Icons.email_outlined),
                  const SizedBox(height: 15),
                  buildTextField("ID Learning", Icons.badge_outlined),
                  const SizedBox(height: 15),
                  buildTextField("Program Studi", Icons.school_outlined),
                  const SizedBox(height: 15),
                  buildTextField("Password", Icons.lock_outline, isPassword: true),
                  const SizedBox(height: 15),
                  buildTextField("Konfirmasi Password", Icons.lock_outline, isPassword: true),
                  const SizedBox(height: 30),

                  // Tombol Daftar
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
