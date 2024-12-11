import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class Post {
  String id;
  String title;
  String text;
  String author;
  String? authorUid;
  DateTime createdAt;
  String category;
  String imageUrl;
  DateTime? updatedAt;

  Post(
      {required this.id,
      this.updatedAt,
      required this.authorUid,
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
        authorUid: map['authorUid'],
        category: map['category'] ?? 'No category information',
        createdAt: (map['createdAt'] as Timestamp).toDate(),
        imageUrl: map['imageUrl'] ?? '');
  }

  factory Post.empty() {
    return Post(
        title: '',
        text: '',
        author: '',
        category: '',
        createdAt: DateTime.now(),
        imageUrl: '',
        authorUid: '',
        id: '');
  }

  Map<String, dynamic> toMap() {
    return {
      'authorUid': authorUid,
      'title': title,
      'text': text,
      'author': author,
      'category': category,
      'updatedAt': updatedAt,
      'createdAt': Timestamp.fromDate(createdAt),
      'imageUrl': imageUrl
    };
  }

  Post copyWith(
      {required String id,
      required String title,
      required String text,
      required String author,
      required DateTime createdAt,
      required String category,
      String imageUrl = ''}) {
    return Post(
        id: this.id,
        title: this.title,
        text: this.text,
        author: this.author,
        authorUid: authorUid,
        category: this.category,
        createdAt: this.createdAt,
        imageUrl: this.imageUrl);
  }

  String get formattedTime {
    return DateFormat('dd.MM.yyyy').format(createdAt);
  }
}
