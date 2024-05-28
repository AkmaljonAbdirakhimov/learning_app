import 'package:flutter/material.dart';
import 'package:learning_app/models/note.dart';

class NoteDetailScreen extends StatefulWidget {
  final Note? note;

  const NoteDetailScreen({super.key, required this.note});

  @override
  State<NoteDetailScreen> createState() {
    return _NoteDetailScreenState();
  }
}

class _NoteDetailScreenState extends State<NoteDetailScreen> {
  late TextEditingController _noteController;

  @override
  void initState() {
    super.initState();

    _noteController = TextEditingController();
  }

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.note?.note ?? ""),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Note',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    // Handle starting the note
                  },
                  child: const Text('Start Note'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
