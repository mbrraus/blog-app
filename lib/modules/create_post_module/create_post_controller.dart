import 'dart:io';
import 'package:blog_app/data/repositories/user_repository.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../data/models/post.dart';
import '../../data/models/user.dart';
import '../../data/repositories/post_repository.dart';
import '../../globals/globals.dart';
import '../profile_module/profile_controller.dart';

class CreatePostController extends GetxController {
  final post = Post.empty().obs;

  final postRepository = PostRepository();
  final userRepository = UserRepository();

  @override
  void onInit() {
    getCurrentUser();
    super.onInit();
  }

  var currentUser = User(id: '', name: '', surname: '', email: '');

  void getCurrentUser() async {
    currentUser = (await userRepository.getCurrentUser())!;
  }

  final isUploading = false.obs;
  var isEditing = false;

  Rxn<XFile>? imageFile = Rxn<XFile>();
  final _picker = ImagePicker();

  Future<void> pickImage() async {
    try {
      final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
      imageFile!.value = pickedFile;
      print('image loaded');
    } catch (e) {
      print('there is a problem: $e');
    }
  }

  void deletePost(Post post) async {
    postRepository.deletePost(post);
    Get.back();
    Get.snackbar('Success', 'Post successfully deleted.');
    Get.find<ProfileController>().getUserPosts();
  }

  Future<void> uploadPost(XFile? imageFile) async {
    Post newPost = Post(
        id: '',
        title: post.value.title,
        text: post.value.text,
        author: currentUser.name,
        category: post.value.category,
        createdAt: now,
        imageUrl: '',
        authorUid: currentUser.id);

    isUploading.value = true;
    if (imageFile == null) {
      isUploading.value = false;
      Get.snackbar('Error', 'please select an image');
      return;
    }
    try {
      await postRepository.addPostWithImage(
          post: newPost, imageFile: File(imageFile.path));
      Get.offAllNamed('/navbarAuth');
    } catch (e) {
      Get.snackbar('Error', 'error uploading post');
    } finally {
      isUploading.value = false;

    }
  }

  Future<void> updatePost() async {
    Post updatedPost = Post(
        id: post.value.id,
        title: post.value.title,
        text: post.value.text,
        author: post.value.author,
        category: post.value.category,
        createdAt: post.value.createdAt,
        updatedAt: now,
        imageUrl: '',
        authorUid: post.value.authorUid);
    await postRepository.updatePost(updatedPost,
        imageFile?.value != null ? File(imageFile!.value!.path) : null);
  }

  void selectCategory(bool selected, String category) {
    if (selected) {
      post.value.category = category;
    } else {
      post.value.category = '';
    }
  }

  void closeUnsaved() {
    print(post.value.id);
    post.value = Post.empty();
    imageFile?.value = null;
    Get.delete<CreatePostController>();
  }
}
