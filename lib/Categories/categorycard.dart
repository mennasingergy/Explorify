// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'category.dart';

// class CategoryCard extends StatelessWidget {
//   final Category cat;

//   CategoryCard({required this.cat});

//   navigateToCategoryPage(BuildContext context) {
//     Navigator.of(context).pushNamed('/categoryRoute', arguments: {'category': cat});
//   }

//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: () => navigateToCategoryPage(context),
//       child: Card(
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
//         elevation: 4,
//         margin: const EdgeInsets.all(10),
//         child: Column(
//           children: [
//             Stack(
//               children: [
//                 ClipRRect(
//                   borderRadius: const BorderRadius.only(
//                     topLeft: Radius.circular(15),
//                     topRight: Radius.circular(15),
//                   ),
//                   child: Image.network(
//                     cat.imageURL,
//                     height: 250,
//                     width: double.infinity,
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//                 Positioned.fill(
//                   bottom: 0,
//                   child: ClipRRect(
//                     borderRadius: const BorderRadius.only(
//                       topLeft: Radius.circular(15),
//                       topRight: Radius.circular(15),
//                     ),
//                     child: Container(
//                       color: Colors.black38,
//                       child: Center(
//                         child: Text(
//                           cat.title,
//                           softWrap: true,
//                           overflow: TextOverflow.fade,
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 30,
//                           ),
//                           textAlign: TextAlign.center,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             SizedBox(height: 15.0),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text(
//                   cat.description,
//                   style: GoogleFonts.alexandria(fontSize: 15),
//                 ),
//                 SizedBox(height: 12.0),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }