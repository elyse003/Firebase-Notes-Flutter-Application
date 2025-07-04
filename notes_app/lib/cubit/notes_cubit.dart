class NotesCubit extends Cubit<List<Note>> {
  final NoteRepository _repo;

  NotesCubit(this._repo) : super([]);

  Future<void> fetchNotes() async {
    try {
      emit(await _repo.getNotes());
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
