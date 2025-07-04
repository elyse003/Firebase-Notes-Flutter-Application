import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthCubit extends Cubit<User?> {
  AuthCubit() : super(null);

  Future<void> signUp(String email, String password) async {
    final cred = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
    emit(cred.user);
  }

  Future<void> login(String email, String password) async {
    final cred = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
    emit(cred.user);
  }

  void logout() async {
    await FirebaseAuth.instance.signOut();
    emit(null);
  }
}
