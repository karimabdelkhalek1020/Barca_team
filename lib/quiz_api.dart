import 'dart:convert';
import 'package:http/http.dart' as http;
import 'api.dart';

class QuizApi {
  static const String baseUrl = Api.baseUrl;

  Future<List<Map<String, dynamic>>> fetchQuizzes() async {
    final response = await http.get(Uri.parse("$baseUrl/quizzes.php"));
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((item) => Map<String, dynamic>.from(item)).toList();
    } else {
      throw Exception("Failed to load quizzes");
    }
  }

  Future<Map<String, dynamic>> saveScore(int userId, int score) async {
    final response = await http.post(
      Uri.parse("$baseUrl/scores.php"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"user_id": userId, "score": score}),
    );
    return jsonDecode(response.body);
  }

  Future<List<Map<String, dynamic>>> fetchLeaderboard() async {
    final response = await http.get(Uri.parse("$baseUrl/scores.php"));
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((item) => Map<String, dynamic>.from(item)).toList();
    } else {
      throw Exception("Failed to load leaderboard");
    }
  }
}
