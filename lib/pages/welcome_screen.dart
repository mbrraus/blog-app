import 'package:blog_app/utils/constants.dart';
import 'package:blog_app/widgets/button.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      body: Stack(
        children: [
          Positioned(
            top: -250,
            right: -350,
            child: Opacity(
              opacity: 0.5,
              child: Image.asset(
                'assets/images/Gradient.png',
                fit: BoxFit.fill,
                width: 800,
                height: 900,
              ),
            ),
          ),
          Positioned(
              top: 300,
              left: 50,
              child: Text(
                'writing',
                style: montserratBold.copyWith(color: welcomeText),
              )),
          Positioned(
              top: 350,
              left: 95,
              child: Text('is',
                  style: montserratBold.copyWith(color: welcomeText))),
          Positioned(
              top: 395,
              left: 75,
              child: Text('freedom.',
                  style: montserratBold.copyWith(color: welcomeText))),
          const Positioned(
              top: 500,
              left: 55,
              right: 55,
              child: CustomButton(
                label: 'Get Started',
                onPressed: null,
              ))
        ],
      ),
    );
  }
}
