import 'package:flutter/material.dart';
import 'package:learning_app/models/course.dart';
import 'package:learning_app/widgets/quiz_question_widget.dart';

class QuizScreen extends StatefulWidget {
  final Course course;

  const QuizScreen({super.key, required this.course});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int currentIndex = 0;
  int correctAnswers = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz: ${widget.course.title}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            QuizQuestionWidget(
              question: widget.course.questions[currentIndex],
              onAnswerSelected: (isCorrect) {
                setState(() {
                  if (isCorrect) {
                    correctAnswers++;
                  }
                  if (currentIndex < widget.course.questions.length - 1) {
                    currentIndex++;
                  } else {
                    // Quiz completed, show result
                    _showResultDialog();
                  }
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showResultDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Quiz Completed'),
          content: Text(
              'You answered $correctAnswers out of ${widget.course.questions.length} questions correctly.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context); // Pop quiz screen
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }
}
