import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inta301/shared/shared.dart';
import '../routes/app_pages.dart';

void showRegisterModal(BuildContext context) {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final idController = TextEditingController();
  final prodiController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmController = TextEditingController();

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

                  // Nama Lengkap
                  _buildLabel("Nama Lengkap"),
                  _buildField(controller: nameController),
                  const SizedBox(height: 15),

                  // Email
                  _buildLabel("Email"),
                  _buildField(controller: emailController),
                  const SizedBox(height: 15),

                  // ID Learning
                  _buildLabel("ID Learning"),
                  _buildField(controller: idController),
                  const SizedBox(height: 15),

                  // Program Studi
                  _buildLabel("Program Studi"),
                  _buildField(controller: prodiController),
                  const SizedBox(height: 15),

                  // Password
                  _buildLabel("Password"),
                  _buildField(controller: passwordController, isPassword: true),
                  const SizedBox(height: 15),

                  // Konfirmasi Password
                  _buildLabel("Konfirmasi Password"),
                  _buildField(controller: confirmController, isPassword: true),
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

// ====== Reusable Widgets ======

Widget _buildLabel(String text) {
  return Text(
    text,
    style: const TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 14,
      color: Colors.black,
    ),
  );
}

Widget _buildField({
  required TextEditingController controller,
  bool isPassword = false,
}) {
  return TextField(
    controller: controller,
    obscureText: isPassword,
    decoration: InputDecoration(
      filled: true,
      fillColor: primaryColor.withOpacity(0.2), // 🔹 warna kayak di kanban modal
      contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 15),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(
          color: primaryColor.withOpacity(0.3),
          width: 1,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(
          color: primaryColor.withOpacity(0.3),
          width: 1,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(
          color: primaryColor,
          width: 1.5,
        ),
      ),
    ),
  );
}
