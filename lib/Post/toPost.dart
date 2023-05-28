// import 'package:favorite_button/favorite_button.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';

// class UserPostScreen extends StatefulWidget {
//   @override
//   State<UserPostScreen> createState() => _UserPostScreenState();
// }

// class _UserPostScreenState extends State<UserPostScreen> {
//   int id;
//   String title;
//   String categoryId;
//   String description;
//   String imageURL;
//   String location;
//   int rating;
  
//   @override
//   Widget build(BuildContext context) {
//     return Card(
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
//                           addToFavoriteList();
//                         },
//                       ),
//                     ]),
//               )
//             ]));
//   }
// }
