// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// import '../Category/categorycard.dart';
// import '../Category/categoryList.dart';
// import '../Providers/Provider.dart';

// class FavScreen extends StatefulWidget {
//  @override
//  _FavScreenState createState() => _FavScreenState();
// }
// class _FavScreenState extends State<FavScreen> {
// void initState(){
// var myProvider= Provider.of<FavProvider>(context,listen: false); 
// myProvider.fetchIdeasFromServer();
//  super.initState();
// }
//  @override
//  Widget build(BuildContext context) {
//  final FavsProvider =
//  Provider.of<FavProvider>(context, listen: true); 

//  final ideas = FavsProvider.getAllFavs; // calling the getter
 


//  return Scaffold(
//  appBar: AppBar(
//  title: Text('Favourites'),
//  ),
//  body: RefreshIndicator(
//  onRefresh: FavsProvider.fetchIdeasFromServer,
//  child: ListView.builder(
//  itemCount: ideas.length,
//  itemBuilder: (ctx, index) {
//  return Dismissible(

//  key: ValueKey(ideas[index].id),
//  background: Container(
//  alignment: Alignment.centerRight,
//  padding: EdgeInsets.only(right: 20),
//  color: Colors.red,
//  ),
 
//  child: ListTile(
//  title: Text(ideas[index].title),
//  subtitle: Text(ideas[index].description), 
// //  categoryId: Text(ideas[index].ideaBody),
// //  description: value['description'],
// //  likes: value['likes'],
// //  imageURL: value['imageURL'],
// //  location: value['Location'],
// //  rating:value['rating'],

//  ),
//  );
//  }),
//  ));
//  }


// }
//     Widget build(BuildContext context) {
//     return GridView.count(
//         crossAxisCount: 1,
//         crossAxisSpacing: 30,
//         children: categoriesList.map((c) {
//           return CategoryCard(cat: c);
//         }).toList());
//   }


