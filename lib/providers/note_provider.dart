import 'package:flutter/material.dart';
import 'package:learning_app/viewmodels/note_viewmodel.dart';

class NoteProvider extends InheritedNotifier<NoteViewModel> {
  final NoteViewModel provider;

  const NoteProvider({
    super.key,
    required this.provider,
    required super.child,
  }) : super(notifier: provider);

  static NoteViewModel of(BuildContext context, {bool listen = true}) {
    return context
        .dependOnInheritedWidgetOfExactType<NoteProvider>()!
        .provider;
  }

  @override
  bool updateShouldNotify(NoteProvider oldWidget) {
    return oldWidget.provider != provider;
  }
}
