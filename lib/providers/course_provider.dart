import 'package:flutter/material.dart';
import 'package:learning_app/viewmodels/course_viewmodel.dart';

class CourseProvider extends InheritedNotifier<CourseViewModel> {
  final CourseViewModel provider;

  const CourseProvider({
    super.key,
    required this.provider,
    required super.child,
  }) : super(notifier: provider);

  static CourseViewModel of(BuildContext context, {bool listen = true}) {
    return context
        .dependOnInheritedWidgetOfExactType<CourseProvider>()!
        .provider;
  }

  @override
  bool updateShouldNotify(CourseProvider oldWidget) {
    return oldWidget.provider != provider;
  }
}
