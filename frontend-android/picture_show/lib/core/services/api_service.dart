import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl = "https://sua-api.com";

  Future<List<dynamic>> fetchData() async {
    final response = await http.get(Uri.parse("$baseUrl/items"));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Erro ao carregar dados");
    }
  }
}