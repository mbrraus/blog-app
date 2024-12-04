import 'dart:io';
import 'package:blog_app/data/models/post.dart';
import 'package:blog_app/data/models/user.dart';
import 'package:blog_app/data/repositories/post_repository.dart';
import 'package:blog_app/data/repositories/user_repository.dart';
import 'package:blog_app/globals/globals.dart';
import 'package:blog_app/modules/home_module/home_controller.dart';
import 'package:blog_app/modules/profile_module/profile_controller.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class PostController extends GetxController {
  final post = Post.empty().obs;
  final profileController = Get.find<ProfileController>();

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

  var isEditing = false;

  Rxn<XFile>? imageFile = Rxn<XFile>();
  final _picker = ImagePicker();

  Future<void> pickImage() async {
    try {
      final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
      imageFile!.value = pickedFile;
      cropImage();
      print('image loaded');
    } catch (e) {
      print('there is a problem: $e');
    }
  }

  void cropImage() async {
    CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: imageFile!.value!.path,
      uiSettings: [
        IOSUiSettings(
          title: 'Cropper',
          aspectRatioPresets: [
            CropAspectRatioPreset.original,
            CropAspectRatioPreset.square,
            CropAspectRatioPreset.ratio7x5
          ],
        ),
      ],
    );
    if (croppedFile != null) {
      imageFile!.value = XFile(croppedFile.path);
    }
  }

  void deletePost(Post post) async {
    profileController.isUpdating = true;
    try {
      postRepository.deletePost(post);
      Get.back();
      Get.snackbar('Success', 'Post successfully deleted.');
      await Get.find<ProfileController>().getUserPosts();
    } catch (e) {
      Get.snackbar('Error', 'Something went wrong.');
    } finally {
      profileController.isUpdating = false;
    }
  }

  Future<void> uploadPost(XFile? imageFile) async {
    //true
    Post newPost = Post(
        id: '',
        title: post.value.title,
        text: post.value.text,
        author: currentUser.name,
        category: post.value.category,
        createdAt: now,
        imageUrl: '',
        authorUid: currentUser.id);
    if (imageFile == null) {
      Get.snackbar('Error', 'please select an image');
      return;
    }
    try {
      await postRepository.addPostWithImage(
          post: newPost, imageFile: File(imageFile.path));

      await Get.find<HomeController>().loadPosts();
      update();
      Get.find<ProfileController>().getUserPosts();
    } catch (e) {
      print(e);
      Get.snackbar('Error', 'error uploading post');
    } finally {
      update();
      print('-ee-e-eeeee-----');
    }
  }

  Future<void> updatePost() async {
    profileController.isUpdating = true;
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
    try {
      await postRepository.updatePost(updatedPost,
          imageFile?.value != null ? File(imageFile!.value!.path) : null);

      Get.snackbar('Successful', 'Post successfully updated.');
      await Get.find<ProfileController>().getUserPosts();
    } catch (e) {
      Get.snackbar('Error', 'error updating post');
    } finally {
      profileController.isUpdating = false;
    }
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
    Get.delete<PostController>();
  }
}
