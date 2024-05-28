// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Course _$CourseFromJson(Map<String, dynamic> json) => Course(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      objectives: (json['objectives'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      lessons:
          (json['lessons'] as List<dynamic>).map((e) => e as String).toList(),
      previewVideoUrl: json['previewVideoUrl'] as String,
      questions: (json['questions'] as List<dynamic>)
          .map((e) => QuizQuestion.fromJson(e as Map<String, dynamic>))
          .toList(),
      progress: (json['progress'] as num?)?.toDouble() ?? 0.0,
    );

Map<String, dynamic> _$CourseToJson(Course instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'objectives': instance.objectives,
      'lessons': instance.lessons,
      'previewVideoUrl': instance.previewVideoUrl,
      'questions': instance.questions,
      'progress': instance.progress,
    };
