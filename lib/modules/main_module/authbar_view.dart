import 'package:blog_app/modules/create_post_module/create_post_view.dart';
import 'package:blog_app/user_profile.dart';
import 'package:blog_app/modules/home_module/home_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class AuthBar extends StatefulWidget {

  const AuthBar({super.key});

  @override
  State<AuthBar> createState() => _AuthBarState();
}

class _AuthBarState extends State<AuthBar> {
  var destinations = <Widget>[
    NavigationDestination(
        selectedIcon: Icon(Icons.search),
        icon: Icon(Icons.search_outlined),
        label: 'Search'),
    NavigationDestination(
        selectedIcon: Icon(Icons.bookmark),
        icon: Icon(Icons.bookmark_border_outlined),
        label: 'Saved'),
    NavigationDestination(
        selectedIcon: Icon(Icons.home),
        icon: Icon(Icons.home_outlined),
        label: 'Home'),
    NavigationDestination(
        selectedIcon: Icon(Icons.create),
        icon: Icon(Icons.create_outlined),
        label: 'Create'),
    NavigationDestination(
        selectedIcon: Icon(Icons.account_circle),
        icon: Icon(Icons.account_circle_outlined),
        label: 'Profile'),
  ];

  List<Widget> get _pages => <Widget>[
    Center(child: GestureDetector(onTap: () {
    },child: Text("see if there any signed in user"))),
    Center(child: Text("That's for saved posts")),
    Home(),
    CreatePost(),
    UserProfile(),
  ];

  final RxInt currentPageIndex = 2.obs;

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
      bottomNavigationBar: NavigationBar(
        destinations: destinations,
        backgroundColor: Colors.indigo.shade50,
        height: 75,
        onDestinationSelected: (int index) {
          if(index == 3) {
            Get.toNamed('/create');
          } else {
            currentPageIndex.value = index;
          }
        },
        indicatorColor: Colors.indigo.shade200,
        selectedIndex: currentPageIndex.value,
      ),
      body: _pages[currentPageIndex.value],
    ));
  }

}
