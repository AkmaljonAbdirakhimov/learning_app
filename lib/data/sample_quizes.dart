import 'dart:convert';

import 'package:learning_app/models/quiz_question.dart';

final List<QuizQuestion> sampleQuizQuestions =
    (jsonDecode(quizQuestionsJson) as List<dynamic>)
        .map((e) => QuizQuestion.fromJson(e as Map<String, dynamic>))
        .toList();

const String quizQuestionsJson = '''
[
  {
    "question": "What is Flutter?",
    "options": ["A framework", "A programming language", "A bird", "An operating system"],
    "correctOptionIndex": 0
  },
  {
    "question": "What does Dart compile to?",
    "options": ["Machine code", "JavaScript", "Bytecode", "Assembly code"],
    "correctOptionIndex": 2
  },
  {
    "question": "What is a StatelessWidget in Flutter?",
    "options": ["A widget that can change its state", "A widget that cannot change its state", "A widget that listens to user input", "A widget that interacts with the database"],
    "correctOptionIndex": 1
  },
  {
    "question": "What is the parent class of all widgets in Flutter?",
    "options": ["State", "Widget", "Object", "BuildContext"],
    "correctOptionIndex": 2
  },
  {
    "question": "Which widget is used to create a row of widgets with evenly spaced gaps?",
    "options": ["Row", "Column", "Spacer", "Padding"],
    "correctOptionIndex": 2
  }
]
''';
