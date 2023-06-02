import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'exploreCard.dart';

class ExploreScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('Posts').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final posts = snapshot.data!.docs.map((doc) {
              final data = doc.data() as Map<String, dynamic>;
              return {
                'id': doc.id,
                'imageURL': data['imageURL'],
                'title': data['title'],
              };
            }).toList();

            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 4,
                crossAxisSpacing: 4,
              ),
              itemCount: posts.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      '/postRoute',
                      arguments: {'postId': posts[index]['id']},
                    );
                  },
                  child: ExploreCard(postData: posts[index]),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error fetching posts'),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}