import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:learning_app/providers/course_provider.dart';
import 'package:learning_app/screens/course/course_details_screen.dart';
import 'package:learning_app/screens/notes/notes_list_screen.dart';
import 'package:learning_app/screens/quiz/quiz_list_screen.dart';
import 'package:learning_app/screens/weather_screen.dart';
import 'package:learning_app/widgets/custom_drawer.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen>
    with WidgetsBindingObserver {
  bool isShowDialogOpen = false;
  final List<Map<String, dynamic>> titles = [
    {
      "title": "Tasks",
      "page": const CorrespondingScreen(
        title: "Tasks",
      ),
    },
    {
      "title": "Notes",
      "page": const NotesListScreen(),
    },
    {
      "title": "Weather",
      "page": const WeatherScreen(),
    },
    {
      "title": "Quiz",
      "page": const QuizListScreen(),
    },
  ];

  final List<IconData> icons = [
    Icons.check_circle,
    Icons.note,
    Icons.cloud,
    Icons.quiz,
  ];

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addObserver(this);
  }

  void showAppLifecycleDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: const Text("App Life Cycle Changed"),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                isShowDialogOpen = false;
                setState(() {});
                Navigator.pop(context);
              },
              child: const Text("Thank You!"),
            ),
          ],
        );
      },
    );

    isShowDialogOpen = true;
    setState(() {});
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    // String message = "";
    // if (state == AppLifecycleState.resumed) {
    //   message = "Resumed: Welcome back to app";
    // } else if (state == AppLifecycleState.inactive) {
    //   message = "Inactive: See you soon";
    // }

    // if (isShowDialogOpen) {
    //   Navigator.pop(context);
    // }
    // showAppLifecycleDialog(message);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Builder(builder: (context) {
          return Text(AppLocalizations.of(context)!.hello("Alex"));
        }),
        actions: [
          IconButton(
            onPressed: () {
              AdaptiveTheme.of(context).toggleThemeMode();
            },
            icon: Icon(Icons.dark_mode),
          ),
        ],
      ),
      drawer: const CustomDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Localizations.override(
              context: context,
              locale: const Locale("uz"),
              child: Builder(builder: (context) {
                return Text(
                  AppLocalizations.of(context)!.nKebabs(1),
                );
              }),
            ),
            Expanded(
              flex: 5,
              child: buildGridViewBuilder(),
            ),
            Expanded(
              flex: 3,
              child: buildCoursesList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildGridViewBuilder() {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      physics: const NeverScrollableScrollPhysics(),
      itemCount: titles.length,
      itemBuilder: (context, index) {
        return GridTile(
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => titles[index]['page'],
                ),
              );
            },
            child: Card(
              color: Colors.blue.shade200,
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      icons[index],
                      size: 40,
                      color: Colors.white,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      titles[index]['title'],
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget buildCoursesList() {
    final courseViewModel = CourseProvider.of(context, listen: false);
    return courseViewModel.courses.isNotEmpty
        ? ListView.builder(
            itemCount: courseViewModel.courses.length,
            itemBuilder: (context, index) {
              final course = courseViewModel.courses[index];
              return ListTile(
                title: Text(course.title),
                subtitle: Text(
                    'Progress: ${(course.progress * 100).toStringAsFixed(2)}%'),
                trailing: const Icon(Icons.arrow_forward),
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
        : const Center(child: Text('No data available'));
  }
}

class CorrespondingScreen extends StatelessWidget {
  final String title;

  const CorrespondingScreen({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Text('Content for $title'),
      ),
    );
  }
}
