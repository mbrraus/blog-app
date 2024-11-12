import 'package:blog_app/modules/create_post_module/create_post_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'dart:io';

import '../../data/models/post.dart';
import '../../globals/globals.dart';

class PreviewPost extends StatefulWidget {
  final String title;
  final String content;
  final String author;
  final String selectedCategory;

  const PreviewPost(
      {super.key,
        required this.title,
        required this.content,
        required this.author,
        required this.selectedCategory});

  @override
  State<PreviewPost> createState() => _PreviewPostState();
}

class _PreviewPostState extends State<PreviewPost> {

  final CreatePostController postController = Get.find<CreatePostController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Obx(() {
          return postController.isUploading.value
              ? Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _imagePicker(),
                sizedBox20(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: postInfo()
                  ),
                ),
                sizedBox20(),
                // Content
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    widget.content,
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
    return Stack(
      children: [
        SizedBox(
          width: double.infinity,
          height: 250,
          child: postController.imageFile.value == null
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
              : Image.file(
            File(postController.imageFile.value?.path ?? ''),
            fit: BoxFit.cover,
          ),
        ),
        goBackCircled(),
        Positioned(
            top: 16,
            right: 16,
            child: ElevatedButton(
                onPressed: () {
                  Post newPost = Post(
                      title: widget.title,
                      text: widget.content,
                      author: widget.author,
                      category: widget.selectedCategory,
                      createdAt: now,
                      imageUrl: '');
                  postController.uploadPost(newPost, postController.imageFile.value);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigo.shade600,
                  padding: EdgeInsets.symmetric(
                      horizontal: 5, vertical: 3),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(17),
                  ),
                ),
                child: Text('Post',
                    style: TextStyle(
                        fontSize: 16, color: Colors.white)))),
      ],
    );
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
          Text(widget.author,
              style: TextStyle(fontSize: 16)),
        ],
      ),
      Text(
        DateFormat('dd.MM.yyyy').format(now),
        style: TextStyle(fontSize: 14),
      ),
    ];
  }
}

