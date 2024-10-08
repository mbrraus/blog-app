import 'package:blog_app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/post.dart';

class PostDetailPage extends StatelessWidget {
  const PostDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Post post = Get.arguments;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: GestureDetector(
                    onTap: () => Get.back(),
                    child: const Icon(
                      Icons.arrow_back_ios_new,
                      color: Colors.indigo,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                if (post.imageUrl.isNotEmpty) Image.network(post.imageUrl),
                const SizedBox(height: 10),
                Row(children: [
                  Text('by ${post.author}', style: montserratBody),
                  const SizedBox(width: 175),
                  Text(
                    style: montserratBody,
                    post.formattedTime,
                    textAlign: TextAlign.end,
                  )
                ]),
                const SizedBox(height: 20),
                Text(post.text,
                    style: homePostText.copyWith(
                      fontSize: 16,
                      color: Colors.black,
                      fontVariations: [
                        const FontVariation('ital', 0),
                        const FontVariation('wght', 400),
                        const FontVariation('ital', 1),
                        const FontVariation('wght', 400)
                      ],
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
