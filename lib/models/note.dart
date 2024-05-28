import 'package:json_annotation/json_annotation.dart';

part 'note.g.dart';

@JsonSerializable()
class Note {
  final String id;
  String note;
  DateTime date;

  Note({
    required this.id,
    required this.note,
    required this.date,
  });

  factory Note.fromJson(Map<String, dynamic> json) {
    return _$NoteFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$NoteToJson(this);
  }

  Note copyWith({
    String? id,
    String? note,
    DateTime? date,
  }) {
    return Note(
      id: id ?? this.id,
      note: note ?? this.note,
      date: date ?? this.date,
    );
  }
}
