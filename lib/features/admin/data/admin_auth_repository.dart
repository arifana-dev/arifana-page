import 'package:firebase_auth/firebase_auth.dart';

abstract class AdminAuthRepository {
  Stream<User?> authStateChanges();
  User? get currentUser;
  Future<void> signIn({required String email, required String password});
  Future<void> signOut();
}

class AdminAuthRepositoryImpl implements AdminAuthRepository {
  AdminAuthRepositoryImpl({FirebaseAuth? auth})
      : _auth = auth ?? FirebaseAuth.instance;

  final FirebaseAuth _auth;

  @override
  Stream<User?> authStateChanges() => _auth.authStateChanges();

  @override
  User? get currentUser => _auth.currentUser;

  @override
  Future<void> signIn({required String email, required String password}) async {
    await _auth.signInWithEmailAndPassword(email: email, password: password);
  }

  @override
  Future<void> signOut() => _auth.signOut();
}
