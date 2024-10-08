import 'package:blog_app/repository/post_repository.dart';
import 'package:get/get.dart';

import '../models/post.dart';

class PostController extends GetxController {
  final PostRepository postRepository = PostRepository();
  List<Post> posts = [];
  List<Post> displayedPosts = []; //filtrelenmis veya siralanmis postlar
  List<Post> sortedPosts = [];
  List<Post> filteredPosts = [];
  bool isSortedByDate = false;

  Future<void> loadPosts() async {
    try {
      posts = await postRepository.getAllPosts();
      displayedPosts = posts
          .map((post) => post.copyWith(
              title: post.title,
              text: post.text,
              author: post.author,
              createdAt: post.createdAt,
              category: post.category))
          .toList();
      print('posts loaded');
      update(); // getbuilder icindeki builder yalnizca bu update calistiginda yenilenir.
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
}
