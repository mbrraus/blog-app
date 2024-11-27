import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../data/models/post.dart';
import '../globals/styles/text_styles.dart';

class PostCard extends StatelessWidget {
  final Post post;
  final String category;

  const PostCard({super.key, required this.post, required this.category});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed('/details', arguments: post);
      },
      child: Card(
        color: Colors.white,
        margin: const EdgeInsets.all(10),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      post.title,
                      style: homePostTitle.copyWith(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.indigo,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  if (category == 'All')
                    Chip(
                      side: BorderSide(color: Colors.transparent),
                      elevation: 0.5,
                      shadowColor: Colors.grey,
                      label: Text(
                        post.category,
                        style: montserratBody.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      backgroundColor:
                          getCategoryColor(post.category).withOpacity(0.5),
                    ),
                ],
              ),
              Row(
                children: [
                  Icon(Icons.account_circle, size: 16, color: Colors.grey),
                  const SizedBox(width: 3),
                  Text(
                    post.author,
                    style: montserratBody.copyWith(
                      fontSize: 12,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              if (post.imageUrl.isNotEmpty)
                _buildImageWithBottomFade(post.imageUrl),
              const SizedBox(height: 10),
              Text(
                post.text,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: homePostText.copyWith(
                  color: Colors.black87,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  const Spacer(),
                  Text(
                    post.formattedTime,
                    style: montserratBody.copyWith(
                      fontSize: 12,
                      color: Colors.black45,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImageWithBottomFade(String imageUrl) {
    return Container(
      height: 200,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: Image.network(
              imageUrl,
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.grey.withOpacity(0.1),
                    Colors.white,
                  ],
                  stops: [0.9, 1.0],
                ),
              ),
            ),
          ),
        ],
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
