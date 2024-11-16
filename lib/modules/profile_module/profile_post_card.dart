import 'package:blog_app/globals/styles/text_styles.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../data/models/post.dart';
import '../../routes/routes.dart';

class ProfilePostCard extends StatelessWidget {
  final Post post;

  const ProfilePostCard({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Colors.white,
      margin: EdgeInsets.symmetric(vertical: 12.0),
      child: ListTile(
          leading: post.imageUrl.isNotEmpty
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(3.0),
                  child: Container(
                    width: 65,
                    height: 100,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 1,
                          offset: Offset(0, 0),
                        ),
                      ],
                    ),
                    child: CachedNetworkImage(
                      imageUrl: post.imageUrl,
                      fit: BoxFit.cover,
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                  ),
                )
              : Icon(Icons.image_outlined, size: 60),
          title: Text(
            post.title,
            style: montserratBody,
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(post.text, maxLines: 2, overflow: TextOverflow.ellipsis),
              SizedBox(height: 4),
              Text(post.formattedTime,
                  style: montserratAuth.copyWith(
                      fontSize: 11, color: Colors.black45)),
            ],
          ),
          trailing: PopupMenuButton(
              elevation: 3,
              position: PopupMenuPosition.over,
              icon: Icon(Icons.more_vert),
              iconColor: Colors.indigo,
              color: Colors.white,
              onSelected: (value) {
                if (value == Routes.createPage) {
                  Get.toNamed(Routes.createPage,
                      arguments: post.copyWith(
                          id: post.id,
                          title: post.title,
                          text: post.text,
                          author: post.author,
                          createdAt: post.createdAt,
                          category: post.category));
                } else {
                  Get.toNamed(value);
                }
              },
              itemBuilder: (BuildContext context) {
                return const [
                  PopupMenuItem(value: Routes.createPage, child: Text('Edit')),
                  PopupMenuItem(
                      value: Routes.profilePage, child: Text('Delete')),
                ];
              })),
    );
  }
}
