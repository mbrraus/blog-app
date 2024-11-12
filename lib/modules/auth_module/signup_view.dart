import 'package:blog_app/modules/auth_module/auth_controller.dart';
import 'package:blog_app/modules/auth_module/login_view.dart';
import 'package:blog_app/widgets/custom_tf.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../globals/styles/text_styles.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<SignupScreen> {
  final TextEditingController name = TextEditingController();
  final TextEditingController surname = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController confirmPassword = TextEditingController();

  final authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(35),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text('Sign up',
                    style: montserratBold.copyWith(
                        fontSize: 25, color: Colors.indigo)),
                SizedBox(height: 20),
                CustomTextField(
                    hint: 'Enter your name',
                    controller: name,
                    label: 'Name*',
                    icon: Icon(Icons.account_circle_outlined)),
                SizedBox(height: 15),
                CustomTextField(
                    hint: 'Enter your surname',
                    controller: surname,
                    label: 'Surname*',
                    icon: Icon(Icons.account_circle)),
                SizedBox(height: 15),
                CustomTextField(
                    hint: 'Enter your email',
                    controller: email,
                    label: 'Email*',
                    icon: Icon(Icons.email_outlined)),
                SizedBox(height: 15),
                CustomTextField(
                    hint: 'Enter your password',
                    controller: password,
                    label: 'Password*',
                    isPassword: true,
                    icon: Icon(Icons.lock_outline)),
                SizedBox(height: 15),
                CustomTextField(
                    hint: 'Enter your password again',
                    controller: confirmPassword,
                    label: 'Confirm Password*',
                    isPassword: true,
                    icon: Icon(Icons.lock)),
                SizedBox(height: 30),
                Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 41,
                        child: ElevatedButton(
                          onPressed: () async {
                            authController.signup(email.text, password.text,
                                name.text, surname.text);
                          },
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15)),
                              foregroundColor: Colors.white,
                              backgroundColor: Colors.indigo),
                          child: Text('Sign up', style: montserratBody),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Already have an account? ',
                        style: montserratBody.copyWith(
                            fontSize: 12, color: Colors.black)),
                    GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => LoginScreen()));
                        },
                        child: Text('Log in',
                            style: montserratBody.copyWith(
                                fontSize: 12, color: Colors.indigo)))
                  ],
                )
              ],
            ),
          ),
        ),
      )),
    );
  }
}
