import 'package:blog_app/modules/auth_module/auth_controller.dart';
import 'package:blog_app/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'globals/styles/text_styles.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  final authController = AuthController();
  final profileController = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor:Colors.white,
        actions: [signOutButton()],
      ),
      body: Padding(padding: EdgeInsets.all(10.0), child: Center(
        child: Column(
          children: [
            SizedBox(
              width: 65,
              height: 65,
              child: CircleAvatar(
                backgroundColor: Colors.indigo,
              ),
            ),
            SizedBox(height: 20),
            Obx(()=> Column(
              children: [
                Text(profileController.getFullName(), style: montserratBody.copyWith(color: Colors.black, fontSize: 16)),
            SizedBox(height: 8),
            Text(
              '0 Followers  •  1 Following',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey.shade600,
              )),
              ],
            )),
            SizedBox(height: 10),
            editProfileButton()
          ],
        ),
      ),),
    );
  }

  Widget signOutButton() {
    return Container(
        padding: EdgeInsets.only(right: 20),
        child: ElevatedButton(
            onPressed: authController.signout,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.indigo.shade600,
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 3),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            child: Text('Sign out',
                style: montserratBody.copyWith(color: Colors.white))));
  }
  Widget editProfileButton() {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        elevation: 0,
        side: BorderSide(color: Colors.black.withOpacity(1), width: 1),
        backgroundColor: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 50, vertical: 3),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(17),
        ),
      ),
      child: Text('Edit Your Profile',
          style: montserratButton.copyWith(color: Colors.indigo)),
    );
  }

}
