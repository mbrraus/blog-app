import 'package:blog_app/data/repositories/auth_repository.dart';
import 'package:blog_app/data/repositories/post_repository.dart';
import 'package:blog_app/data/repositories/user_repository.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:blog_app/data/models/user.dart' as appUser;

import '../../data/models/post.dart';

class ProfileController extends GetxController {
  final authRepository = AuthRepository();
  final userRepository = UserRepository();
  final postRepository = PostRepository();

  var fullName = ''.obs;
  var currentUser = Rxn<appUser.User>();
  var userPosts = <Post>[].obs;

  final _isUpdating = false.obs;

  bool get isUpdating => _isUpdating.value;

  set isUpdating(value) => _isUpdating.value = value;

  @override
  void onInit() {
    super.onInit();
    getUserInfo();
  }

  Future<void> getUserInfo() async {
    final firebaseUser = await userRepository.authRepository.getCurrentUser();
    if (firebaseUser != null) {
      final appUser.User? user = await userRepository.getCurrentUser();
      if (user != null) {
        currentUser.value = user;
        await getUserPosts();
      }
    }
  }

  String getFullName() {
    if (currentUser.value != null) {
      print(
          '${currentUser.value?.name ?? ''} ${currentUser.value?.surname ?? ''}');
      return '${currentUser.value?.name ?? ''} ${currentUser.value?.surname ?? ''}';
    }
    return '';
  }

  Future<void> getUserPosts() async {
    isUpdating = true;
    if (currentUser.value != null) {
      final posts = await postRepository.getPostsByUser(currentUser.value!.id);
      userPosts.assignAll(posts);
    }
    isUpdating = false;
  }
}
