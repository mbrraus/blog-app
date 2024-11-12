import 'dart:io';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../data/models/post.dart';
import '../../data/repositories/post_repository.dart';

class CreatePostController extends GetxController {
  final PostRepository postRepository = PostRepository();

  RxBool isUploading = false.obs;

  late Rx<XFile?> imageFile = Rxn<XFile>();
  final ImagePicker _picker = ImagePicker();

  RxList selectedCategories = [].obs;

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
