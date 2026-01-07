import 'dart:convert';
import 'package:http/http.dart' as http;

class Api {
  static const String baseUrl = 'http://karimabdelkhalek.atwebpages.com/API';

  Api();

  Future<List<Map<String, dynamic>>> fetchPlayers() async {
    final uri = Uri.parse("$baseUrl/players.php");

    final response = await http.get(
      uri,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);

      return data
          .map((item) => Map<String, dynamic>.from(item))
          .toList();
    } else {
      throw Exception("Failed to load data");
    }
  }
}