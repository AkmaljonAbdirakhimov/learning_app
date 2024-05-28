import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:learning_app/utils/app_constants.dart';
import 'package:learning_app/models/course.dart';

class CourseApiServices {
  static Future<List<Course>> fetchCourses() async {
    final url = Uri.parse("${AppConstants.baseUrl}/courses.json");
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        List<Course> loadedCourses = [];
        data.forEach((key, value) {
          value['id'] = key;
          loadedCourses.add(Course.fromJson(value));
        });
        return loadedCourses;
      } else {
        throw (jsonDecode(response.body)['error']);
      }
    } catch (e) {
      rethrow;
    }
  }
}
