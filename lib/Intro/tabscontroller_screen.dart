import 'package:explorify/Account/accountInfo.dart';
import 'package:explorify/Categories/categories_screen.dart';
//import 'package:explorify/saved/saved_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../Category/category_screen.dart';
import '../Explore/explore_screen.dart';
import '../Explore/explore_screen.dart';
import '../Post/createPostPage.dart';
import '../Saved/saved_screen.dart';
import '../Search/search.dart';
//import '../Favorite/saved.dart';

class TabsControllerScreen extends StatefulWidget {
  const TabsControllerScreen({Key? key}) : super(key: key);

  @override
  _TabsControllerScreenState createState() => _TabsControllerScreenState();
}

class _TabsControllerScreenState extends State<TabsControllerScreen> {
  final List<Widget> myPages = [
    CategoriesPage(),
    FavoritePage(),
    ExploreScreen(),
    PostSearchPage(),
    CreatePost(),
    AccountInfoPage(),
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
            child: Icon(Icons.logout_rounded),
          ),
        ],
      ),
      body: myPages[selectedTabIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.list_alt_rounded),
            backgroundColor: Colors.black,
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_rounded),
            backgroundColor: Colors.black,
            label: 'Favorites',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.explore_rounded),
            backgroundColor: Colors.black,
            label: 'Explore',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            backgroundColor: Colors.black,
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.camera_alt_rounded), // Camera icon
            backgroundColor: Colors.black,
            label: 'Add Post',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_box_rounded),
            backgroundColor: Colors.black,
            label: 'MyAccount',
          ),
        ],
        currentIndex: selectedTabIndex,
        onTap: switchPage,
      ),
    );
  }
}
