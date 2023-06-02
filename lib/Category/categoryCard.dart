// import 'package:explorify/Providers/provider.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../Providers/Provider.dart';
// import './category.dart';
// import 'package:favorite_button/favorite_button.dart';
// import 'package:http/http.dart' as http;

// class CategoryCard extends StatelessWidget {
//   Category cat;
//   bool isFavorite = false;
//   CategoryCard({super.key, required this.cat});
//   List<Category> favoriteList = [];

//   // final favURL = Uri.parse('https://explorify24-f06aa-default-rtdb.firebaseio.com/');

//   void goToSpecificCategory(BuildContext myContext) {
//     {
//       Navigator.of(myContext)
//           .pushNamed('/categoryRoute', arguments: {'category': cat});
//     }
//   }

//   void addToFavoriteList() async {
//     if (isFavorite) {
//       favoriteList.add(cat);
//       //  var prefs = await SharedPreferences.getInstance();
//       //  prefs.s(likedKey, liked);
//     }
//   }

//   List<Category> getFavortieList() {
//     return favoriteList;
//   }

//   navigateToFavPage(BuildContext myContext) {
//     Navigator.of(myContext)
//         .pushNamed('/favoriteRoute', arguments: {'category': cat});
//   }

//   Widget getRating(int r) {
//     if (r == 1) {
//       return const Icon(Icons.star);
//     } else if (r == 2) {
//       return Row(children: [Icon(Icons.star), Icon(Icons.star)]);
//     } else if (r == 3) {
//       return Row(
//           children: [Icon(Icons.star), Icon(Icons.star), Icon(Icons.star)]);
//     } else if (r == 4) {
//       return Row(children: [
//         Icon(Icons.star),
//         Icon(Icons.star),
//         Icon(Icons.star),
//         Icon(Icons.star)
//       ]);
//     }
//     return Row(children: [
//       Icon(Icons.star),
//       Icon(Icons.star),
//       Icon(Icons.star),
//       Icon(Icons.star),
//       Icon(Icons.star)
//     ]);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//         onTap: () => goToSpecificCategory(context),
//         child: Card(
//             shape:
//                 RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
//             elevation: 4,
//             margin: const EdgeInsets.all(10),
//             child: Column(children: [
//               Stack(
//                 children: [
//                   ClipRRect(
//                       borderRadius: const BorderRadius.only(
//                           topLeft: Radius.circular(15),
//                           topRight: Radius.circular(15)),
//                       child: Image.network(cat.imageURL,
//                           height: 250,
//                           width: double.infinity,
//                           fit: BoxFit.cover)),
//                   Positioned.fill(
//                     bottom: 0,
//                     child: ClipRRect(
//                         borderRadius: const BorderRadius.only(
//                             topLeft: Radius.circular(15),
//                             topRight: Radius.circular(15)),
//                         child: Container(
//                             color: Colors.black38,
//                             child: Center(
//                                 child: Text(cat.title,
//                                     softWrap: true,
//                                     overflow: TextOverflow.fade,
//                                     style: const TextStyle(
//                                         color: Colors.white, fontSize: 30),
//                                     textAlign: TextAlign.center)))),
//                   ),
//                 ],
//               ),
//               Container(
//                 margin: const EdgeInsets.all(15),
//                 padding: const EdgeInsets.all(5),
//                 child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceAround,
//                     children: [
//                       Row(children: [
//                         Icon(
//                           Icons.cancel,
//                           size: 33.0,
//                           color: Colors.green,
//                         ),
//                         Text("Likes"),
//                       ]),
//                       Row(children: [
//                         getRating(cat.rating),
//                       ]),
//                       FavoriteButton(
//                         isFavorite: isFavorite,
//                         valueChanged: (isFavorite) {
//                           Navigator.of(context).pushNamed('/favoriteRoute');
//                         },
//                         // onPressed(){
//                         //   DatabaseReference dataref = FirebaseDatabase.instance.reference.child("Data").child("id")
//                         // }
//                       ),
//                     ]),
//               )
//             ])));
//   }
// }
