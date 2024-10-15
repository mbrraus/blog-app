import 'dart:io';

import 'package:blog_app/repository/post_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../models/post.dart';

class PostController extends GetxController {
  final PostRepository postRepository = PostRepository();
  List<Post> posts = [];
  List<Post> displayedPosts = [];
  List<Post> filteredPosts = [];
  bool isSortedByDate = false;
  bool isLoading = false;
  RxBool isUploading = false.obs;

  late Rx<XFile?> imageFile = Rxn<XFile>();
  final ImagePicker _picker = ImagePicker();

  RxList selectedCategories = [].obs;

  Future<void> loadPosts() async {
    try {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        isLoading = true;
        update(); // Build işlemi tamamlandığında bu çağrı yapılır
        await Future.delayed(Duration(seconds: 1), () async {
          posts = await postRepository.getAllPosts();
        });
        isLoading = false;
        displayedPosts = posts
            .map((post) => post.copyWith(
                title: post.title,
                text: post.text,
                author: post.author,
                createdAt: post.createdAt,
                category: post.category))
            .toList();
        print('posts loaded');
        update();
      });
    } catch (e) {
      print('error loading posts: $e');
    }
  }

  void getFilteredPosts(String category) {
    if (category == 'All') {
      displayedPosts = posts
          .map((post) => post.copyWith(
              title: post.title,
              text: post.text,
              author: post.author,
              createdAt: post.createdAt,
              category: post.category))
          .toList();
      filteredPosts = List.from(displayedPosts);
      print('all posts displayed');
    } else {
      displayedPosts =
          posts.where((post) => post.category == category).toList();
      filteredPosts = List.from(displayedPosts);
      //memoryde olusuyor mu ? ? ? ?
      print('posts filtered');
    }
    update();
  }

  void toggleSort() {
    isSortedByDate = !isSortedByDate;
    if (isSortedByDate) {
      getSortedPosts();
      print('posts sorted');
    } else {
      if (filteredPosts.isNotEmpty) {
        displayedPosts = List.from(filteredPosts);
      } else {
        displayedPosts = List.from(posts);
      }
      print('posts unsorted');
    }
    update();
  }

  void getSortedPosts() {
    displayedPosts.sort((a, b) => b.createdAt.compareTo(a.createdAt));
  }

  Future<void> pickImage() async {
    try {
      final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
      imageFile.value = pickedFile;
      print('image loaded');
    } catch (e) {
      print('there is a problem: $e');
    }
  }

  Future<void> uploadPost(Post post, XFile? imageFile) async {
    isUploading.value = true;
    if (imageFile == null) {
      isUploading.value = false;
      Get.snackbar('Error', 'please select an image');
      return;
    }
    try {
      await postRepository.addPostWithImage(
          post: post, imageFile: File(imageFile.path));
      Get.offAllNamed('/navbarAuth');
    } catch (e) {
      Get.snackbar('Error', 'error uploading post');
    } finally {
      isUploading.value = false;
    }
  }

  void selectCategory(bool selected, String category) {
    if (selected) {
      selectedCategories.add(category);
    } else {
      selectedCategories.remove(category);
    }
  }
}
