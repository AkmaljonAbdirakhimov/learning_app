import 'package:flutter/material.dart';
import 'package:learning_app/models/course.dart';
import 'package:learning_app/models/quiz_question.dart';

class CourseViewModel with ChangeNotifier {
  final List<Course> _courses = [];
  List<Course> get courses => [..._courses];

  void addCourse({
    required String title,
    required String description,
    required List<String> objectives,
    required List<String> lessons,
    required String previewVideoUrl,
    required List<QuizQuestion> questions,
  }) {
    _courses.add(Course(
      id: UniqueKey().toString(),
      title: title,
      description: description,
      objectives: objectives,
      lessons: lessons,
      previewVideoUrl: previewVideoUrl,
      questions: questions,
    ));
    notifyListeners();
  }

  void updateCourse({
    required String id,
    required String title,
    required String description,
    required List<String> objectives,
    required List<String> lessons,
    required String previewVideoUrl,
    required List<QuizQuestion> questions,
  }) {
    final index = _courses.indexWhere((course) => course.id == id);
    if (index != -1) {
      _courses[index] = Course(
        id: id,
        title: title,
        description: description,
        objectives: objectives,
        lessons: lessons,
        previewVideoUrl: previewVideoUrl,
        questions: questions,
      );
    }
    notifyListeners();
  }

  void updateProgress({required String id, required double progress}) {
    final index = _courses.indexWhere((course) => course.id == id);
    if (index != -1) {
      _courses[index] = _courses[index].copyWith(progress: progress);
    }
    notifyListeners();
  }

  void deleteCourse(String id) {
    _courses.removeWhere((course) => course.id == id);
    notifyListeners();
  }
}
