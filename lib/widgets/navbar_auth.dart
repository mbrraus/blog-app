import 'package:blog_app/auth/login_screen.dart';
import 'package:blog_app/models/user.dart';
import 'package:blog_app/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class NavbarAuth extends StatefulWidget {

  const NavbarAuth({super.key});

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

  final User? currentUser = Get.arguments;

  List<Widget> get _pages => <Widget>[
    Center(child: Text("That's for searching")),
    Center(child: Text("That's for saved posts")),
    Home(currentUser: currentUser),
    Center(child: Text("That's for adding post!")),
    Center(child: Text("That's for account settings")),
  ];

  int currentPageIndex = 2; //varsayilan home

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      bottomNavigationBar: NavigationBar(
        destinations: destinations,
        backgroundColor: Colors.indigo.shade50,
        height: 75,
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        indicatorColor: Colors.indigo.shade200,
        selectedIndex: currentPageIndex,
      ),
      body: _pages[currentPageIndex],
    );
  }

}
