import 'package:blog_app/auth/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'home.dart';

class HomeMain extends StatefulWidget {
  const HomeMain({super.key});

  @override
  State<HomeMain> createState() => _HomeMainState();
}

class _HomeMainState extends State<HomeMain> {
  final RxInt currentPageIndex = 1.obs;

  final List<Widget> _pages = [
    Center(child: Text("That's for searching")),
    Home(),
    LoginScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Obx(()=> Scaffold(
        bottomNavigationBar: NavigationBar(
          backgroundColor: Colors.indigo.shade50,
          height: 75,
          onDestinationSelected: (int index) {
            if (index == 2) {
              //selectedindex 2 ise
              Get.toNamed('/login');
            } else {
              print('destination selected');
              currentPageIndex.value = index;
              print('current page index: $currentPageIndex');
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
        body: _pages[currentPageIndex.value]
    ));
  }
}
