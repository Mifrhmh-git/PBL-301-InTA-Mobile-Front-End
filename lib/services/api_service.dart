import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static const String baseUrl = 'http://192.168.168.216:8000/api';

  static Future<Map<String, dynamic>> login({
    required String username,
    required String password,
    required String role,
  }) async {
    final url = Uri.parse('$baseUrl/login');

    try {
      final response = await http.post(
        url,
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'role': role,
          'username': username,
          'password': password,
        }),
      );

      final data = jsonDecode(response.body);
      print("RESPONSE: ${response.body}");

      if (response.statusCode == 200 && data['success'] == true) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', data['access_token']);

        return {
          'success': true,
          'message': data['message'],
          'data': data['user'],
        };
      }

      return {
        'success': false,
        'message': data['message'] ?? "Login gagal",
        'remaining_attempts': data['remaining_attempts'],
        'warning': data['warning'],
      };
    } catch (e) {
      return {'success': false, 'message': "Terjadi kesalahan koneksi: $e"};
    }
  }

  static Future<bool> logout() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      if (token == null) return false;

      final url = Uri.parse('$baseUrl/logout');

      final response = await http.post(
        url,
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        return true; // Logout berhasil
      } else {
        return false;
      }
    } catch (e) {
      print("Logout error: $e");
      return false;
    }
  }

  static Future<Map<String, dynamic>> register({
    required String nama,
    required String email,
    required String username,
    required String programStudi,
    required String password,
    required String passwordConfirmation,
  }) async {
    final url = Uri.parse('$baseUrl/register');

    try {
      final response = await http.post(
        url,
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'username': username,
          'nama_lengkap': nama,
          'email': email,
          'prodi_id': programStudi,
          'role': 'mahasiswa', // default untuk form mahasiswa
          'password': password,
          'password_confirmation': passwordConfirmation,
        }),
      );

      final data = jsonDecode(response.body);
      print("REGISTER RESPONSE: ${response.body}");

      if (response.statusCode == 201) {
        return {
          'success': true,
          'message': data['message'],
          'user': data['user'],
        };
      }

      return {
        'success': false,
        'message': data['message'] ?? "Registrasi gagal",
      };
    } catch (e) {
      return {'success': false, 'message': "Terjadi kesalahan koneksi: $e"};
    }
  }

  static Future<Map<String, dynamic>> updateProfil({
    required String nama,
    required String email,
    required String nim,
    required String bidang,
  }) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString("token") ?? "";

      final response = await http.post(
        Uri.parse("$baseUrl/update-profile"),
        headers: {
          "Accept": "application/json",
          "Authorization": "Bearer $token",
        },
        body: {"nama": nama, "email": email, "nim": nim, "bidang": bidang},
      );

      return json.decode(response.body);
    } catch (e) {
      return {"success": false, "message": "Terjadi kesalahan: $e"};
    }
  }
}
