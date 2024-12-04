import 'package:blog_app/modules/home_module/home_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../profile_module/profile_controller.dart';

class MainController extends GetxController {

   final homeController = Get.find<HomeController>();
  @override
  void onInit() {
    homeController.loadPosts();
    Get.put(ProfileController());
    super.onInit();
  }
  final RxInt currentPageIndex = 2.obs;

  Future<bool> isLoggedIn() async {
   User? user = FirebaseAuth.instance.currentUser;
   return user!=null;
  }

}
