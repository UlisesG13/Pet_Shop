import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../../core/config/api_config.dart';

class AuthRemoteDatasource {
  final http.Client client;

  AuthRemoteDatasource(this.client);

  Future<Map<String, dynamic>> login(
    String email,
    String password,
  ) async {
    final response = await client.post(
      Uri.parse('${ApiConfig.baseUrl}/auth/login'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'email': email,
        'password': password,
      }),
    );

    return jsonDecode(response.body);
  }

  Future<Map<String, dynamic>> register(
    String email,
    String password,
    String name,
  ) async {
    final response = await client.post(
      Uri.parse('${ApiConfig.baseUrl}/auth/register'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'email': email,
        'password': password,
        'name': name,
      }),
    );

    return jsonDecode(response.body);
  }
}