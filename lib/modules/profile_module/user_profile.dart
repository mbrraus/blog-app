import 'package:blog_app/modules/auth_module/auth_controller.dart';
import 'package:blog_app/modules/profile_module/profile_controller.dart';
import 'package:blog_app/modules/profile_module/profile_post_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../globals/styles/text_styles.dart';
import '../post_module/post_controller.dart';

class UserProfile extends StatefulWidget {
   UserProfile({super.key}) {
    Get.put(PostController());
    // Get.put(ProfileController());
  }

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile>
    with AutomaticKeepAliveClientMixin {
  final authController = AuthController();
  final profileController = Get.find<ProfileController>();
  final postController = Get.find<PostController>();


  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: Colors.white,
        actions: [signOutButton()],
      ),
      body: Padding(
        padding: EdgeInsets.all(10.0),
        child: Center(
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
              Obx(() =>
                  Column(
                    children: [
                      Text(profileController.getFullName(),
                          style: montserratBody.copyWith(
                              color: Colors.black, fontSize: 16)),
                      SizedBox(height: 8),
                      Text('0 Followers  •  1 Following',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey.shade600,
                          )),
                    ],
                  )),
              SizedBox(height: 10),
              editProfileButton(),
              Divider(
                height: 40,
                thickness: 1,
                indent: 6,
                endIndent: 0,
                color: Colors.black12,
              ),
              Expanded(child: Obx(() {
                if (postController.isUploading.value) {
                  print('burada:${postController.isUploading.value}');
                  return Center(
                      child: CircularProgressIndicator());
                }
                if (profileController.userPosts.isEmpty) {
                  return Center(child: Text('No posts available'));
                }
                return ListView.builder(
                    cacheExtent: 1000,
                    itemCount: profileController.userPosts.length,
                    itemBuilder: (context, index) {
                      final post = profileController.userPosts[index];
                      return Column(
                        children: [
                          ProfilePostCard(post: post),
                          if (index <
                              profileController.userPosts.length -
                                  1)
                            Divider(
                              color: Colors.grey.withOpacity(0.3),
                              thickness: 0.5,
                              indent: 12,
                              endIndent: 12,
                            ),
                        ],
                      );
                    });
              }))
            ],
          ),
        ),
      ),
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
