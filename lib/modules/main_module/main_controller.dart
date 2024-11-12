import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class MainController extends GetxController {

  Future<bool> isLoggedIn() async {
   User? user = FirebaseAuth.instance.currentUser;
   return user!=null;
  }
}
