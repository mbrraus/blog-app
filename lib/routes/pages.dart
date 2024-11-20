import 'package:blog_app/modules/auth_module/login_view.dart';
import 'package:blog_app/modules/auth_module/signup_view.dart';
import 'package:blog_app/modules/create_post_module/create_post_controller.dart';
import 'package:blog_app/modules/create_post_module/create_post_view.dart';
import 'package:blog_app/modules/create_post_module/preview_post_view.dart';
import 'package:blog_app/modules/home_module/post_detail_view.dart';
import 'package:blog_app/modules/main_module/homebar_view.dart';
import 'package:blog_app/modules/main_module/authbar_view.dart';
import 'package:blog_app/modules/profile_module/profile_controller.dart';
import 'package:blog_app/modules/profile_module/user_profile.dart';
import 'package:blog_app/modules/splash_module/splash_screen.dart';
import 'package:blog_app/routes/routes.dart';
import 'package:get/get.dart';

import '../modules/splash_module/splash_controller.dart';

class Pages {
  static final pages = [
    GetPage(
        name: Routes.profilePage,
        page: () => UserProfile(),
        binding: BindingsBuilder(() {
          Get.put(ProfileController());
          Get.put(CreatePostController());
        })),
    GetPage(
        name: Routes.splashScreen,
        page: () => SplashScreen(),
        binding: BindingsBuilder(() {
          Get.put(SplashController());
        })),
    GetPage(name: Routes.homePage, page: () => HomeBar()),
    GetPage(name: Routes.postDetailPage, page: () => PostDetailView()),
    GetPage(name: Routes.loginPage, page: () => LoginScreen()),
    GetPage(name: Routes.signupPage, page: () => SignupScreen()),
    GetPage(
      name: Routes.authHomePage,
      page: () => AuthBar(),
    ),
    GetPage(
      name: Routes.createPage,
      page: () => CreatePost(),
    ),
    GetPage(
      name: Routes.previewPage,
      page: () => PreviewPost(),
    ),
  ];
}
