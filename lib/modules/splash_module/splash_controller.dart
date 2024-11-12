import 'package:blog_app/globals/globals.dart';
import 'package:blog_app/modules/main_module/main_controller.dart';
import 'package:get/get.dart';

import '../../routes/routes.dart';

class SplashController extends GetxController{
  final mainController = Get.find<MainController>();
  @override
  void onInit() async {
    super.onInit();
    await Future.delayed(
      const Duration(milliseconds: delayForSplashScreen),
    );
    bool isLogin = await mainController.isLoggedIn();
    if (isLogin) {
      Get.offAllNamed(Routes.authHomePage);
    } else {
      Get.offAllNamed(Routes.loginPage);
    }
  }
}