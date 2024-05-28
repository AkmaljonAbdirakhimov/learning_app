import 'package:flutter/material.dart';
import 'package:learning_app/viewmodels/app_state_viewmodel.dart';

class AppStateProvider extends InheritedNotifier<AppStateViewmodel> {
  final AppStateViewmodel appState;

  const AppStateProvider(
      {super.key, required this.appState, required super.child})
      : super(notifier: appState);

  static AppStateViewmodel of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<AppStateProvider>()!
        .appState;
  }

  @override
  bool updateShouldNotify(AppStateProvider oldWidget) {
    return oldWidget.appState != appState;
  }
}
