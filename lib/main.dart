import 'package:blog_app/auth/login_screen.dart';
import 'package:blog_app/auth/signup_screen.dart';
import 'package:blog_app/pages/home.dart';
import 'package:blog_app/pages/home_main.dart';
import 'package:blog_app/pages/post_detail_page.dart';
import 'package:blog_app/widgets/navbar_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

import 'utils/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Freely',
      initialRoute: '/',
      getPages : [
        GetPage(name: '/', page: () => HomeMain()),
        GetPage(name: '/details', page: () => PostDetailPage()),
        GetPage(name: '/login', page: () => LoginScreen()),
        GetPage(name: '/navbarAuth', page: () => NavbarAuth()),
      ]
    );
  }
}


