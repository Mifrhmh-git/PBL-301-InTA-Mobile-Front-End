import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inta301/shared/shared.dart';
import '../routes/app_pages.dart';
import 'text_field_builder.dart';

void showLoginModal(BuildContext context) {
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

                    // Dropdown Jenis User
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
                        dropdownColor: Colors.white,
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

                    // Form Login
                    buildTextField("ID Learning", Icons.badge_outlined),
                    const SizedBox(height: 15),
                    buildTextField("Password", Icons.lock_outline, isPassword: true),
                    const SizedBox(height: 25),

                    // Tombol Masuk
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
