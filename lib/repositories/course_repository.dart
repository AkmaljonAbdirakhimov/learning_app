// lib/repositories/course_repository.dart
import 'package:learning_app/models/course.dart';
import 'package:learning_app/services/course_api_services.dart';

class CourseRepository {
  Future<List<Course>> fetchCourses() async {
    return await CourseApiServices.fetchCourses();
  }
}
