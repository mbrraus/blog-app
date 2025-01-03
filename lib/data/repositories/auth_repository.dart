import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository {
  final _firebaseAuth = FirebaseAuth.instance;

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  Future<void> signOut() async {
    if (_firebaseAuth.currentUser != null) {
      var userEmail = _firebaseAuth.currentUser?.email;
      await _firebaseAuth.signOut();
      print('user signed out: $userEmail');
    } else {
      print("there is no signed in user");
    }
  }

  Future<User?> getCurrentUser() async {
    print('here is the current user: ${_firebaseAuth.currentUser}');
    return _firebaseAuth.currentUser;
  }

  Future<User?> createUserWithEmailAndPassword(
      String email, String password) async {
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

  Future<User?> loginUserWithEmailAndPassword(
      String email, String password) async {
    try {
      final cred = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return cred.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      } else {
        print('something went wrong');
      }
    } catch (e) {
      print(e);
    }
    return null;
  }
}
