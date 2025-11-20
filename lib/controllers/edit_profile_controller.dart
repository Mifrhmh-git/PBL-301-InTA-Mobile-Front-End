import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../services/api_service.dart';

class KelolaAkunController extends GetxController {
  final namaController = TextEditingController();
  final emailController = TextEditingController();
  final nimController = TextEditingController();
  final portofolioController = TextEditingController();

  var isLoading = false.obs;

  void loadUserData(Map user) {
    namaController.text = user['nama'] ?? '';
    emailController.text = user['email'] ?? '';
    nimController.text = user['nim'] ?? '';
    portofolioController.text = user['portofolio'] ?? '';
  }

  Future<void> updateProfile() async {
    isLoading.value = true;

    final response = await AuthService.updateProfil(
      nama: namaController.text,
      email: emailController.text,
      nim: nimController.text,
      bidang: portofolioController.text,
    );

    isLoading.value = false;

    if (response['success'] == true) {
      Get.snackbar("Berhasil", "Profil berhasil diperbarui",
          backgroundColor: Colors.green, colorText: Colors.white);
      Get.back();
    } else {
      Get.snackbar("Gagal", response['message'],
          backgroundColor: Colors.red, colorText: Colors.white);
    }
  }
}
