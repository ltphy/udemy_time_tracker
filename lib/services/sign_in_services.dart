import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class BaseAuth {
  User? get currentUser;

  Stream<User?> get streamUser;

  Future<User?> signInAnonymous();

  Future<User?> signInWithGoogle();

  Future<User?> signInWithFacebook();

  Future<User?> signInWithEmail(
      {required String email, required String password});

  Future<User?> registerNewAccount(
      {required String email, required String password});

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
    final googleSigIn = GoogleSignIn();
    await googleSigIn.signOut();
    await FacebookAuth.instance.logOut();
    await _firebaseAuth.signOut();
  }

  @override
  Future<User?> signInWithGoogle() async {
    // create google sign in object
    final googleSignIn = GoogleSignIn();
    // create google sign in process;
    final googleUser = await googleSignIn.signIn();
    if (googleUser != null) {
      // get google auth
      final googleAuth = await googleUser.authentication;
      // accesstoken to send to firebase auth with id token
      if (googleAuth.idToken != null) {
        final userCredential = await _firebaseAuth.signInWithCredential(
            GoogleAuthProvider.credential(
                idToken: googleAuth.idToken,
                accessToken: googleAuth.accessToken));
        return userCredential.user;
      } else {
        // Missing google ID token
        throw FirebaseAuthException(
          code: describeEnum(ERROR_CODE.ERROR_MISSING_GOOGLE_ID_TOKEN),
          message: 'Missing Google ID token',
        );
      }
    } else {
      // cancel sign in button
      throw FirebaseAuthException(
        code: describeEnum(ERROR_CODE.ERROR_ABORTED_BY_USER),
        message: 'Sign in aborted by user',
      );
    }
  }

  @override
  Future<User?> signInWithFacebook() async {
    final LoginResult result = await FacebookAuth.instance.login();
    switch (result.status) {
      case LoginStatus.success:
        if (result.accessToken != null) {
          final userCredential = await _firebaseAuth.signInWithCredential(
              FacebookAuthProvider.credential(result.accessToken?.token ?? ''));
          return userCredential.user;
        }
        break;
      case LoginStatus.cancelled:
        // cancel sign in session
        throw FirebaseAuthException(
          code: describeEnum(ERROR_CODE.ERROR_ABORTED_BY_USER),
          message: result.message.toString(),
        );
      case LoginStatus.failed:
        // login failed because invalid?
        throw FirebaseAuthException(
          code: describeEnum(ERROR_CODE.ERROR_FACEBOOK_LOGIN_FAILED),
          message: result.message.toString(),
        );
      default:
        throw UnimplementedError();
    }
  }

  @override
  Future<User?> signInWithEmail(
      {required String email, required String password}) async {
    if (email.isEmpty || password.isEmpty) return null;

    UserCredential userCredential = await this
        ._firebaseAuth
        .signInWithEmailAndPassword(email: email, password: password);
    return userCredential.user;
  }

  @override
  Future<User?> registerNewAccount(
      {required String email, required String password}) async {
    if (email.isEmpty || password.isEmpty) return null;
    try {
      UserCredential userCredential = await this
          ._firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      return userCredential.user;
    } on FirebaseAuthException catch (error) {
      // cancel sign in session
      switch (error.code) {
        case 'weak-password':
          throw ('The password provided is too weak.');
        case 'email-already-in-use':
          throw ('The account already exists for that email.');
      }
    }
  }
}

enum ERROR_CODE {
  ERROR_MISSING_GOOGLE_ID_TOKEN,
  ERROR_ABORTED_BY_USER,
  ERROR_FACEBOOK_LOGIN_FAILED
}
