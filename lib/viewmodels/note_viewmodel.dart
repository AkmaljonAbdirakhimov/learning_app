import 'package:flutter/material.dart';
import 'package:learning_app/models/note.dart';

class NoteViewModel with ChangeNotifier {
  final List<Note> _notes = [];
  List<Note> get notes => [..._notes];

  void addNote({
    required String note,
  }) {
    _notes.add(Note(
      id: UniqueKey().toString(),
      note: note,
      date: DateTime.now(),
    ));
    notifyListeners();
  }

  void updateNote({
    required String id,
    required String note,
  }) {
    final index = _notes.indexWhere((note) => note.id == id);
    if (index != -1) {
      _notes[index] = Note(
        id: id,
        note: note,
        date: DateTime.now(),
      );
    }
    notifyListeners();
  }

  void deleteNote(String id) {
    _notes.removeWhere((note) => note.id == id);
    notifyListeners();
  }
}
