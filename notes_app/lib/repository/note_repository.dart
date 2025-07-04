import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/note_model.dart';

class NoteRepository {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  CollectionReference get _userNotes =>
      _firestore.collection('users').doc(_auth.currentUser!.uid).collection('notes');

  Future<List<Note>> getNotes() async {
    final snapshot = await _userNotes.get();
    return snapshot.docs
        .map((doc) => Note.fromMap(doc.id, doc.data() as Map<String, dynamic>))
        .toList();
  }

  Future<void> addNote(String text) async {
    await _userNotes.add({'text': text});
  }

  Future<void> updateNote(String id, String text) async {
    await _userNotes.doc(id).update({'text': text});
  }

  Future<void> deleteNote(String id) async {
    await _userNotes.doc(id).delete();
  }
}
