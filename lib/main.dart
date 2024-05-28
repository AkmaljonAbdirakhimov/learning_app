import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:learning_app/providers/course_provider.dart';
import 'package:learning_app/providers/note_provider.dart';
import 'package:learning_app/utils/app_constants.dart';
import 'package:learning_app/screens/dashboard_screen.dart';
import 'package:learning_app/viewmodels/app_state_viewmodel.dart';
import 'package:learning_app/providers/app_state_provider.dart';
import 'package:learning_app/viewmodels/course_viewmodel.dart';
import 'package:learning_app/viewmodels/note_viewmodel.dart';

void main() {
  runApp(LearningApp());
}

class LearningApp extends StatelessWidget {
  LearningApp({super.key});

  final courseViewModel = CourseViewModel();
  final noteViewModel = NoteViewModel();

  @override
  Widget build(BuildContext context) {
    return AdaptiveTheme(
        light: ThemeData.light(useMaterial3: true),
        dark: ThemeData.dark(useMaterial3: true),
        debugShowFloatingThemeButton: true,
        initial: AdaptiveThemeMode.light,
        builder: (light, dark) {
          return AppStateProvider(
            appState: AppStateViewmodel(),
            child: CourseProvider(
              provider: courseViewModel,
              child: NoteProvider(
                provider: noteViewModel,
                child: Builder(builder: (context) {
                  return MaterialApp(
                    debugShowCheckedModeBanner: false,
                    title: AppConstants.appTitle,
                    localizationsDelegates:
                        AppLocalizations.localizationsDelegates,
                    supportedLocales: AppLocalizations.supportedLocales,
                    themeMode: AppStateProvider.of(context).themeMode,
                    theme: light,
                    darkTheme: dark,
                    home: const DashboardScreen(),
                  );
                }),
              ),
            ),
          );
        });
  }
}
