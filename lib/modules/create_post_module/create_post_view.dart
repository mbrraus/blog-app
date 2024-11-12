import 'package:blog_app/modules/create_post_module/create_post_controller.dart';
import 'package:blog_app/modules/create_post_module/preview_post_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../globals/globals.dart';
import '../../globals/styles/text_styles.dart';

class CreatePost extends StatefulWidget {
  const CreatePost({super.key});

  @override
  State<CreatePost> createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {
  TextEditingController title = TextEditingController();
  TextEditingController content = TextEditingController();

  final CreatePostController postController = Get.put(CreatePostController());

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          scrolledUnderElevation: 0,
          backgroundColor: Colors.white,
          leading: closePage(),
          actions: [
            Container(
                padding: EdgeInsets.only(right: 20),
                child: nextButton('sevval'))
          ],
          toolbarHeight: 40,
        ),
        backgroundColor: Colors.white,
        body: Padding(
          padding: EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: title,
                  decoration: InputDecoration(
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    contentPadding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                    label: Text('Title',
                        style: montserratAuth.copyWith(color: Colors.grey.withOpacity(0.6),fontSize: 20)),
                  ),
                ),
                sizedBox20(),
                Text('Select a category', style: montserratAuth),
                SizedBox(height: 10),
                Obx(
                  () => Wrap(
                    spacing: 8.0,
                    children: categories
                        .where((category) => category != 'All')
                        .map((category) {
                      return FilterChip(
                        elevation: 0.5,
                        shadowColor: Colors.black,
                        side: BorderSide(color: Colors.transparent),
                        backgroundColor: Color(0xffEFF1F3),
                        disabledColor: Colors.white,
                        selectedColor: Colors.indigo.shade100,
                        label: Text(category, style: montserratAuth),
                        selected: postController.selectedCategories
                            .contains(category),
                        onSelected: (bool selected) {
                          postController.selectCategory(selected, category);
                        },
                      );
                    }).toList(),
                  ),
                ),
                sizedBox20(),
                TextField(
                  maxLines: 17,
                  controller: content,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Start writing...',
                    hintStyle: montserratHint.copyWith(
                        fontSize: 15, color: Colors.grey.withOpacity(0.9)),
                    contentPadding:
                        const EdgeInsets.symmetric(vertical: 6, horizontal: 6),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget closePage() {
    return GestureDetector(
        onTap: () => Get.back(),
        child: Icon(Icons.close_rounded, color: Colors.indigo, size: 25));
  }
  Widget nextButton(String displayName) {
    return ElevatedButton(
        onPressed: () => Get.to(() => PreviewPost(
            title: title.text,
            content: content.text,
            selectedCategory:
            postController.selectedCategories.first,
            author: displayName)),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.indigo.shade600,
          padding: EdgeInsets.symmetric(horizontal: 5, vertical: 3),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(17),
          ),
        ),
        child: Text('Next',
            style: montserratBody.copyWith(color: Colors.white)));
  }
}
