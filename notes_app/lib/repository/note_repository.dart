class NoteRepository {
  final uid = FirebaseAuth.instance.currentUser!.uid;
  final CollectionReference notesRef = FirebaseFirestore.instance.collection('users');

  Future<List<Note>> getNotes() async {
    final snapshot = await notesRef.doc(uid).collection('notes').get();
    return snapshot.docs.map((doc) => Note.fromMap(doc.id, doc.data() as Map<String, dynamic>)).toList();
  }

  Future<void> addNote(String text) async {
    await notesRef.doc(uid).collection('notes').add({'text': text});
  }

  Future<void> updateNote(String id, String text) async {
    await notesRef.doc(uid).collection('notes').doc(id).update({'text': text});
  }

  Future<void> deleteNote(String id) async {
    await notesRef.doc(uid).collection('notes').doc(id).delete();
  }
}
