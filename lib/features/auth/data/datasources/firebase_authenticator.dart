import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../../core/domain/usecases/usecase_params.dart';
import '../../../../core/errors/exceptions.dart';
import 'authenticator.dart';

class FirebaseAuthenticator implements Authenticator {
  final FirebaseAuth firebaseAuthInstance = FirebaseAuth.instance;
  final _googleSignInInstance = GoogleSignIn();

  @override
  Future<User> googleSignIn() async {
    try {
      final GoogleSignInAccount? googleUser =
          await _googleSignInInstance.signIn();
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final credentials = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      await firebaseAuthInstance.signInWithCredential(credentials);
      return firebaseAuthInstance.currentUser!;
    } catch (e) {
      log(e.toString());
      throw const AuthException();
    }
  }

  @override
  Future<User> signIn(AuthParams params) async {
    try {
      await firebaseAuthInstance.signInWithEmailAndPassword(
          email: params.email, password: params.password);
      return firebaseAuthInstance.currentUser!;
    } on FirebaseException catch (e) {
      if (e.code == 'user-not-found') {
        throw const AuthException(message: 'No user found for that email.');
      } else if (e.code == 'wrong-password') {
        throw const AuthException(
            message: 'Wrong password provided for that user.');
      }
    }
    throw const AuthException(
      message: "Invalid Credentials",
    );
  }

  @override
  Future<User> signUp(AuthParams params) async {
    try {
      await firebaseAuthInstance.createUserWithEmailAndPassword(
          email: params.email, password: params.password);

      return firebaseAuthInstance.currentUser!;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw const AuthException(
            message: 'The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        throw const AuthException(
            message: 'The account already exists for that email.');
      }
    }
    throw const AuthException(
      message: "Invalid Credentials",
    );
  }

  @override
  Future<void> signOut() async {
    try {
      if (_googleSignInInstance.currentUser != null) {
        _googleSignInInstance.disconnect();
      }
      firebaseAuthInstance.signOut();
    } on FirebaseException catch (e) {
      throw AuthException(message: e.message);
    }
  }
}
