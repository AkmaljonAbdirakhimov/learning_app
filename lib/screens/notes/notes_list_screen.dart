import 'package:flutter/material.dart';
import 'package:learning_app/providers/note_provider.dart';
import 'package:learning_app/screens/notes/note_details_screen.dart';

class NotesListScreen extends StatefulWidget {
  const NotesListScreen({super.key});

  @override
  State<NotesListScreen> createState() => _NotesListScreenState();
}

class _NotesListScreenState extends State<NotesListScreen> {
  @override
  Widget build(BuildContext context) {
    final noteViewModel = NoteProvider.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Note List'),
      ),
      body: noteViewModel.notes.isNotEmpty
          ? ListView.builder(
              itemCount: noteViewModel.notes.length,
              itemBuilder: (context, index) {
                final note = noteViewModel.notes[index];
                return ListTile(
                  title: Text(note.note),
                  subtitle: Text(note.date.toString()),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NoteDetailScreen(note: note),
                      ),
                    );
                  },
                );
              },
            )
          : const Center(
              child: Text('No data available'),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }
}
