import 'package:firebase_auth/firebase_auth.dart';

abstract class BaseAuth {
  User? get currentUser;

  Future<User?> signInAnonymous();

  Future<void> signOut();
}

class Auth extends BaseAuth {
  final _firebaseAuth = FirebaseAuth.instance;

  @override
  User? get currentUser => _firebaseAuth.currentUser;

  Stream<User?> get streamUser => _firebaseAuth.userChanges();

  // allow firebase console to access
  @override
  Future<User?> signInAnonymous() async {
    final userCredentials = await _firebaseAuth.signInAnonymously();
    return userCredentials.user;
  }

  @override
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}
