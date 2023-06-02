// import 'package:explorify/Category/category.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../Categories/category.dart';
// import './categoryCard.dart';
// import './categoryList.dart';
// import '../complements/myDropDownButton.dart';
// import 'package:image_picker/image_picker.dart';
// import '../complements/galleryAccess.dart';
// import 'package:uuid/uuid.dart';

// import '../Providers/Provider.dart';

// class CategoryScreen extends StatefulWidget {
//   const CategoryScreen({super.key});

//   @override
//   _CategoryScreenState createState() => _CategoryScreenState();
// }

// class _CategoryScreenState extends State<CategoryScreen> {
//   late TextEditingController RateController;
//   late TextEditingController NameController;
//   late TextEditingController DescController;
//   late TextEditingController LocController;
//   bool likes = false;
//   var prefs;
//   var uuid = Uuid();

//   @override
//   void initState() {
//     super.initState();
//     RateController = TextEditingController();
//     NameController = TextEditingController();
//     DescController = TextEditingController();
//     LocController = TextEditingController();
//     // var myProvider= Provider.of<FavProvider>(context,listen: false); 
//     // myProvider.fetchIdeasFromServer();
//     // super.initState();
//   }

//   Future<void> getSwitchStates() async {
//     // prefs = await SharedPreferences.getInstance();
//     // setState(() {
//     //   vegeterianSwitch = prefs.getBool('vgt') ?? false;
//     //   veganSwitch = prefs.getBool('veg') ?? false;
//     // });
//   }

//   // void initState() {
//   //   getSwitchStates();
//   //   super.initState();
//   // }
//   addPost(
//       {required String id,
//       required String c,
//       required String n,
//       required String desc,
//       required String URL,
//       required int r,
//       required String loc}) {
//     setState(() {
//       Category(
//           id: id,
//           categoryId: c, //di mn el dropdown ezay agbha?
//           title: n,
//           description: desc,
//           imageURL: URL, //mafrood el sora el men el cam or gallery ezay agebha?
//           location: loc,
//           rating: r,
//           likes:
//               0,
//            //hwa el mafrood tb'a counter w intially b zero w a3mel function b display el likes?
//           );
//     });
//   }

//   Future OpenDialogue() => showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//               title: Text("Add Post:"),
//               content: Text(
//                 "What do you want to share?",
//                 style: TextStyle(fontWeight: FontWeight.bold),
//               ),
//               actions: [
//                 Card(
//                     shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(15)),
//                     elevation: 4,
//                     margin: const EdgeInsets.all(10),
//                     child: Column(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           DropdownButtonExample(),
//                           Text("Name:"),
//                           TextField(
//                             decoration: InputDecoration(
//                               border: OutlineInputBorder(),
//                               hintText: 'What is your location name?',
//                             ),
//                             controller: NameController,
//                           ),
//                           Text("Rating:"),
//                           TextField(
//                             decoration: InputDecoration(
//                               border: OutlineInputBorder(),
//                               hintText: 'Rate your experience',
//                             ),
//                             controller: RateController,
//                           ),
//                           Text("Description:"),
//                           TextField(
//                             decoration: InputDecoration(
//                                 labelText: 'Describe your Location'),
//                             keyboardType: TextInputType.multiline,
//                             minLines: 1,
//                             maxLines: 5,
//                             controller: DescController,
//                           ),
//                           Text("Location:"),
//                           TextField(
//                             decoration: InputDecoration(
//                               border: OutlineInputBorder(),
//                               hintText: 'Where is your location?',
//                             ),
//                             controller: LocController,
//                           ),
//                           GalleryAccess(),
//                           Row(children: [
//                             TextButton.icon(
//                                 onPressed: addPost(
//                                     id: uuid.v4(),
//                                     c: DropdownButtonExample().toString(),
//                                     n: NameController.toString(),
//                                     desc: DescController.toString(),
//                                     URL: 'tgtth',
//                                     loc: LocController.toString(),
//                                     r: int.parse(RateController.toString())),
//                                 icon: Icon(Icons.check_box_rounded),
//                                 label: Text('Post!'))
//                           ])
//                         ]))
//               ]));

//   @override
//   Widget build(BuildContext context) {
//     final routeArgs = ModalRoute.of(context)!.settings.arguments
//         as Map<String, ExploreCategory>;
//     final category = routeArgs['category'];
//     final categoryInThatCategory = categoriesList.where((element) {
//       return element.categoryId.contains(category!.id);
//     }).toList();
//     // final filteredRecipes = categoryInThatCategory.where((element) {
//     //   if (element.isVegeterian == false && vegeterianSwitch == true) {
//     //     return false;
//     //   } else if (element.isVegan == false && veganSwitch == true) {
//     //     return false;
//     //   } else
//     //     return true;
//     // }).toList();

//     // final ideasProvider = Provider.of<FavProvider>(context, listen: true);
//     // final favPosts = ideasProvider.getAllFavs;

//     return Scaffold(
//       appBar: AppBar(
//           backgroundColor: Color.fromARGB(210, 214, 132, 17),
//           title: Text(category!.title),
//           actions: [
//             Row(mainAxisAlignment: MainAxisAlignment.start, children: [
//               InkWell(
//                 child: Icon(Icons.add_a_photo_rounded),
//                 onTap: OpenDialogue,
//               )
//             ])
//           ]),
//       body: ListView.builder(
//         itemBuilder: (ctx, index) {
//           return CategoryCard(cat: categoryInThatCategory[index]);
//         },
//         itemCount: categoryInThatCategory.length,
//       ),
//     );
//   }
// }
