import 'package:blog_app/modules/main_module/main_controller.dart';
import 'package:get/get.dart';


class MainBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<MainController>(MainController());
  }
}