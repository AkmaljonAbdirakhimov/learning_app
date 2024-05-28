import 'package:flutter/material.dart';
import 'package:learning_app/providers/course_provider.dart';
import 'package:learning_app/screens/course/course_details_screen.dart';
import 'package:learning_app/widgets/custom_drawer.dart';

class CourseListScreen extends StatefulWidget {
  const CourseListScreen({super.key});

  @override
  State<CourseListScreen> createState() => _CourseListScreenState();
}

class _CourseListScreenState extends State<CourseListScreen> {
  @override
  Widget build(BuildContext context) {
    final courseViewModel = CourseProvider.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Course List'),
      ),
      drawer: const CustomDrawer(),
      body: courseViewModel.courses.isNotEmpty
          ? ListView.builder(
              itemCount: courseViewModel.courses.length,
              itemBuilder: (context, index) {
                final course = courseViewModel.courses[index];
                return ListTile(
                  title: Text(course.title),
                  subtitle: Text(course.description),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CourseDetailScreen(
                          course: course,
                          onProgressUpdate: (progress) {
                            courseViewModel.updateProgress(
                              id: course.id,
                              progress: progress,
                            );
                          },
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
