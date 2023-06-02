// import 'dart:convert';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import '../Category/category.dart';
// import 'package:favorite_button/favorite_button.dart';
// import 'package:http/http.dart' as http;


// class FavProvider with ChangeNotifier {

//  List<Category> favoriteList = [];
//  final favURL = Uri.parse('https://explorify24-f06aa-default-rtdb.firebaseio.com/IdeasFirebase.json');


//  Future<void> fetchIdeasFromServer() async {

//     try {
//     var response = await http.get(favURL);
//     var fetchedData = json.decode(response.body) as Map<String, dynamic>;
//     favoriteList.clear();
//     fetchedData.forEach((key, value) {

//     favoriteList.add(Category(
//     id: key,
//     title: value['ideaTitle'], 
//     categoryId: value['categoryID'],
//     description: value['description'],
//     likes: value['likes'],
//     imageURL: value['imageURL'],
//     location: value['Location'],
//     rating:value['rating'],
//     ));

//     });
//     notifyListeners();
//     } catch (err) {}
//  }

//   //  final String id;
//   // final String title;
//   // final String categoryId;
//   // final String description;
//   // final int likes;
//   // final String imageURL;
//   // final String location;
//   // final int rating;
//  Future<void> addFav(String t, String c, String desc, String likes, String img, String loc, String r) {

//     return http
//     .post(favURL, body: json.encode({'title': t, 'categoryId': c, 'description': desc, 'likes': likes, 'imageURL': img, 'location': loc, 'rating': r}))
//     .then((response) {
//     favoriteList.add(Category(
//     id: json.decode(response.body)['name'], title: t, categoryId: c, description: desc, likes: 1, imageURL: img, location: loc, rating: 1));
//     notifyListeners();
//     }).catchError((err) {
//     print("provider:" + err.toString());
//     throw err;
//     });
//  }
//  List<Category> get getAllFavs {
//     return favoriteList;
//  }
//  void deleteIdea(String id_to_delete) async {
//     var favToDeleteURL = Uri.parse(
//     ' https://explorify24-f06aa-default-rtdb.firebaseio.com/IdeasFirebase/$id_to_delete.json');
//     try {
//     await http.delete(favToDeleteURL); // wait for the delete request to be done
//     favoriteList.removeWhere((element) { // when done, remove it locally.
//     return element.id == id_to_delete;
//     });
//     notifyListeners(); // to update our list without the need to refresh
//     }
//     catch(err) {}
//  }
// }