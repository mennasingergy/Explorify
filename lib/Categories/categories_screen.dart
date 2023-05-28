import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:explorify/Categories/categoryList.dart';
import 'package:flutter/cupertino.dart';
import 'category.dart';
// import 'categoryList.dart';
import 'categoryCard.dart';

class ExplorePage extends StatelessWidget {
  // const ExplorePage({super.key});
  //var categoriesInstance = FirebaseFirestore.instance.collection("Categories");
  // final List<Widget> categories = [];

  // List<Widget> getCategories() {
  //   var stream = categoriesInstance.snapshots();

  //   stream.listen((snapshot) {
  //     snapshot.docs.forEach((document) {
  //       var x = ExploreCategory(
  //           id: document.data()['id'],
  //           title: document.data()['title'],
  //           imageURL: document.data()['imgURL'],
  //           description: "menna is trying so hard :/");
  //       categories.add(CategoryCard(cat: x));
  //     });
  //   });
  //   return categories;
  // }

  @override
  Widget build(BuildContext context) {
    return GridView.count(
        crossAxisCount: 1,
        // crossAxisSpacing: 30,
        children: categoryList.map((c) {
          return CategoryCard(cat: c);
        }).toList());
    //getCategories());
  }
}
