import 'package:flutter/material.dart';
import 'package:learning_app/models/quiz_question.dart';

class QuizQuestionWidget extends StatefulWidget {
  final QuizQuestion question;
  final ValueChanged<bool> onAnswerSelected;

  const QuizQuestionWidget({
    super.key,
    required this.question,
    required this.onAnswerSelected,
  });

  @override
  State<QuizQuestionWidget> createState() => _QuizQuestionWidgetState();
}

class _QuizQuestionWidgetState extends State<QuizQuestionWidget> {
  int? _selectedOptionIndex;

  @override
  void didUpdateWidget(covariant QuizQuestionWidget oldWidget) {
    super.didUpdateWidget(oldWidget);

    _selectedOptionIndex = null;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.question.question,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: List.generate(
            widget.question.options.length,
            (index) => GestureDetector(
              onTap: () {
                setState(() {
                  _selectedOptionIndex = index;
                  Future.delayed(const Duration(milliseconds: 500), () {
                    widget.onAnswerSelected(
                      index == widget.question.correctOptionIndex,
                    );
                  });
                });
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                margin: const EdgeInsets.symmetric(vertical: 5),
                decoration: BoxDecoration(
                  color: _selectedOptionIndex == index
                      ? Colors.blue
                      : Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.blue),
                ),
                child: Text(
                  widget.question.options[index],
                  style: TextStyle(
                    fontSize: 16,
                    color: _selectedOptionIndex == index
                        ? Colors.white
                        : Colors.black,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
