import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'categoryType.dart';

class CategoriesPage extends StatelessWidget {
  final CollectionReference categoriesCollection =
      FirebaseFirestore.instance.collection('Categories');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: categoriesCollection.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error fetching categories'));
          }

          final List<QueryDocumentSnapshot> categoryDocs = snapshot.data!.docs;

          final List<Map<String, dynamic>> categories = categoryDocs.map((doc) {
            final data = doc.data() as Map<String, dynamic>;
            return {
              'id': doc.id,
              'imageURL': data['imageURL'],
              'type': data['type'],
              'description': data['description'] ?? '', // Provide a default value for description
            };
          }).toList();

          return Container(
            height: MediaQuery.of(context).size.height, // Specify the height of the container
            child: CustomScrollView(
              slivers: [
                SliverPadding(
                  padding: const EdgeInsets.all(10),
                  sliver: SliverGrid(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1,
                      mainAxisSpacing: 30,
                      crossAxisSpacing: 10,
                      childAspectRatio: 1.5, // Adjust the aspect ratio as needed
                    ),
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final category = categories[index];
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CategoryTypePage(categoryType: category['type']),
                              ),
                            );
                          },
                          child: Card(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                            elevation: 4,
                            margin: const EdgeInsets.all(10),
                            child: Column(
                              children: [
                                Stack(
                                  children: [
                                    ClipRRect(
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(15),
                                        topRight: Radius.circular(15),
                                      ),
                                      child: Image.network(
                                        category['imageURL'],
                                        height: 195,
                                        width: double.infinity,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Positioned.fill(
                                      bottom: 0,
                                      child: ClipRRect(
                                        borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(15),
                                          topRight: Radius.circular(15),
                                        ),
                                        child: Container(
                                          color: Colors.black38,
                                          child: Center(
                                            child: Text(
                                              category['type'],
                                              softWrap: true,
                                              overflow: TextOverflow.fade,
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 30,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 15.0),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      category['description'],
                                      style: GoogleFonts.alexandria(fontSize: 15),
                                    ),
                                    SizedBox(height: 12.0),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      childCount: categories.length,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}