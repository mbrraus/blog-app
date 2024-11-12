import 'package:blog_app/routes/pages.dart';
import 'package:blog_app/routes/routes.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'firebase_options.dart';
import 'modules/main_module/main_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const BlogApp());
}

class BlogApp extends StatelessWidget {
  const BlogApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        defaultTransition: Transition.cupertinoDialog,
        debugShowCheckedModeBanner: false,
        title: 'Freely',
        initialRoute: Routes.splashScreen,
        initialBinding: BindingsBuilder(() {
          Get.put(MainController());
        }),
        getPages: Pages.pages);
  }
}
