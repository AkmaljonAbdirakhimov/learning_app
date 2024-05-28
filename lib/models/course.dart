import 'package:json_annotation/json_annotation.dart';
import 'package:learning_app/models/quiz_question.dart';

part 'course.g.dart';

@JsonSerializable()
class Course {
  final String id;
  final String title;
  final String description;
  final List<String> objectives;
  final List<String> lessons;
  final String previewVideoUrl;
  final List<QuizQuestion> questions;
  double progress;

  Course({
    required this.id,
    required this.title,
    required this.description,
    required this.objectives,
    required this.lessons,
    required this.previewVideoUrl,
    required this.questions,
    this.progress = 0.0,
  });

  factory Course.fromJson(Map<String, dynamic> json) {
    return _$CourseFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$CourseToJson(this);
  }

  Course copyWith({
    String? id,
    String? title,
    String? description,
    List<String>? objectives,
    List<String>? lessons,
    String? previewVideoUrl,
    List<QuizQuestion>? questions,
    double? progress,
  }) {
    return Course(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.title,
      objectives: objectives ?? this.objectives,
      lessons: lessons ?? this.lessons,
      previewVideoUrl: previewVideoUrl ?? this.previewVideoUrl,
      questions: questions ?? this.questions,
      progress: progress ?? this.progress,
    );
  }

  // factory Course.fromJson(Map<String, dynamic> json) {
  //   return Course(
  //     title: json['title'],
  //     description: json['description'],
  //     objectives: json['objectives'],
  //     lessons: json['lessons'],
  //     previewVideoUrl: json['previewVideoUrl'],
  //     progress: json['progress'],
  //   );
  // }

  // Map<String, dynamic> toJson() {
  //   return {
  //     "title": title,
  //     "description": description,
  //     "objectives": objectives,
  //     "lessons": lessons,
  //     "previewVideoUrl": previewVideoUrl,
  //     "progress": progress,
  //   };
  // }
}
