import 'package:blog_app/modules/create_post_module/create_post_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../data/models/post.dart';
import '../../globals/globals.dart';
import '../../globals/styles/text_styles.dart';
import '../../routes/routes.dart';

class CreatePost extends StatelessWidget {
  final CreatePostController postController = Get.put(CreatePostController(),permanent: false);
  final TextEditingController title = TextEditingController(); // !!!!!
  final TextEditingController content = TextEditingController();

  CreatePost({
    super.key,
  }) {
    if (Get.arguments != null && Get.arguments is Post) {
      postController.isEditing = true;
      postController.post.value = Get.arguments;
      title.text = postController.post.value.title;
      content.text = postController.post.value.text;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => GestureDetector(
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
                      onChanged: (value) {postController.post.value.title = value;},
                      decoration: InputDecoration(
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 8),
                        label: Text('Title',
                            style: montserratAuth.copyWith(
                                color: Colors.grey.withOpacity(0.6),
                                fontSize: 20)),
                      ),
                    ),
                    sizedBox20(),
                    Text('Select a category', style: montserratAuth),
                    SizedBox(height: 10),
                    Wrap(
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
                          selected:
                              postController.post.value.category == category,
                          onSelected: (bool selected) {
                            if (selected) {
                              postController.post.update((post) {
                                post?.category = category;
                              });
                            }
                          },
                        );
                      }).toList(),
                    ),
                    sizedBox20(),
                    TextField(
                      maxLines: 17,
                      controller: content,
                      onChanged: (value) {postController.post.value.text = value;},
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Start writing...',
                        hintStyle: montserratHint.copyWith(
                            fontSize: 15, color: Colors.grey.withOpacity(0.9)),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 6, horizontal: 6),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }

  Widget closePage() {
    return GestureDetector(
        onTap: () {
          postController.closeUnsaved();
          Get.back();
        },
        child: Icon(Icons.close_rounded, color: Colors.indigo, size: 25));
  }

  Widget nextButton(String displayName) {
    return ElevatedButton(
        onPressed: () => Get.toNamed(Routes.previewPage, arguments: postController.post.value),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.indigo.shade600,
          padding: EdgeInsets.symmetric(horizontal: 5, vertical: 3),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(17),
          ),
        ),
        child:
            Text('Next', style: montserratBody.copyWith(color: Colors.white)));
  }
}
