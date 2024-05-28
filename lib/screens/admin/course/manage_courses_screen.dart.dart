// lib/screens/admin_screen.dart
import 'package:flutter/material.dart';
import 'package:learning_app/providers/course_provider.dart';
import 'package:learning_app/screens/admin/course/edit_add_course_screen.dart';

class ManageCoursesScreen extends StatefulWidget {
  const ManageCoursesScreen({super.key});

  @override
  State<ManageCoursesScreen> createState() => _ManageCoursesScreenState();
}

class _ManageCoursesScreenState extends State<ManageCoursesScreen> {
  @override
  Widget build(BuildContext context) {
    final courseViewModel = CourseProvider.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage Courses'),
      ),
      body: courseViewModel.courses.isNotEmpty
          ? ListView.builder(
              itemCount: courseViewModel.courses.length,
              itemBuilder: (context, index) {
                final course = courseViewModel.courses[index];
                return ListTile(
                  title: Text(course.title),
                  subtitle: Text(course.description),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (ctx) => EditAddCourseScreen(
                                course: course,
                              ),
                            ),
                          );
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (ctx) => AlertDialog(
                              title: const Text("Are you sure?"),
                              content: Text(
                                  "You're about to delete ${course.title}"),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text('Cancel'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    courseViewModel.deleteCourse(course.id);
                                    Navigator.pop(context);
                                  },
                                  child: const Text('Sure!'),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                );
              },
            )
          : const Center(
              child: Text('No data available'),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (ctx) => const EditAddCourseScreen(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
