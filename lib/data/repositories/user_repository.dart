import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:blog_app/data/models/user.dart' as appUser;

import 'auth_repository.dart';

class UserRepository {
  final authRepository = AuthRepository();
  final CollectionReference _usersCollection =
      FirebaseFirestore.instance.collection('users');

  Future<void> addUser(appUser.User user) async {
    await _usersCollection.doc(user.id).set(user.toMap());
  }

  Future<appUser.User?> getCurrentUser() async {
    try {
      var user = await authRepository.getCurrentUser();
      if (user != null) {
        var userData = await _usersCollection
            .doc(user.uid)
            .get(); //dokumanin uidsi userin uidsine esit olacak
        if (userData.exists) {
          return appUser.User.fromMap(
              userData.data() as Map<String, dynamic>, user.uid);
        }
      }
    } catch (e) {
      print(e);
    }
    return null;
  }
}
