import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class AuthService {
  final _firebaseAuth = FirebaseAuth.instance;

  Future<User?> createUserWithEmailAndPassword(String email,
      String password) async {
    try {
      final cred = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      return cred.user;
    } on FirebaseAuthException catch (e) {

      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
    return null;
  }

  Future<User?> loginUserWithEmailAndPassword(String email,
      String password) async {
    try {
      final cred = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return cred.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    } catch(e) {
      print(e);
    }
    return null;
  }
}
