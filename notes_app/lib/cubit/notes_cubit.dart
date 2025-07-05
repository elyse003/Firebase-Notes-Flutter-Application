import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/note_model.dart';
import '../repository/note_repository.dart';

abstract class NotesState {}

class NotesLoading extends NotesState {}

class NotesLoaded extends NotesState {
  final List<Note> notes;
  NotesLoaded(this.notes);
}

class NotesCubit extends Cubit<NotesState> {
  final NoteRepository _repo;

  NotesCubit(this._repo) : super(NotesLoading());

  Future<void> fetchNotes() async {
    emit(NotesLoading());
    try {
      final notes = await _repo.getNotes();
      emit(NotesLoaded(notes));
    } catch (_) {
      emit(NotesLoaded([])); // fallback in case of error
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
