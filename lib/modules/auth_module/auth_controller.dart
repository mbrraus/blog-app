import 'package:blog_app/routes/routes.dart';
import 'package:get/get.dart';

import '../../data/models/user.dart';
import '../../data/repositories/user_repository.dart';
import '../../data/repositories/auth_repository.dart';

class AuthController extends GetxController {
  final authRepository = AuthRepository();
  final userRepository = UserRepository();

  Future<void> login(String email, String password) async {
    final firebaseUser = await authRepository.loginUserWithEmailAndPassword(
        email, password);
    if (firebaseUser != null) {
        Get.offAllNamed(Routes.authHomePage);
      }
    }
  Future<void> signup(String email, String password, String name, String surname) async {
    final firebaseUser = await authRepository.createUserWithEmailAndPassword(
        email, password);
    if (firebaseUser != null) {
      print('user created');
      final user = User(
          id: firebaseUser.uid,
          name: name,
          surname: surname,
          email: firebaseUser.email!,
          role: Role.editor);
      await userRepository.addUser(user);
      Get.offAllNamed(Routes.authHomePage);
    }
  }
  Future<void> signout() async {
    await authRepository.signOut();
    Get.offAllNamed(Routes.homePage);
  }
  }
