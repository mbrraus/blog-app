import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/post_controller.dart';
import '../models/post.dart';
import '../models/user.dart';
import '../repository/post_repository.dart';
import '../utils/constants.dart';
import '../widgets/post_card.dart';

class Home extends StatefulWidget {
  final User? currentUser;

  const Home({super.key, this.currentUser});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Post> posts = [];

  List<String> categories = [
    'All',
    'Philosophy',
    'Literature',
    'Science',
    'Nature',
    'Technology'
  ];

  int currentPageIndex = 0;

  String selectedCategory = 'All';

  final PostController postController = Get.put(PostController());

  @override
  void initState() {
    super.initState();
    postController.loadPosts(); //ilk basta butun postlar yukleniyor ve displayedposta ataniyor
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: categories.length,
        child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              leading: IconButton(
                icon: const Icon(Icons.sort),
                onPressed: () {
                  postController.toggleSort();
                },
              ),
              scrolledUnderElevation: 0.0,
              backgroundColor: Colors.white,
              title: Text('Freely',
                  style: montserratHeader.copyWith(fontSize: 22)),
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(80.0),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(
                        textAlign: TextAlign.left,
                        'Welcome ${widget.currentUser?.name ?? ''}!',
                        // Display user's name if available
                        style: montserratBody.copyWith(
                          fontSize: 18,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    TabBar(
                      onTap: (index) {
                        selectedCategory = categories[index];
                        postController.getFilteredPosts(selectedCategory);
                      },
                      tabAlignment: TabAlignment.start,
                      labelStyle: montserratBody.copyWith(color: Colors.black),
                      isScrollable: true,
                      tabs: categories.map((category) {
                        return Tab(text: category);
                      }).toList(),
                    ),
                  ],
                ),
              ),
            ),
            body: GetBuilder<PostController>(builder: (controller) {
              if (controller.posts.isEmpty) {
                return Center(child: Text('No posts available!'));
              } else {
                return ListView.builder(
                  itemCount: controller.displayedPosts.length,
                  itemBuilder: (context, index) {
                    final post = controller.displayedPosts[index];
                    return PostCard(post: post, category: selectedCategory);
                  },
                );
              }
            })));
  }
}
