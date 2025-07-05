import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/notes_cubit.dart';
import '../cubit/auth_cubit.dart';
import '../models/note_model.dart';
import '../widgets/note_tile.dart';

class NotesScreen extends StatelessWidget {
  final noteCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Notes"),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            tooltip: 'Logout',
            onPressed: () {
              context.read<AuthCubit>().logout();
              Navigator.pushReplacementNamed(context, '/');
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Logged out successfully")),
              );
            },
          ),
        ],
      ),
      body: BlocBuilder<NotesCubit, NotesState>(
        builder: (context, state) {
          if (state is NotesLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is NotesLoaded) {
            final notes = state.notes;
            if (notes.isEmpty) {
              return Center(
                child: Text(
                  "Nothing here yet—tap ➕ to add a note.",
                  style: TextStyle(fontSize: 16),
                ),
              );
            }
            return ListView.builder(
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
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text("Note updated")),
                              );
                            },
                            child: Text("Update"),
                          )
                        ],
                      ),
                    );
                  },
                  onDelete: () {
                    showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                        title: Text("Confirm Delete"),
                        content: Text("Are you sure you want to delete this note?"),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: Text("Cancel"),
                          ),
                          TextButton(
                            onPressed: () {
                              context.read<NotesCubit>().deleteNote(note.id);
                              Navigator.pop(context);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text("Note deleted"),
                                  backgroundColor: Colors.redAccent,
                                ),
                              );
                            },
                            child: Text("Delete", style: TextStyle(color: Colors.red)),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            );
          }
          return Center(child: Text("Unexpected state"));
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blueAccent,
        child: Icon(Icons.add, color: Colors.white),
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
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Note added"),
                        backgroundColor: Colors.green,
                      ),
                    );
                  },
                  child: Text("Save"),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
