import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/api_service.dart';
import '../routes/app_pages.dart';

class AuthController extends GetxController {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  RxString selectedRole = "mahasiswa".obs;
  RxBool isLoading = false.obs;

  void login() async {
    final username = usernameController.text.trim();
    final password = passwordController.text.trim();
    final role = selectedRole.value;

    if (username.isEmpty || password.isEmpty) {
      Get.snackbar("Error", "ID Learning dan Password wajib diisi");
      return;
    }

    isLoading.value = true;

    final response = await AuthService.login(
      username: username,
      password: password,
      role: role,
    );

    isLoading.value = false;

    if (response['success'] == true) {
      Get.snackbar("Berhasil", "Login berhasil");
      final prefs = await SharedPreferences.getInstance();
      prefs.setString("token", response['token']);

      // Arahkan berdasarkan role
      if (role == "mahasiswa") {
        Get.offAllNamed(Routes.HOME);
      } else if (role == "dosen") {
        Get.offAllNamed(Routes.HOME_DOSEN);
      }
    } else {
      final message = response['message'] ?? '';
      final attempts = response['remaining_attempts'] ?? 0;
      final warning = response['warning'];

      String formattedMessage = "$message\nSisa percobaan: $attempts";

      if (warning != null && warning.toString().trim().isNotEmpty) {
        formattedMessage += "\nPerhatian: $warning";
      }
      // Tampilkan pesan error dari API Laravel
      Get.snackbar(
        "Login Gagal",
        formattedMessage,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
    }
  }

  void logout() async {
    isLoading.value = true;

    final logoutSuccess = await AuthService.logout();

    isLoading.value = false;

    // Hapus token & data user local
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();

    // Reset state controller
    usernameController.clear();
    passwordController.clear();
    selectedRole.value = '';

    // Arahkan ke halaman welcome
    Get.offAllNamed('/welcome');

    // Snackbar opsional
    if (logoutSuccess) {
      Get.snackbar(
        "Logout Berhasil",
        "Anda berhasil keluar.",
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } else {
      Get.snackbar(
        "Logout",
        "Logout lokal berhasil. (Server gagal merespon)",
        backgroundColor: Colors.orange,
        colorText: Colors.white,
      );
    }
  }

  Future<void> register({
    required String nama,
    required String email,
    required String username,
    required String prodi,
    required String password,
    required String passwordConfirmation,
  }) async {
    isLoading.value = true;

    final response = await AuthService.register(
      nama: nama,
      email: email,
      username: username,
      programStudi: prodi,
      password: password,
      passwordConfirmation: passwordConfirmation,
    );

    isLoading.value = false;

    print(response);
    if (response['success'] == true) {
      Get.snackbar(
        "Sukses",
        "Registrasi berhasil, silakan login",
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
      Get.back(); // tutup modal
    } else {
      Get.snackbar(
        "Gagal",
        response['message'] ?? "Registrasi gagal",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
}
