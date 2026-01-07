import 'package:flutter/material.dart';
import 'quiz_api.dart';

class LeaderboardPage extends StatefulWidget {
  const LeaderboardPage({super.key});

  @override
  State<LeaderboardPage> createState() => _LeaderboardPageState();
}

class _LeaderboardPageState extends State<LeaderboardPage> {
  final QuizApi _api = QuizApi();
  late Future<List<Map<String, dynamic>>> _scoresFuture;

  @override
  void initState() {
    super.initState();
    _scoresFuture = _api.fetchLeaderboard();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(24),
          decoration: const BoxDecoration(
            color: Color(0xFF004D98),
            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(32), bottomRight: Radius.circular(32)),
          ),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.emoji_events, color: Color(0xFFEDBB00), size: 40),
              SizedBox(width: 12),
              Text(
                "Hall of Fame",
                style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        Expanded(
          child: FutureBuilder<List<Map<String, dynamic>>>(
            future: _scoresFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text("Error: ${snapshot.error}"));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(child: Text("No scores yet. Be the first!"));
              }

              final scores = snapshot.data!;
              return ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: scores.length,
                itemBuilder: (context, index) {
                  final score = scores[index];
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundColor: index == 0 ? const Color(0xFFEDBB00) : const Color(0xFFA50044),
                      child: Text("${index + 1}", style: const TextStyle(color: Colors.white)),
                    ),
                    title: Text(score['username'], style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text(score['quiz_date'].toString().split(' ')[0]),
                    trailing: Text(
                      "${score['score']} pts",
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF004D98)),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
