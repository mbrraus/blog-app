import 'dart:io';

import 'package:blog_app/data/repositories/auth_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';

import '../models/post.dart';

class PostRepository {
  final CollectionReference _postsCollection =
      FirebaseFirestore.instance.collection('posts');
  final authRepository = AuthRepository();

  void deletePost(Post post) async {
    try {
      var currentUser = await authRepository.getCurrentUser();
      if (post.authorUid == currentUser?.uid) {
        await _postsCollection.doc(post.id).delete();
      }
    } catch (e) {
      print('Error deleting post: $e');
      Get.snackbar('Error', 'Failed to delete post.');
    }
  }

  Future<List<Post>> getAllPosts() async {
    try {
      QuerySnapshot querySnapshot = await _postsCollection.get();
      var postList = querySnapshot.docs
          .map(
              (doc) => Post.fromMap(doc.data() as Map<String, dynamic>, doc.id))
          .toList();
      return postList;
    } catch (e) {
      print("Error fetching posts: $e");
      return [];
    }
  }

  Future<Post?> getPostById(String postId) async {
    try {
      var doc = await _postsCollection.doc(postId).get();
      if (doc.exists) {
        return Post.fromMap(doc.data() as Map<String, dynamic>, postId);
      }
    } catch (e) {
      print("error fetching post: $e");
    }
    return null;
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

  Future<void> updatePost(Post post, File? imageFile) async {
    try {
      var currentUser = await authRepository.getCurrentUser();
      if (imageFile != null) {
        String imageUrl = await uploadImageToStorage(imageFile);
        post.imageUrl = imageUrl;
      }
      if (post.authorUid == currentUser?.uid) {
        await _postsCollection.doc(post.id).update(post.toMap());
      } else {
        Get.snackbar('Unauthorized', 'You are not allowed to edit this post.');
      }
    } catch (e) {
      print('error updating post: $e');
    }
  }

  Future<String> uploadImageToStorage(File imageFile) async {
    try {
      String fileName = 'posts/${DateTime.now().millisecondsSinceEpoch}.jpg';
      Reference storageRef = FirebaseStorage.instance.ref().child(fileName);
      UploadTask uploadTask = storageRef.putFile(imageFile);

      TaskSnapshot taskSnapshot = await uploadTask;
      String downloadUrl = await taskSnapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      throw Exception('Failed to upload image: $e');
    }
  }

  Future<void> addPostWithImage({
    required Post post,
    required File imageFile,
  }) async {
    try {
      String imageUrl = await uploadImageToStorage(imageFile);
      post.imageUrl = imageUrl;
      await addPost(post);
    } catch (e) {
      print('Error adding post with image: $e');
    }
  }

  Future<List<Post>> getPostsByUser(String userId) async {
    try {
      QuerySnapshot querySnapshot =
          await _postsCollection.where('authorUid', isEqualTo: userId).get();
      return querySnapshot.docs
          .map(
              (doc) => Post.fromMap(doc.data() as Map<String, dynamic>, doc.id))
          .toList();
    } catch (e) {
      print('error fetching user posts: $e');
      return [];
    }
  }
}
