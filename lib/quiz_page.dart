import 'package:flutter/material.dart';
import 'quiz_api.dart';

class QuizPage extends StatefulWidget {
  final int userId;
  const QuizPage({super.key, required this.userId});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  final QuizApi _api = QuizApi();
  List<Map<String, dynamic>> _quizzes = [];
  int _currentQuestionIndex = 0;
  int _score = 0;
  bool _isLoading = true;
  bool _isFinished = false;

  @override
  void initState() {
    super.initState();
    _loadQuizzes();
  }

  void _loadQuizzes() async {
    try {
      final quizzes = await _api.fetchQuizzes();
      setState(() {
        _quizzes = quizzes;
        _isLoading = false;
      });
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error loading quiz: $e")),
        );
      }
    }
  }

  void _answerQuestion(String selectedOption) {
    if (selectedOption == _quizzes[_currentQuestionIndex]['correct_option']) {
      _score++;
    }

    if (_currentQuestionIndex < _quizzes.length - 1) {
      setState(() {
        _currentQuestionIndex++;
      });
    } else {
      _finishQuiz();
    }
  }

  void _finishQuiz() async {
    setState(() => _isFinished = true);
    try {
      await _api.saveScore(widget.userId, _score);
    } catch (e) {
      debugPrint("Error saving score: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_quizzes.isEmpty) {
      return const Center(child: Text("No questions available."));
    }

    if (_isFinished) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.emoji_events, size: 100, color: Color(0xFFEDBB00)),
            const SizedBox(height: 16),
            const Text("Quiz Finished!", style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text("Your Score: $_score / ${_quizzes.length}", style: const TextStyle(fontSize: 20)),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _currentQuestionIndex = 0;
                  _score = 0;
                  _isFinished = false;
                  _isLoading = true;
                });
                _loadQuizzes();
              },
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF004D98), foregroundColor: Colors.white),
              child: const Text("Restart Quiz"),
            ),
          ],
        ),
      );
    }

    final quiz = _quizzes[_currentQuestionIndex];

    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          LinearProgressIndicator(
            value: (_currentQuestionIndex + 1) / _quizzes.length,
            backgroundColor: Colors.grey[300],
            color: const Color(0xFFA50044),
          ),
          const SizedBox(height: 24),
          Text(
            "Question ${_currentQuestionIndex + 1}/${_quizzes.length}",
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.grey),
          ),
          const SizedBox(height: 16),
          Text(
            quiz['question'],
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF004D98)),
          ),
          const SizedBox(height: 32),
          _optionButton(quiz['option_a'], 'A'),
          _optionButton(quiz['option_b'], 'B'),
          _optionButton(quiz['option_c'], 'C'),
          _optionButton(quiz['option_d'], 'D'),
        ],
      ),
    );
  }

  Widget _optionButton(String text, String optionKey) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: ElevatedButton(
        onPressed: () => _answerQuestion(optionKey),
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          side: const BorderSide(color: Color(0xFF004D98)),
        ),
        child: Text(text, style: const TextStyle(fontSize: 18, color: Color(0xFF004D98))),
      ),
    );
  }
}
