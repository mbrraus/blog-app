import 'package:flutter/material.dart';

import '../models/post.dart';
import '../repository/post_repository.dart';
import '../utils/constants.dart';
import '../widgets/category_card.dart';
import '../widgets/post_card.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final PostRepository postRepository = PostRepository();
  late List<Post> posts;
  late List<Post> filteredPosts;
  late List<Post> sortedPost = [];

  List<String> categories = [
    'All',
    'Philosophy',
    'Literature',
    'Science',
    'Nature',
    'Technology'
  ];

  String selectedCategory = 'All';
  bool isSortedByDate = false;
  late Future<List<Post>> _postFuture;

  @override
  void initState() {
    super.initState();
    _postFuture = postRepository.getAllPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.filter_list_rounded),
            onPressed: () {
              setState(() {
                isSortedByDate = !isSortedByDate;
              });
            },
          ),
          scrolledUnderElevation: 0.0,
          backgroundColor: Colors.white,
          title: Text('Freely', style: montserratHeader.copyWith(fontSize: 22)),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Expanded(
                flex: 2,
                child: Row(
                  children: [
                    Expanded(
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: categories.length,
                          itemBuilder: (BuildContext context, int index) {
                            var category = categories[index];
                            return Center(
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedCategory = category;
                                  });
                                },
                                child: CategoryCard(
                                  category: category,
                                  isSelected: category == selectedCategory,
                                ),
                              ),
                            );
                          }),
                    )
                  ],
                ),
              ),

              //thats for listing the posts
              Expanded(
                flex: 16,
                child: FutureBuilder<List<Post>>(
                  future: _postFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return const Center(child: Text('error occurred'));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Center(child: Text('no post available!'));
                    } else {
                      posts = snapshot.data!;
                      filteredPosts = selectedCategory == 'All'
                          ? posts
                          : posts
                              .where(
                                  (post) => post.category == selectedCategory)
                              .toList();
                      if (isSortedByDate) {
                        sortedPost = List.from(
                            filteredPosts); //filteredpost listesini kopyaliyorum
                        getSortedPosts();
                      } else {
                        sortedPost = filteredPosts;
                      }

                      return ListView.builder(
                        itemCount: sortedPost.length,
                        itemBuilder: (context, index) {
                          final post = sortedPost[index];
                          print('sorted posts: ${post.formattedTime}');
                          return PostCard(
                              post: post, category: selectedCategory);
                        },
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ));
  }

  void getSortedPosts() {
    sortedPost.sort((a, b) => b.createdAt
        .compareTo(a.createdAt)); // Sort by createdAt, not formattedTime
  }
}
