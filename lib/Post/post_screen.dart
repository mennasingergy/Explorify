import 'package:explorify/Post/postCard.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class PostScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final postId = routeArgs['postId'];

    return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance.collection('Posts').doc(postId).snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final postSnapshot = snapshot.data;

          if (postSnapshot != null && postSnapshot.exists) {
            return PostCard(postSnapshot: postSnapshot);
          } else {
            return Center(
              child: Text('Post not found'),
            );
          }
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Error fetching post'),
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}