import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

abstract class BaseAuth {
  User? get currentUser;

  Stream<User?> get streamUser;

  Future<User?> signInAnonymous();

  Future<User?> signInWithGoogle();

  Future<User?> signInWithFacebook();

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
    try {
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
          throw FirebaseAuthException(
            code: 'ERROR_MISSING_GOOGLE_ID_TOKEN',
            message: 'Missing Google ID token',
          );
        }
      } else {
        throw FirebaseAuthException(
          code: 'ERROR_ABORTED_BY_USER',
          message: 'Sign in aborted by user',
        );
      }
    } catch (error) {
      throw (error);
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
        throw FirebaseAuthException(
          code: 'ERROR_LOGIN_IN_CANCELLED',
          message: 'Sign in aborted by user',
        );
      case LoginStatus.failed:
        throw FirebaseAuthException(
          code: 'ERROR_FACEBOOK_LOGIN_FAILED',
          message: result.message.toString(),
        );
      default:
        throw UnimplementedError();
    }
  }
}
