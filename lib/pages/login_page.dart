import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inta301/shared/shared.dart';
import '../routes/app_pages.dart';
import '../controllers/auth_controller.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // ✅ Inisialisasi controller
  final AuthController controller = Get.put(AuthController());
  
  String selectedUser = "Mahasiswa";
  bool obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Background Gradient
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

          // Isi Halaman
          SafeArea(
            bottom: false,
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                const SizedBox(height: 40),

                // Header
                Column(
                  children: [
                    const Text(
                      "Halo, Selamat Datang Di InTA",
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 5),
                    const Text(
                      "Silakan masuk untuk melanjutkan",
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),

                const SizedBox(height: 35),

                // Card putih berisi form
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
                    vertical: 25,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: const Color(0xFF88BDF2).withOpacity(0.3),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 14),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide(
                              color: const Color(0xFF88BDF2).withOpacity(0.3),
                              width: 1,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide(
                              color: const Color(0xFF88BDF2).withOpacity(0.3),
                              width: 1,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(16)),
                            borderSide: BorderSide(
                              color: Color(0xFF88BDF2),
                              width: 1.5,
                            ),
                          ),
                        ),

                        buttonStyleData: const ButtonStyleData(
                          padding: EdgeInsets.zero,
                        ),

                        dropdownStyleData: DropdownStyleData(
                          maxHeight: 200,
                          decoration: BoxDecoration(
                            color: Color(0xFFDDEEFF),
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),

                        items: const [
                          DropdownMenuItem(value: "Mahasiswa", child: Text("Mahasiswa")),
                          DropdownMenuItem(value: "Dosen", child: Text("Dosen")),
                        ],

                        onChanged: (value) {
                          setState(() => selectedUser = value!);
                        },
                      ),
                      SizedBox(height: 15),
                      _buildLabel(
                        selectedUser == "Mahasiswa" ? "NIM" : "NIK",
                      ),
                      const SizedBox(height: 15),

                      _buildLabel("ID Learning"),
                      _buildField(controller: controller.usernameController),
                      const SizedBox(height: 15),

                      _buildLabel("Password"),
                      _buildField(
                        controller: controller.passwordController,
                        isPassword: true,
                        obscureText: obscurePassword,
                        toggleVisibility: () {
                          setState(() {
                            obscurePassword = !obscurePassword;
                          });
                        },
                      ),
                      const SizedBox(height: 30),

                      Obx(() => SizedBox(
                        height: 50,
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: controller.isLoading.value
                              ? null
                              : () {
                                  controller.login();
                                },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF384959),
                            disabledBackgroundColor: Colors.grey, // ✅ Warna saat disabled
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16), 
                            ),
                          ),
                          child: controller.isLoading.value
                              ? const SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 2,
                                  ),
                                )
                              : Text(
                                  "Login",
                                  style: whiteTextStyle.copyWith(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                        ),
                      )),

                      const SizedBox(height: 15),

                      Center(
                        child: Column(
                          children: [
                            TextButton(
                              onPressed: () {},
                              child: Text(
                                "Lupa kata sandi?",
                                style: blackTextStyle.copyWith(fontSize: 12),
                              ),
                            ),
                            const SizedBox(height: 5),
                            RichText(
                              text: TextSpan(
                                text: "Belum punya akun? ",
                                style: blackTextStyle.copyWith(fontSize: 13),
                                children: [
                                  TextSpan(
                                    text: "Daftar Sekarang",
                                    style: TextStyle(
                                      color: const Color(0xFF88BDF2),
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: 'Poppins',
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
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    // ✅ Cleanup controller saat page di dispose
    // Get.delete<AuthController>(); // Opsional, tergantung kebutuhan
    super.dispose();
  }
}

// ===== Reusable Widgets =====
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
  bool obscureText = false,
  VoidCallback? toggleVisibility,
}) {
  return TextField(
    controller: controller,
    obscureText: obscureText,
    decoration: InputDecoration(
      filled: true,
      fillColor: const Color(0xFF88BDF2).withOpacity(0.3),
      contentPadding:
          const EdgeInsets.symmetric(vertical: 12, horizontal: 15),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16), 
        borderSide: BorderSide(
          color: const Color(0xFF88BDF2).withOpacity(0.3),
          width: 1,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16), 
        borderSide: BorderSide(
          color: const Color(0xFF88BDF2).withOpacity(0.3),
          width: 1,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16), 
        borderSide: const BorderSide(
          color: Color(0xFF88BDF2),
          width: 1.5,
        ),
      ),
      suffixIcon: isPassword
          ? IconButton(
              icon: Icon(
                obscureText ? Icons.visibility_off : Icons.visibility,
                color: Colors.black54,
              ),
              onPressed: toggleVisibility,
            )
          : null,
    ),
  );
}