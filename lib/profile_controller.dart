import 'package:blog_app/data/repositories/auth_repository.dart';
import 'package:blog_app/data/repositories/user_repository.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:blog_app/data/models/user.dart' as appUser;

class ProfileController extends GetxController{
  final authRepository = AuthRepository();
  final userRepository = UserRepository();

  var fullName = ''.obs;
  var currentUser = Rxn<appUser.User>();

  @override
  void onInit() {
    super.onInit();
    getUserInfo();
  }

  Future<void> getUserInfo() async {
    final firebaseUser = await userRepository.authRepository.getCurrentUser();
    if (firebaseUser != null) {
      final appUser.User? user = await userRepository.getUserById(firebaseUser.uid);
      if (user != null) {
        currentUser.value = user;
      }
    }
  }
  String getFullName() {
    if (currentUser.value != null) {
      print('${currentUser.value?.name ?? ''} ${currentUser.value?.surname ?? ''}');
      return '${currentUser.value?.name ?? ''} ${currentUser.value?.surname ?? ''}';
    }
    return '';
  }
}