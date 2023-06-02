import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CategoryTypePage extends StatelessWidget {
  final String categoryType;

  CategoryTypePage({required this.categoryType});

  final CollectionReference postsCollection =
      FirebaseFirestore.instance.collection('Posts');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(210, 214, 132, 17),
        title: Text('Posts - $categoryType'),
      ),
      body: FutureBuilder<QuerySnapshot>(
        future: postsCollection.where('category', isEqualTo: categoryType).get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error fetching posts'));
          }

          final List<DocumentSnapshot> postDocs = snapshot.data!.docs;

          final List<Map<String, dynamic>> posts = postDocs.map((doc) {
            final data = doc.data() as Map<String, dynamic>;
            return {
              'id': data['id'],
              'title': data['title'],
              'imageURL': data['imageURL'],
              'ratings' : data['ratings']
            };
          }).toList();
         

          if (posts.isEmpty) {
            return Center(child: Text('No posts found for $categoryType'));
          }

          return ListView.builder(
            itemCount: posts.length,
            itemBuilder: (context, index) {
              return Card(
                elevation: 4,
                margin: EdgeInsets.all(10),
                child: ListTile(
                  title: Text(posts[index]['title']),
                  leading: Image.network(posts[index]['imageURL']),
                  onTap: () {
                     //
            }),
              );
            },
          );
        },
      ),
    );
  }
}