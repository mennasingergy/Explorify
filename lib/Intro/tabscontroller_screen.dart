import 'package:explorify/Categories/categories_screen.dart';
import 'package:explorify/Search/MySearchPage.dart';
import 'package:explorify/saved/saved_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../Category/category_screen.dart';
import '../Explore/explore_screen.dart';
import '../Saved/saved.dart';

class TabsControllerScreen extends StatefulWidget {
  const TabsControllerScreen({super.key});

  @override
  _TabsControllerScreenState createState() => _TabsControllerScreenState();
}

class _TabsControllerScreenState extends State<TabsControllerScreen> {
  final List<Widget> myPages = [
    ExplorePage(),
    FavScreen(),
    ExploreScreen(),
    MySearchPage()
  ];
  var selectedTabIndex = 0;
  void switchPage(int index) {
    setState(() {
      selectedTabIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(210, 214, 132, 17),
          title: const Text('Explorify'),
          actions: [
            GestureDetector(
                onTap: () {
                  FirebaseAuth.instance.signOut();
                },
                child: Icon(Icons.logout_rounded))
          ],
          //leading: BackButton(),
        ),
        body: myPages[selectedTabIndex],
        bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.list_alt_rounded),
              backgroundColor: Colors.black,
              label: 'Categories',
            ),
            const BottomNavigationBarItem(
                icon: Icon(Icons.favorite_rounded),
                backgroundColor: Colors.black,
                label: 'Favorites'),
            const BottomNavigationBarItem(
                icon: Icon(Icons.explore_rounded),
                backgroundColor: Colors.black,
                label: 'Explore'),
            const BottomNavigationBarItem(
                icon: Icon(Icons.search),
                backgroundColor: Colors.black,
                label: 'Search'),
            const BottomNavigationBarItem(
                icon: Icon(Icons.account_box_rounded),
                backgroundColor: Colors.black,
                label: 'MyAccount'),
          ],
          currentIndex: selectedTabIndex,
          onTap: switchPage,
        ));
  }
}
