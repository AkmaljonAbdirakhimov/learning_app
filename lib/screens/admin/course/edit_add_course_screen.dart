// lib/screens/admin_screen.dart
import 'package:flutter/material.dart';
import 'package:learning_app/models/course.dart';
import 'package:learning_app/models/quiz_question.dart';
import 'package:learning_app/providers/course_provider.dart';

class EditAddCourseScreen extends StatefulWidget {
  final Course? course;
  const EditAddCourseScreen({
    super.key,
    this.course,
  });

  @override
  State<EditAddCourseScreen> createState() => _EditAddCourseScreenState();
}

class _EditAddCourseScreenState extends State<EditAddCourseScreen> {
  final formKey = GlobalKey<FormState>();
  late final TextEditingController titleController;
  late final TextEditingController descriptionController;
  late final TextEditingController objectivesController;
  late final TextEditingController previewVideoUrlController;
  late final TextEditingController lessonsController;

  late final List<QuizQuestion> questions;
  late final List<TextEditingController> questionControllers;
  late final List<List<TextEditingController>> optionControllers;
  late final List<TextEditingController> correctAnswerIndexControllers;

  @override
  void initState() {
    super.initState();

    titleController = TextEditingController(text: widget.course?.title);
    descriptionController =
        TextEditingController(text: widget.course?.description);
    objectivesController =
        TextEditingController(text: widget.course?.objectives.join(', '));
    previewVideoUrlController =
        TextEditingController(text: widget.course?.previewVideoUrl);
    lessonsController =
        TextEditingController(text: widget.course?.lessons.join(', '));

    questions = widget.course?.questions ?? [];
    questionControllers =
        questions.map((q) => TextEditingController(text: q.question)).toList();
    optionControllers = questions
        .map((q) =>
            q.options.map((opt) => TextEditingController(text: opt)).toList())
        .toList();
    correctAnswerIndexControllers = questions
        .map((q) =>
            TextEditingController(text: (q.correctOptionIndex + 1).toString()))
        .toList();
  }

  void submit() {
    final courseViewModel = CourseProvider.of(context, listen: false);

    if (formKey.currentState!.validate()) {
      if (widget.course == null) {
        courseViewModel.addCourse(
          title: titleController.text,
          description: descriptionController.text,
          objectives: objectivesController.text.split(", "),
          lessons: lessonsController.text.split(", "),
          previewVideoUrl: previewVideoUrlController.text,
          questions: List.generate(
            questionControllers.length,
            (index) {
              int correctOptionIndex =
                  int.tryParse(correctAnswerIndexControllers[index].text) ?? 1;
              return QuizQuestion(
                  question: questionControllers[index].text,
                  options: List.generate(
                      4, (optIndex) => optionControllers[index][optIndex].text),
                  correctOptionIndex: correctOptionIndex - 1);
            },
          ),
        );
      } else {
        courseViewModel.updateCourse(
          id: widget.course!.id,
          title: titleController.text,
          description: descriptionController.text,
          objectives: objectivesController.text.split(", "),
          lessons: lessonsController.text.split(", "),
          previewVideoUrl: previewVideoUrlController.text,
          questions: List.generate(
            questionControllers.length,
            (index) {
              int correctOptionIndex =
                  int.tryParse(correctAnswerIndexControllers[index].text) ?? 1;
              return QuizQuestion(
                  question: questionControllers[index].text,
                  options: List.generate(
                      4, (optIndex) => optionControllers[index][optIndex].text),
                  correctOptionIndex: correctOptionIndex - 1);
            },
          ),
        );
      }
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.course == null ? 'Add Course' : 'Edit Course',
        ),
        actions: [
          IconButton(
            onPressed: submit,
            icon: const Icon(Icons.save),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(
          top: 20,
          left: 20,
          right: 20,
          bottom: MediaQuery.viewInsetsOf(context).bottom + 20,
        ),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: titleController,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Title',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Enter title";
                  }

                  return null;
                },
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: descriptionController,
                textInputAction: TextInputAction.next,
                minLines: 2,
                maxLines: 5,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Description',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Enter description";
                  }

                  return null;
                },
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: objectivesController,
                textInputAction: TextInputAction.next,
                minLines: 3,
                maxLines: 5,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Objectives (comma separated)',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Enter objectives";
                  }

                  return null;
                },
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: previewVideoUrlController,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Preview Video URL',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Enter preview video url";
                  }

                  return null;
                },
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: lessonsController,
                textInputAction: TextInputAction.next,
                minLines: 3,
                maxLines: 5,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Lessons (comma separated)',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Enter lessons";
                  }

                  return null;
                },
              ),
              const SizedBox(height: 20),
              const Text(
                'Quizes',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 20),
              ...List.generate(questionControllers.length, (index) {
                return Column(
                  children: [
                    TextFormField(
                      controller: questionControllers[index],
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        labelText: 'Question ${index + 1}',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Enter question";
                        }

                        return null;
                      },
                    ),
                    const SizedBox(height: 15),
                    ...List.generate(4, (optIndex) {
                      return Column(
                        children: [
                          TextFormField(
                            controller: optionControllers[index][optIndex],
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              border: const OutlineInputBorder(),
                              labelText: 'Option ${optIndex + 1}',
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Enter option";
                              }

                              return null;
                            },
                          ),
                          const SizedBox(height: 15),
                        ],
                      );
                    }),
                    TextFormField(
                      controller: correctAnswerIndexControllers[index],
                      textInputAction: TextInputAction.next,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Correct Option Index',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Enter correct answer index";
                        }

                        return null;
                      },
                      keyboardType: TextInputType.number,
                    ),
                    TextButton.icon(
                      icon: const Icon(Icons.delete),
                      label: Text("Question ${index + 1}"),
                      onPressed: () {
                        questionControllers.removeAt(index);
                        optionControllers.removeAt(index);
                        correctAnswerIndexControllers.removeAt(index);
                      },
                    ),
                  ],
                );
              }),
              TextButton(
                onPressed: () {
                  setState(() {
                    questionControllers.add(TextEditingController());
                    optionControllers
                        .add(List.generate(4, (_) => TextEditingController()));
                    correctAnswerIndexControllers.add(TextEditingController());
                  });
                },
                child: const Text('Add Question'),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => Navigator.of(context).pop(),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4)),
                      ),
                      child: const Text('Cancel'),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      onPressed: submit,
                      child: Text(widget.course == null ? 'Add' : 'Update'),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
