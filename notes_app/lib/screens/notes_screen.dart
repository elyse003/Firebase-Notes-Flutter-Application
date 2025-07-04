import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/notes_cubit.dart';
import '../widgets/note_tile.dart';

class NotesScreen extends StatelessWidget {
  final noteCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final notesCubit = context.watch<NotesCubit>();
    final notes = notesCubit.state;

    return Scaffold(
      appBar: AppBar(title: Text("Your Notes")),
      body: notes.isEmpty
          ? Center(child: Text("Nothing here yet—tap ➕ to add a note."))
          : ListView.builder(
              itemCount: notes.length,
              itemBuilder: (_, i) {
                final note = notes[i];
                return NoteTile(
                  note: note,
                  onEdit: () {
                    noteCtrl.text = note.text;
                    showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                        title: Text("Edit Note"),
                        content: TextField(controller: noteCtrl),
                        actions: [
                          TextButton(
                              onPressed: () {
                                context.read<NotesCubit>().updateNote(note.id, noteCtrl.text);
                                Navigator.pop(context);
                              },
                              child: Text("Update"))
                        ],
                      ),
                    );
                  },
                  onDelete: () {
                    context.read<NotesCubit>().deleteNote(note.id);
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Note deleted")));
                  },
                );
              }),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          noteCtrl.clear();
          showDialog(
            context: context,
            builder: (_) => AlertDialog(
              title: Text("New Note"),
              content: TextField(controller: noteCtrl),
              actions: [
                TextButton(
                    onPressed: () {
                      context.read<NotesCubit>().addNote(noteCtrl.text);
                      Navigator.pop(context);
                    },
                    child: Text("Save"))
              ],
            ),
          );
        },
      ),
    );
  }
}
