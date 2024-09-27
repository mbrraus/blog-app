import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/post.dart';

class PostRepository {
  final CollectionReference _postsCollection =
      FirebaseFirestore.instance.collection('posts');

  Future<List<Post>> getAllPosts() async {
    try {
      QuerySnapshot querySnapshot = await _postsCollection.get();
      var postList = querySnapshot.docs
          .map((doc) => Post.fromMap(doc.data() as Map<String, dynamic>, doc.id))
          .toList();
      Future.delayed(const Duration(seconds: 30));
      return postList;

    } catch (e) {
      print("Error fetching posts: $e");
      return [];
    }
  }

  Future<Post?> getPostById(String postId) async {
    try {
      DocumentSnapshot doc = await _postsCollection.doc(postId).get();
      if (doc.exists) {
        return Post.fromMap(doc.data() as Map<String, dynamic>, postId);
      }
      return null;
    } catch (e) {
      print("error fetching post: $e");
      return null;
    }
  }

  Future<void> addPost(Post post) async {
    try {
      DocumentReference docRef = await _postsCollection.add(post.toMap());
      post.id = docRef.id;
      print("post id: ${post.id}");
    } catch (e) {
      print('error adding post: $e');
    }
  }

  Future<void> updatePost(String postId, Post post) async {
    try {
      await _postsCollection.doc(postId).update(post.toMap());
    } catch (e) {
      print('error updating post: $e');
    }
  }
}
