import 'package:blog_app/modules/post_module/post_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'dart:io';

import '../../globals/globals.dart';
import '../../routes/routes.dart';

class PreviewPost extends StatelessWidget {
  final PostController postController = Get.find<PostController>();

  PreviewPost({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Obx(() {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _imagePicker(),
                sizedBox20(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: postInfo()),
                ),
                sizedBox20(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    postController.post.value.text,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                ),
                sizedBox20()
              ],
            ),
          );
        }),
      ),
    );
  }

  Widget _imagePicker() {
    return Obx(
      () => Stack(
        children: [
          SizedBox(
            width: double.infinity,
            height: 250,
            child: postController.isEditing &&
                    postController.post.value.imageUrl.isNotEmpty
                ? GestureDetector(
                    onTap: postController.pickImage,
                    child: postController.imageFile?.value != null
                        ? Image.file(
                            File(postController.imageFile?.value?.path ?? ''),
                            fit: BoxFit.cover,
                          )
                        : Image.network(postController.post.value.imageUrl,
                            fit: BoxFit.cover))
                : postController.imageFile?.value == null
                    ? GestureDetector(
                        onTap: postController.pickImage,
                        child: Container(
                          color: Colors.grey.shade300,
                          child: Center(
                            child: Icon(
                              Icons.add_photo_alternate_outlined,
                              size: 50,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      )
                    : GestureDetector(
                        onTap: postController.pickImage,
                        child: Image.file(
                          File(postController.imageFile?.value?.path ?? ''),
                          fit: BoxFit.cover,
                        ),
                      ),
          ),
          goBackCircled(),
          Positioned(
            top: 16,
            right: 16,
            child: postController.isEditing ? updateButton() : postButton(),
          ),
        ],
      ),
    );
  }

  Widget postButton() {
    return ElevatedButton(
        onPressed: () async {
          postController.uploadPost(postController.imageFile?.value);
          Get.offAllNamed(Routes.authHomePage);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.indigo.shade600,
          padding: EdgeInsets.symmetric(horizontal: 5, vertical: 3),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(17),
          ),
        ),
        child:
            Text('Post', style: TextStyle(fontSize: 16, color: Colors.white)));
  }

  Widget updateButton() {
    return ElevatedButton(
        onPressed: () {
          postController.updatePost();
          Get.offAllNamed(Routes.authHomePage, arguments: 4);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.indigo.shade600,
          padding: EdgeInsets.symmetric(horizontal: 5, vertical: 3),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(17),
          ),
        ),
        child:
            Text('Save', style: TextStyle(fontSize: 16, color: Colors.white)));
  }

  Widget goBackCircled() {
    return Positioned(
      top: 16,
      left: 16,
      child: GestureDetector(
        onTap: () => Get.back(),
        child: CircleAvatar(
          backgroundColor: Colors.white60,
          child: Center(
            child: const Icon(
              size: 22,
              Icons.arrow_back_ios_new_rounded,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> postInfo() {
    return [
      Row(
        children: [
          Icon(Icons.account_circle),
          SizedBox(width: 5),
          Text(
              '${postController.currentUser.name} ${postController.currentUser.surname}',
              style: TextStyle(fontSize: 16)),
        ],
      ),
      Text(
        DateFormat('dd.MM.yyyy').format(postController.post.value.createdAt),
        style: TextStyle(fontSize: 14),
      ),
    ];
  }
}
