import 'package:blog_app/auth/login_screen.dart';
import 'package:blog_app/auth/shared_prefs.dart';
import 'package:blog_app/auth/signup_screen.dart';
import 'package:blog_app/pages/editor/create_post.dart';
import 'package:blog_app/pages/editor/preview_post.dart';
import 'package:blog_app/pages/non-authenticated/home_main.dart';
import 'package:blog_app/pages/post_detail_page.dart';
import 'package:blog_app/pages/editor/navbar_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SharedPrefs.init();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    bool isLoggedIn = SharedPrefs.isLoggedIn();
    var userInfo = isLoggedIn ? SharedPrefs.getUserInfo() : null;

    return GetMaterialApp(
        defaultTransition: Transition.cupertinoDialog,
        debugShowCheckedModeBanner: false,
        title: 'Freely',
        initialRoute: isLoggedIn ? 'navbarAuth' : '/',
        getPages: [
          GetPage(name: '/', page: () => HomeMain()),
          GetPage(name: '/details', page: () => PostDetailPage()),
          GetPage(name: '/login', page: () => LoginScreen()),
          GetPage(name: '/signup', page: () => SignupScreen()),
          GetPage(
              name: '/navbarAuth',
              page: () => NavbarAuth(
                    uid: userInfo?['uid'] ?? '',
                    displayName: userInfo?['displayName'] ?? 'Guest',
                    email: userInfo?['email'] ?? 'Unknown',
                    role: userInfo?['role'] ?? 'viewer',
                  )),
          GetPage(name: '/create', page: () => CreatePost()),
          GetPage(
              name: '/preview',
              page: () =>
                  PreviewPost(title: '', content: '', selectedCategory: '', author: '',)),
        ]);
  }
}
