import 'package:blog_app/models/user.dart';
import 'package:blog_app/pages/editor/create_post.dart';
import 'package:blog_app/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NavbarAuth extends StatefulWidget {
  final String uid;
  final String displayName;
  final String email;
  final String role;

  const NavbarAuth({super.key, required this.uid, required this.displayName, required this.email, required this.role});

  @override
  State<NavbarAuth> createState() => _NavbarAuthState();
}

class _NavbarAuthState extends State<NavbarAuth> {
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

  // final User? currentUser = Get.arguments;

  List<Widget> get _pages => <Widget>[
    Center(child: Text("That's for searching")),
    Center(child: Text("That's for saved posts")),
    Home(userName: widget.displayName),
    CreatePost(),
    Center(child: Text("That's for account settings")),
  ];

  final RxInt currentPageIndex = 2.obs; //varsayilan home

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
