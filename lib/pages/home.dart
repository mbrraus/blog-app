import 'package:flutter/material.dart';

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
  final PostRepository postRepository = PostRepository();
  List<Post> posts = [];
  List<Post> filteredPosts = [];

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
  bool isSortedByDate = false;
  late Future<List<Post>> _postFuture;




  @override
  void initState() {
    super.initState();
    _postFuture = postRepository.getAllPosts();
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
                  setState(() {
                    isSortedByDate = !isSortedByDate;
                  });
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
            body: FutureBuilder<List<Post>>(
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
                  return TabBarView(
                    children: categories.map((category) {
                      //her kategori icin ayri ayri icerik olusturuluyor
                      List<Post> filteredPosts = category == 'All'
                          ? posts
                          : posts
                              .where((post) => post.category == category)
                              .toList();

                      List<Post> displayedPosts = filteredPosts;
                      if (isSortedByDate) {
                        displayedPosts = List.from(filteredPosts);
                        getSortedPosts(displayedPosts);
                      }
                      return ListView.builder(
                        itemCount: displayedPosts.length,
                        itemBuilder: (context, index) {
                          final post = displayedPosts[index];
                          return PostCard(post: post, category: category
                            );
                        },
                      );
                    }).toList(),
                  );
                }
              },
            )));
  }

  void getSortedPosts(List<Post> sortedPost) {
    sortedPost.sort((a, b) => b.createdAt
        .compareTo(a.createdAt)); // Sort by createdAt, not formattedTime
  }
}
