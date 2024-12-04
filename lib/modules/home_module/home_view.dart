import 'package:blog_app/modules/home_module/home_controller.dart';
import 'package:blog_app/widgets/main_appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../globals/globals.dart';
import '../../globals/styles/text_styles.dart';
import '../../widgets/post_card.dart';
import '../post_module/post_controller.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final HomeController homeController = Get.put(HomeController());
  final PostController postController = Get.find<PostController>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppbar(),
      backgroundColor: Colors.white,
      body: RefreshIndicator(
        onRefresh: homeController.loadPosts,
        color: Colors.indigo,
        backgroundColor: Colors.white,
        child: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: DefaultTabController(
              length: categories.length,
              child: GestureDetector(
                onTap: () {
                  FocusScope.of(context).unfocus();
                },
                child: Column(
                  children: <Widget>[
                    TabBar(
                      onTap: (index) {
                        homeController.selectedCategory.value = categories[index];
                        homeController.getFilteredPosts();
                      },
                      tabAlignment: TabAlignment.start,
                      labelStyle: montserratTab.copyWith(color: Colors.black, fontSize: 14),
                      isScrollable: true,
                      tabs: categories.map((category) {
                        return Tab(text: category);
                      }).toList(),
                    ),
                    Expanded(
                      child: GetBuilder<HomeController>(builder: (controller) {
                        if (controller.isLoading) {
                          return SizedBox.expand(
                            child: Center(
                                child: CircularProgressIndicator()),
                          );
                        } else {
                          return ListView.builder(
                            padding: EdgeInsets.zero,
                            itemCount: controller.displayedPosts.length,
                            itemBuilder: (context, index) {
                              final post = controller.displayedPosts[index];
                              return PostCard(
                                  post: post,
                                  category:
                                      homeController.selectedCategory.value);
                            },
                          );
                        }
                      }),
                    ),
                  ],
                ),
              )),
        ),
      ),
    );
  }
}
