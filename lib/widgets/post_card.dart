import 'package:blog_app/pages/post_detail_page.dart';
import 'package:blog_app/utils/constants.dart';
import 'package:flutter/material.dart';

import '../models/post.dart';

class PostCard extends StatelessWidget {
  final Post post;
  final String category;

  const PostCard({super.key, required this.post, required this.category});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => PostDetailPage(post: post)));
      },
      child: Card(
        margin: const EdgeInsets.all(10),
        child: ListTile(
          contentPadding: const EdgeInsets.all(10),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      post.title,
                      style: homePostTitle.copyWith(
                          fontSize: 25, color: Colors.indigo),
                    ),
                  ),
                  const SizedBox(width: 10),
                  if (category == 'All')
                    Chip(
                      side: BorderSide(color: Colors.grey.shade500),
                      label: Text(post.category,
                          style: montserratBody.copyWith(
                            color: Colors.white,
                            fontVariations: [
                              const FontVariation('ital', 0),
                              const FontVariation('wght', 450),
                              const FontVariation('ital', 1),
                              const FontVariation('wght', 450)
                            ],
                          )),
                      backgroundColor:
                          getCategoryColor(post.category).withOpacity(0.5),
                    )
                ],
              ),
              const SizedBox(height: 10),
              if (post.imageUrl.isNotEmpty) Image.network(post.imageUrl),
              const SizedBox(height: 10),
              Row(
                children: [
                  Text(
                    'by ${post.author}',
                    style: montserratBody.copyWith(fontSize: 13),
                  ),
                  const Spacer(),
                  Text(post.formattedTime,
                      style: montserratBody.copyWith(fontSize: 13)),
                ],
              ),
              const SizedBox(height: 7),
              Row(
                children: [
                  Flexible(
                    child: Text(
                      post.text,
                      maxLines: 3,
                      overflow: TextOverflow.fade,
                      style: homePostText.copyWith(
                          color: Colors.black, fontSize: 15),
                    ),
                  ),
                  const Icon(Icons.navigate_next_rounded,
                      size: 30, color: Colors.indigo),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  MaterialColor getCategoryColor(String category) {
    switch (category) {
      case 'Philosophy':
        return Colors.purple;
      case 'Literature':
        return Colors.orange;
      case 'Science':
        return Colors.blue;
      case 'Nature':
        return Colors.green;
      case 'Technology':
        return Colors.indigo;
      default:
        return Colors.grey;
    }
  }
}
