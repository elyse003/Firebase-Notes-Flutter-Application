import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/note_model.dart';
import '../repository/note_repository.dart';

class NotesCubit extends Cubit<List<Note>> {
  final NoteRepository _repo;
  NotesCubit(this._repo) : super([]);

  Future<void> fetchNotes() async {
    try {
      final notes = await _repo.getNotes();
      emit(notes);
    } catch (_) {
      emit([]);
    }
  }

  Future<void> addNote(String text) async {
    await _repo.addNote(text);
    fetchNotes();
  }

  Future<void> updateNote(String id, String text) async {
    await _repo.updateNote(id, text);
    fetchNotes();
  }

  Future<void> deleteNote(String id) async {
    await _repo.deleteNote(id);
    fetchNotes();
  }
}
