// lib/services/api_service.dart

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'api_config.dart';

class ApiService {
  // ---- LOGIN ----
  static Future<Map<String, dynamic>> login({
    // required String email,
    required String username,
    required String password,
  }) async {
    final url = Uri.parse('${ApiConfig.baseUrl}/auth/login');

    try {
      final response = await http.post(
        url,
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          // 'email': email,
          'username': username,
          'password': password,
        }),
      );

      final data = jsonDecode(response.body);

      return {'statusCode': response.statusCode, 'data': data};
    } catch (e) {
      return {
        'statusCode': 500,
        'data': {'status': false, 'message': 'Terjadi kesalahan: $e'},
      };
    }
  }

  // ---- REGISTER ----
  static Future<Map<String, dynamic>> register({
    required String nama,
    required String email,
    required String idLearning,
    required String prodi,
    required String password,
  }) async {
    final url = Uri.parse('${ApiConfig.baseUrl}/auth/register');

    try {
      final response = await http.post(
        url,
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'nama': nama,
          'email': email,
          'id_learning': idLearning,
          'prodi': prodi,
          'password': password,
        }),
      );

      final data = jsonDecode(response.body);

      return {'statusCode': response.statusCode, 'data': data};
    } catch (e) {
      return {
        'statusCode': 500,
        'data': {'status': false, 'message': 'Terjadi kesalahan: $e'},
      };
    }
  }
}
