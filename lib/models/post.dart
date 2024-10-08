import 'package:blog_app/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

import 'category.dart';

class Post {
  String? id;
  String title;
  String text;
  String author;
  DateTime createdAt;
  String category;
  String imageUrl = '';

  Post(
      {this.id,
      required this.title,
      required this.text,
      required this.author,
      required this.category,
      required this.createdAt,
      required this.imageUrl});

  factory Post.fromMap(Map<String, dynamic> map, String id) {
    return Post(
        id: id,
        title: map['title'] ?? 'No title',
        text: map['text'] ?? 'No content',
        author: map['author'] ?? 'Unknown author',
        category: map['category'] ?? 'No category information',
        createdAt: (map['createdAt'] as Timestamp).toDate(),
        imageUrl: map['imageUrl'] ?? '');
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'text': text,
      'author': author,
      'category': category,
      'createdAt': Timestamp.fromDate(createdAt),
      'imageUrl': imageUrl
    };
  }

  Post copyWith(
      {String? id,
      required String title,
      required String text,
      required String author,
      required DateTime createdAt,
      required String category,
      String imageUrl = ''}) {
    return Post(
        title: this.title,
        text: this.text,
        author: this.author,
        category: this.category,
        createdAt: this.createdAt,
        imageUrl: this.imageUrl);
  }

  String get formattedTime {
    return DateFormat('dd.MM.yyyy').format(createdAt);
  }
}
