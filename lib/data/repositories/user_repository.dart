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

  Future<appUser.User?> getUserById (String uid) async {
      try{
        DocumentSnapshot userDoc = await _usersCollection.doc(uid).get();
        if(userDoc.exists) {
          print('user exists');
          return appUser.User.fromMap(userDoc.data() as Map<String,dynamic>, uid);
        }
      } catch (e) {
        print('error fetching user: $e');
      }
      return null;
  }

}