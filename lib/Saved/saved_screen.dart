// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// import '../Category/categorycard.dart';
// import '../Category/categoryList.dart';


// class FavoriteScreen extends StatefulWidget {
//   const FavoriteScreen({super.key});

//   @override
//   State<FavoriteScreen> createState() => _FavoriteScreenState();
// }

// class _FavoriteScreenState extends State<FavoriteScreen> {
//   static const likedKey = 'liked_key';
//   late bool liked = false;

//   @override
//   void initState() {
//     super.initState();
//     _restorePersistedPreference();
//   }

//   void _restorePersistedPreference() async {
//     var prefs = await SharedPreferences.getInstance();
//     var liked = prefs.getBool(likedKey);

//     setState(() => this.liked = liked!);
//   }

//   void _persistPreference() async {
//     setState(() => liked = !liked);
//     var prefs = await SharedPreferences.getInstance();
//     prefs.setBool(likedKey, liked);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return GridView.count(
//         crossAxisCount: 1,
//         crossAxisSpacing: 30,
//         children: categoriesList.map((c) {
//           return CategoryCard(cat: c);
//         }).toList());
//   }
// }
