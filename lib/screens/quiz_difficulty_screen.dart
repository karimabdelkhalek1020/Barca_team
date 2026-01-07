import 'package:flutter/material.dart';
import 'quiz_questions_barca.dart';

class QuizDifficultyScreen extends StatelessWidget {
  const QuizDifficultyScreen({super.key});

  void _startQuiz(BuildContext context, String difficulty) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => QuizQuestionsScreen(difficulty: difficulty),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Quiz Game",style: TextStyle(color: Colors.white),),
        centerTitle: true,
        backgroundColor: Colors.indigo[900],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'FC Barcelona Quiz',
              style: TextStyle(fontSize: 26, color: Colors.white),
            ),
            const SizedBox(height: 30),

            ElevatedButton(
              onPressed: () => _startQuiz(context, 'Easy'),
              child: const Text('Easy'),
            ),
            ElevatedButton(
              onPressed: () => _startQuiz(context, 'Medium'),
              child: const Text('Medium'),
            ),
            ElevatedButton(
              onPressed: () => _startQuiz(context, 'Hard'),
              child: const Text('Hard'),
            ),
          ],
        ),
      ),
    );
  }
}
