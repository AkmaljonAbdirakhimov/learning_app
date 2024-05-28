import 'package:flutter/material.dart';
import 'package:learning_app/providers/course_provider.dart';
import 'package:learning_app/screens/quiz/quiz_screen.dart';

class QuizListScreen extends StatelessWidget {
  const QuizListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final courseViewModel = CourseProvider.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quizes'),
      ),
      body: courseViewModel.courses.isNotEmpty
          ? ListView.builder(
              itemCount: courseViewModel.courses.length,
              itemBuilder: (context, index) {
                final course = courseViewModel.courses[index];
                return ListTile(
                  title: Text(course.title),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => QuizScreen(
                          course: course,
                        ),
                      ),
                    );
                  },
                );
              },
            )
          : const Center(
              child: Text('No data available'),
            ),
    );
  }
}
