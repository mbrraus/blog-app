import 'package:blog_app/auth/login_screen.dart';
import 'package:flutter/material.dart';

import 'home.dart';

class HomeMain extends StatefulWidget {
  const HomeMain({super.key});

  @override
  State<HomeMain> createState() => _HomeMainState();
}

class _HomeMainState extends State<HomeMain> {

  int currentPageIndex = 1;

  final List<Widget> _pages = [
    Center(child: Text("That's for searching")),
    Home(),
    LoginScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        backgroundColor: Colors.indigo.shade50,
        height: 75,
        onDestinationSelected: (int index) {
          setState(() {
            if(index == 2) { //selectedindex 2 ise
              Navigator.of(context).push(MaterialPageRoute(builder: (context)=> LoginScreen()));
            } else {
              currentPageIndex = index;
            }

          });
        },
        indicatorColor: Colors.indigo.shade200,
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            icon: Icon(Icons.search_sharp),
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
      body: _pages[currentPageIndex]
    );
  }
}
