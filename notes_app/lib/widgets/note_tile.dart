import 'package:flutter/material.dart';
import '../models/note_model.dart';

class NoteTile extends StatelessWidget {
  final Note note;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const NoteTile({required this.note, required this.onEdit, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(note.text),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(icon: Icon(Icons.edit), onPressed: onEdit),
          IconButton(icon: Icon(Icons.delete), onPressed: onDelete),
        ],
      ),
    );
  }
}
