import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  Future<void> saveData(List<dynamic> data) async {
    final prefs = await SharedPreferences.getInstance();
    String jsonString = jsonEncode(data);
    await prefs.setString('cached_data', jsonString);
  }

  Future<List<dynamic>?> getData() async {
    final prefs = await SharedPreferences.getInstance();
    String? jsonString = prefs.getString('cached_data');

    if (jsonString != null) {
      return jsonDecode(jsonString);
    }
    return null;
  }
}