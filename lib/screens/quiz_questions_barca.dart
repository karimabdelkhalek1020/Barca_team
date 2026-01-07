import 'package:flutter/material.dart';

class QuizQuestionsScreen extends StatefulWidget {
  final String difficulty;

  QuizQuestionsScreen({required this.difficulty});

  @override
  _QuizQuestionsScreenState createState() => _QuizQuestionsScreenState();
}

class _QuizQuestionsScreenState extends State<QuizQuestionsScreen> {
  final List<Map<String, Object>> easyQuestions = [
    {
      'questionText': 'What is FC Barcelona\'s stadium called?',
      'answers': ['Camp Nou', 'Bernabéu', 'Metropolitano', 'Mestalla'],
      'correctAnswer': 'Camp Nou'
    },
    {
      'questionText': 'What are Barcelona fans called?',
      'answers': ['Reds', 'Blancos', 'Madridistas', 'Culés'],
      'correctAnswer': 'Culés'
    },
    {
      'questionText': 'Which colors does FC Barcelona wear?',
      'answers': ['White', 'Blue and Red', 'Green', 'Black'],
      'correctAnswer': 'Blue and Red'
    },
    {
      'questionText': 'Who is Barcelona\'s all-time top scorer?',
      'answers': ['Lionel Messi', 'Ronaldinho', 'Suárez', 'Xavi'],
      'correctAnswer': 'Lionel Messi'
    },
    {
      'questionText': 'Which country is FC Barcelona from?',
      'answers': ['Italy', 'France', 'Spain', 'Portugal'],
      'correctAnswer': 'Spain'
    },
  ];

  final List<Map<String, Object>> mediumQuestions = [
    {
      'questionText': 'How many Champions League titles has Barcelona won?',
      'answers': ['2', '4', '6', '5'],
      'correctAnswer': '5'
    },
    {
      'questionText': 'What is Barcelona’s famous academy called?',
      'answers': ['La Masia', 'Valdebebas', 'Cantera', 'Youth Camp'],
      'correctAnswer': 'La Masia'
    },
    {
      'questionText': 'Who captained Barcelona for many years?',
      'answers': ['Xavi', 'Iniesta', 'Messi', 'Puyol'],
      'correctAnswer': 'Puyol'
    },
    {
      'questionText': 'Which year was FC Barcelona founded?',
      'answers': ['1899', '1905', '1910', '1888'],
      'correctAnswer': '1899'
    },
    {
      'questionText': 'Who is Barcelona\'s biggest rival?',
      'answers': ['Real Madrid', 'Atletico Madrid', 'Sevilla', 'Valencia'],
      'correctAnswer': 'Real Madrid'
    },
  ];

  final List<Map<String, Object>> hardQuestions = [
    {
      'questionText': 'Who scored in the 2009 Champions League final?',
      'answers': ['Messi', 'Eto’o', 'Henry', 'Xavi'],
      'correctAnswer': 'Eto’o'
    },
    {
      'questionText': 'Which coach led Barcelona to the 2009 sextuple?',
      'answers': ['Pep Guardiola', 'Luis Enrique', 'Cruyff', 'Rijkaard'],
      'correctAnswer': 'Pep Guardiola'
    },
    {
      'questionText': 'Against which team did Barcelona complete the 6–1 comeback?',
      'answers': ['PSG', 'Chelsea', 'Bayern', 'Juventus'],
      'correctAnswer': 'PSG'
    },
    {
      'questionText': 'Who is known as the architect of tiki-taka?',
      'answers': ['Pep Guardiola', 'Cruyff', 'Xavi', 'Iniesta'],
      'correctAnswer': 'Cruyff'
    },
    {
      'questionText': 'Which year did Barcelona win their first Champions League?',
      'answers': ['1992', '1985', '2006', '1974'],
      'correctAnswer': '1992'
    },
  ];

  List<Map<String, Object>> getQuestions() {
    switch (widget.difficulty) {
      case 'Medium':
        return mediumQuestions;
      case 'Hard':
        return hardQuestions;
      case 'Easy':
      default:
        return easyQuestions;
    }
  }

  int _questionIndex = 0;
  int _score = 0;


  void _answerQuestion(String selectedAnswer) {
    setState(() {
      final currentQuestions = getQuestions();
      if (currentQuestions[_questionIndex]['correctAnswer'] ==
          selectedAnswer) {
        _score++;
      }
      _questionIndex++;
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentQuestions = getQuestions();

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: _questionIndex < currentQuestions.length
              ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                currentQuestions[_questionIndex]['questionText'] as String,
                style: const TextStyle(color: Colors.white, fontSize: 24),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              ...(currentQuestions[_questionIndex]['answers']
              as List<String>)
                  .map(
                    (answer) =>
                    ElevatedButton(
                      onPressed: () => _answerQuestion(answer),
                      child: Text(answer),
                    ),
              ),
            ],
          )
              : Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Quiz Finished!',
                style: TextStyle(
                  fontSize: 26,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Your Score: $_score / ${currentQuestions.length}',
                style: const TextStyle(
                  fontSize: 22,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 20),

              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                ),
                onPressed: () {
                  setState(() {
                    _questionIndex = 0;
                    _score = 0;
                  });
                },
                child: const Text('Restart'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
