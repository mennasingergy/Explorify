import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'post.dart';
import 'postCard.dart';

class PostScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    //final post = routeArgs['post'] as Post;
    var postInstance = FirebaseFirestore.instance.collection("Posts");
    var stream = postInstance.snapshots();

    return StreamBuilder<QuerySnapshot>(
      stream: stream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Scaffold(
            appBar: AppBar(
              title: Text("Post"),
            ),
            body: ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                var document = snapshot.data!.docs[index];
                return PostCard(postSnapshot: document);
              },
            ),
          );
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}