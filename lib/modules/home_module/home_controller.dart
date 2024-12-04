import 'package:flutter/cupertino.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../data/models/post.dart';
import '../../data/repositories/post_repository.dart';

class HomeController extends GetxController {
  final PostRepository postRepository = PostRepository();

  bool isLoading = false;
  List<Post> posts = [];
  List<Post> displayedPosts = [];
  List<Post> filteredPosts = [];
  RxString selectedCategory = 'All'.obs;
  bool isSortedByDate = false;

  Future<void> loadPosts() async {
    isLoading = true;
    update();
    try {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        posts = await postRepository.getAllPosts();

        displayedPosts = posts
            .map((post) => post.copyWith(
                id: post.id,
                title: post.title,
                text: post.text,
                author: post.author,
                createdAt: post.createdAt,
                category: post.category))
            .toList();
        print('posts loaded');
        isLoading = false;

        update();
      });
    } catch (e) {
      print('error loading posts: $e');
    }
  }

  void getFilteredPosts() {
    if (selectedCategory.value == 'All') {
      displayedPosts = posts
          .map((post) => post.copyWith(
              id: post.id,
              title: post.title,
              text: post.text,
              author: post.author,
              createdAt: post.createdAt,
              category: post.category))
          .toList();
      filteredPosts = List.from(displayedPosts);
      print('all posts displayed');
    } else {
      displayedPosts = posts
          .where((post) => post.category == selectedCategory.value)
          .toList();
      filteredPosts = List.from(displayedPosts);
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
    print('sort function');
    displayedPosts.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    for (var post in displayedPosts) {
      print('${post.createdAt}');
    }
  }
}
