import 'package:blog_app/modules/auth_module/login_view.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';


import '../home_module/home_view.dart';

class HomeBar extends StatefulWidget {
  const HomeBar({super.key});

  @override
  State<HomeBar> createState() => _HomeBarState();
}

class _HomeBarState extends State<HomeBar> {
  final RxInt currentPageIndex = 1.obs;
  List<Widget> get _pages => <Widget>[
        Center(
            child: GestureDetector(
                onTap: () {
                },
                child: Text("see if there any signed in user"))),
        Home(),
        LoginScreen(),
      ];

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
        bottomNavigationBar: NavigationBar(
          backgroundColor: Colors.indigo.shade50,
          height: 75,
          onDestinationSelected: (int index) {
            if (index == 2) {
              //selectedindex 2 ise
              Get.toNamed('/login');
            } else {
              currentPageIndex.value = index;
            }
          },
          indicatorColor: Colors.indigo.shade200,
          selectedIndex: currentPageIndex.value,
          destinations: const <Widget>[
            NavigationDestination(
              selectedIcon: Icon(Icons.search),
              icon: Icon(Icons.search_outlined),
              label: 'Search',
            ),
            NavigationDestination(
              selectedIcon: Icon(Icons.home),
              icon: Icon(Icons.home_outlined),
              label: 'Home',
            ),
            NavigationDestination(
              selectedIcon: Icon(Icons.account_circle),
              icon: Icon(Icons.account_circle_outlined),
              label: 'Profile',
            ),
          ],
        ),
        body: _pages[currentPageIndex.value]));
  }
}
