import 'package:firebase_auth/firebase_auth.dart';

abstract class BaseAuth {
  User? get currentUser;

  Stream<User?> get streamUser;

  Future<User?> signInAnonymous();

  Future<void> signOut();
}

class Auth extends BaseAuth {
  final _firebaseAuth = FirebaseAuth.instance;

  @override
  User? get currentUser => _firebaseAuth.currentUser;

  @override
  Stream<User?> get streamUser => _firebaseAuth.userChanges();

  // allow firebase console to access, either sign in or out => it will update the stream
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
