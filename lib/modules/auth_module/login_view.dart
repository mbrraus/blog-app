import 'package:blog_app/modules/auth_module/auth_controller.dart';
import 'package:blog_app/widgets/custom_tf.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../globals/styles/text_styles.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
            color: Colors.indigo,
            icon: Icon(Icons.arrow_back_ios_new),
            onPressed: () {
              Get.toNamed('/');
            },
          ),
        ),
        body: SafeArea(
            child: Padding(
          padding: EdgeInsets.all(35),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Log in',
                  style: montserratBold.copyWith(
                      fontSize: 25, color: Colors.indigo)),
              SizedBox(height: 20),
              CustomTextField(
                  hint: 'Enter your email',
                  controller: email,
                  label: 'Email',
                  icon: Icon(Icons.email_outlined)),
              SizedBox(height: 15),
              CustomTextField(
                  hint: 'Enter your password',
                  isPassword: true,
                  controller: password,
                  label: 'Password',
                  icon: Icon(Icons.lock_outline)),
              SizedBox(height: 30),
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 41,
                      child: ElevatedButton(
                        onPressed: () async {authController.login(email.text, password.text);},
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.indigo),
                        child: Text('Log in', style: montserratBody),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don't have account? ",
                      style: montserratBody.copyWith(
                          fontSize: 12, color: Colors.black)),
                  GestureDetector(
                      onTap: () {
                       Get.toNamed('/signup');
                      },
                      child: Text('Sign up',
                          style: montserratBody.copyWith(
                              fontSize: 12, color: Colors.indigo)))
                ],
              )
            ],
          ),
        )));
  }


}
