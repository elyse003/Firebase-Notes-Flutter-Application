class AuthCubit extends Cubit<User?> {
  AuthCubit() : super(null);

  Future<void> signUp(String email, String password) async {
    try {
      final cred = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
      emit(cred.user);
    } catch (e) {
      emit(null);
      rethrow;
    }
  }

  Future<void> login(String email, String password) async {
    try {
      final cred = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
      emit(cred.user);
    } catch (e) {
      emit(null);
      rethrow;
    }
  }

  void logout() async {
    await FirebaseAuth.instance.signOut();
    emit(null);
  }
}
