import 'dart:io';

import 'package:blog_app/data/repositories/auth_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';

import '../../modules/create_post_module/create_post_controller.dart';
import '../../modules/profile_module/profile_controller.dart';
import '../../routes/routes.dart';
import '../models/post.dart';

class PostRepository {
  final CollectionReference _postsCollection =
      FirebaseFirestore.instance.collection('posts');
  final authRepository = AuthRepository();

  Future<List<Post>> getAllPosts() async {
    try {
      QuerySnapshot querySnapshot = await _postsCollection.get();
      var postList = querySnapshot.docs
          .map(
              (doc) => Post.fromMap(doc.data() as Map<String, dynamic>, doc.id))
          .toList();
      // Future.delayed(const Duration(seconds: 30));
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

  Future<void> updatePost(Post post, File? imageFile) async {
    try {
      var currentUser = await authRepository.getCurrentUser();
      if (imageFile != null) {
        String imageUrl = await uploadImageToStorage(imageFile);
        post.imageUrl = imageUrl;
      } //eskisini sileyecek miyiz
      if (post.authorUid == currentUser?.uid) {
        await _postsCollection.doc(post.id).update(post.toMap());
        Get.find<ProfileController>().getUserPosts();
        Get.snackbar('Successful', 'Post successfully updated.');
        Get.delete<CreatePostController>();
      } else {
        Get.snackbar('Unauthorized', 'You are not allowed to edit this post.');
      }

      Get.toNamed(Routes.profilePage);
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
