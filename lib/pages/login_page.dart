import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inta301/shared/shared.dart';
import '../routes/app_pages.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String selectedUser = "Mahasiswa";
  final idController = TextEditingController();
  final passwordController = TextEditingController();
  bool obscurePassword = true;

  @override
  void initState() {
    super.initState();

    // Cek apakah ada argument role dari halaman sebelumnya (misalnya dari register)
    final args = Get.arguments as Map<String, dynamic>? ?? {};
    final role = args["role"] as String?;
    if (role != null && (role == "Mahasiswa" || role == "Dosen")) {
      selectedUser = role;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // 🔹 Background Gradient
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
                  children: const [
                    Text(
                      "Halo, Selamat Datang di InTA",
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 5),
                    Text(
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

                // Card putih berisi form login
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

                      _buildLabel("Jenis Pengguna"),
                      const SizedBox(height: 6),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        decoration: BoxDecoration(
                          color: const Color(0xFF88BDF2).withOpacity(0.3),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: const Color(0xFF88BDF2).withOpacity(0.3),
                            width: 1,
                          ),
                        ),
                        child: DropdownButton<String>(
                          value: selectedUser,
                          isExpanded: true,
                          underline: const SizedBox(),
                          dropdownColor: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          items: const [
                            DropdownMenuItem(
                              value: "Mahasiswa",
                              child: Text("Mahasiswa"),
                            ),
                            DropdownMenuItem(
                              value: "Dosen",
                              child: Text("Dosen"),
                            ),
                          ],
                          onChanged: (value) {
                            setState(() => selectedUser = value!);
                          },
                        ),
                      ),
                      const SizedBox(height: 15),

                      // Label ID dinamis sesuai role
                      _buildLabel(
                        selectedUser == "Mahasiswa" ? "ID Learning" : "NIK",
                      ),
                      _buildField(controller: idController),
                      const SizedBox(height: 15),

                      _buildLabel("Password"),
                      _buildField(
                        controller: passwordController,
                        isPassword: true,
                        obscureText: obscurePassword,
                        toggleVisibility: () {
                          setState(() {
                            obscurePassword = !obscurePassword;
                          });
                        },
                      ),
                      const SizedBox(height: 30),

                      // Tombol Login
                      SizedBox(
                        height: 50,
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            if (selectedUser == "Mahasiswa") {
                              // Langsung ke Home tanpa cek form data diri
                              Get.offAllNamed(Routes.HOME, arguments: false); // hasDosen default false
                            } else {
                              Get.offAllNamed(Routes.HOME_DOSEN);
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF384959),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          child: Text(
                            "Login",
                            style: whiteTextStyle.copyWith(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),

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

                            // Teks "Daftar Sekarang"
                            GestureDetector(
                              onTap: () {
                                if (selectedUser == "Mahasiswa") {
                                  Get.toNamed(
                                    Routes.REGISTER_MAHASISWA,
                                    arguments: {"role": "Mahasiswa"},
                                  );
                                } else {
                                  Get.toNamed(
                                    Routes.REGISTER_DOSEN,
                                    arguments: {"role": "Dosen"},
                                  );
                                }
                              },
                              child: RichText(
                                text: TextSpan(
                                  text: "Belum punya akun? ",
                                  style: blackTextStyle.copyWith(fontSize: 13),
                                  children: const [
                                    TextSpan(
                                      text: "Daftar Sekarang",
                                      style: TextStyle(
                                        color: Color(0xFF88BDF2),
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: 'Poppins',
                                      ),
                                    ),
                                  ],
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
          ),
        ],
      ),
    );
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
      contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 15),
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
      focusedBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(16)),
        borderSide: BorderSide(
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
