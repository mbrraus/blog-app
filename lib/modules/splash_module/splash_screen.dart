import 'package:blog_app/globals/styles/colors.dart';
import 'package:flutter/material.dart';

import '../../globals/styles/text_styles.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: background,
        child: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
          Text('Freely',
              style: montserratHeader.copyWith(
                  fontSize: 50, color: Colors.indigo)),
          SizedBox(height: 10),
          Image.asset('assets/images/blog.png', width: 80, height: 80)
        ])),
      ),
    );
  }
}
