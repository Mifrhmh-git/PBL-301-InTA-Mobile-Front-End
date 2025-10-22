import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inta301/shared/shared.dart';
import '../routes/app_pages.dart';
import 'login_modal.dart';
import 'register_modal.dart';

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

            // Tombol Create Account
            SizedBox(
              height: 55,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => showRegisterModal(context),
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

            // Tombol Login
            SizedBox(
              height: 55,
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () => showLoginModal(context),
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
}
