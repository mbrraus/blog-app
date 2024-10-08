import 'package:blog_app/auth/auth_service.dart';
import 'package:blog_app/auth/signup_screen.dart';
import 'package:blog_app/pages/home_main.dart';
import 'package:blog_app/repository/user_repository.dart';
import 'package:blog_app/utils/constants.dart';
import 'package:blog_app/widgets/custom_tf.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();

  final _authService = AuthService();
  final userRepository = UserRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            color: Colors.indigo,
            icon: Icon(Icons.arrow_back_ios_new),
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => HomeMain()));
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
                        onPressed: login,
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
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => SignupScreen()));
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

  void login() async {
    final firebaseUser = await _authService.loginUserWithEmailAndPassword(
        email.text, password.text);
    if (firebaseUser != null) {
      print('user logged in');
      final user = await userRepository.getUserById(firebaseUser.uid);
      if (user != null) {
        Get.toNamed('/navbarAuth', arguments: user);
      }
    }
  }
}
