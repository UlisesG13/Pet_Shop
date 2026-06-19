import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../../core/config/api_config.dart';

class PetsRemoteDatasource {
  final http.Client client;

  PetsRemoteDatasource(this.client);

  static const _path = '/pets';

  Future<List<dynamic>> getAll() async {
    final response = await client.get(
      Uri.parse('${ApiConfig.baseUrl}$_path'),
    );

    // La API responde 404 cuando no hay registros -> lista vacía.
    if (response.statusCode == 404) return [];

    if (response.statusCode != 200) {
      throw Exception(_error(response.body));
    }

    return jsonDecode(response.body) as List<dynamic>;
  }

  Future<void> create(String name, String raza) async {
    final response = await client.post(
      Uri.parse('${ApiConfig.baseUrl}$_path'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'name': name, 'raza': raza}),
    );

    if (response.statusCode != 201 && response.statusCode != 200) {
      throw Exception(_error(response.body));
    }
  }

  Future<void> update(int id, String name, String raza) async {
    final response = await client.put(
      Uri.parse('${ApiConfig.baseUrl}$_path/$id'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'name': name, 'raza': raza}),
    );

    if (response.statusCode != 200) {
      throw Exception(_error(response.body));
    }
  }

  Future<void> delete(int id) async {
    final response = await client.delete(
      Uri.parse('${ApiConfig.baseUrl}$_path/$id'),
    );

    if (response.statusCode != 200) {
      throw Exception(_error(response.body));
    }
  }

  String _error(String body) {
    try {
      final decoded = jsonDecode(body);
      return decoded['error']?.toString() ?? 'Error en el servidor';
    } catch (_) {
      return 'Error en el servidor';
    }
  }
}
