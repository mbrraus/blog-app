import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../data/models/post.dart';
import '../globals/styles/text_styles.dart';
import '../routes/routes.dart';

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
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.account_circle, size: 16, color: Colors.grey),
                  const SizedBox(width: 3),
                  Text(
                    post.author,
                    style: montserratBody.copyWith(
                      fontSize: 13,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(width: 240),
                  Expanded(
                    child: Align(
                        alignment: Alignment.topRight,
                        child: GestureDetector(
                            onTap: () => Get.toNamed(Routes.createPage),
                            child: Icon(Icons.bookmark_border_outlined))),
                  )
                ],
              ),

              Row(
                children: [
                  Expanded(
                    child: Text(
                      post.title,
                      style: homePostTitle.copyWith(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.indigo,
                      ),
                    ),
                  ),
                ],
              ),

              Row(
                children: [
                  if (category == 'All')
                    Text(
                      post.category,
                      style: montserratBody.copyWith(
                        fontSize: 9,
                        color: Colors.grey,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                ],
              ),
              SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 200,
                    child: Text(
                      post.text,
                      maxLines: 7,
                      overflow: TextOverflow.ellipsis,
                      style: homePostText.copyWith(
                        color: Colors.black87,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  SizedBox(width: 12),
                  if (post.imageUrl.isNotEmpty)
                    _buildImageWithBottomFade(post.imageUrl),
                ],
              ),
              // const SizedBox(height: 10),
              //
              // const SizedBox(height: 10),

              const SizedBox(height: 10),
              Row(
                children: [
                  const Spacer(),
                  Text(
                    post.formattedTime,
                    style: montserratBody.copyWith(
                      fontSize: 12,
                      color: Colors.black54,
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
    return Expanded(
      child: Container(
        height: 150,
        width: 150,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12.0),
              child: Image.network(
                imageUrl,
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            // Positioned.fill(
            //   child: Container(
            //     decoration: BoxDecoration(
            //       gradient: LinearGradient(
            //         begin: Alignment.topCenter,
            //         end: Alignment.bottomCenter,
            //         colors: [
            //           Colors.grey.withOpacity(0.1),
            //           Colors.white,
            //         ],
            //         stops: [0.9, 1.0],
            //       ),
            //     ),
            //   ),
            // ),
          ],
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
        return Colors.red;
    }
  }
}
