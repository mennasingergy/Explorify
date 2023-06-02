import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FavoritePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final User? user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Favorite Page'),
        ),
        body: Center(
          child: Text('You need to be logged in to view favorites.'),
        ),
      );
    }

    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Color.fromARGB(210, 214, 132, 17),
      // ),
      body: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        stream: FirebaseFirestore.instance
            .collection('Users')
            .doc(user.uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final List<dynamic>? favoritePosts =
                snapshot.data!.data()?['favorites'];

            if (favoritePosts == null || favoritePosts.isEmpty) {
              return Center(
                child: Text('No favorite posts.'),
              );
            }

            return FutureBuilder<List<DocumentSnapshot<Map<String, dynamic>>>>(
              future: _fetchFavoritePosts(favoritePosts),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final List<DocumentSnapshot<Map<String, dynamic>>> posts =
                      snapshot.data!;

                  if (posts.isEmpty) {
                    return Center(
                      child: Text('No favorite posts.'),
                    );
                  }

                  return ListView.builder(
                    itemCount: posts.length,
                    itemBuilder: (context, index) {
                      final post = posts[index].data();

                      return ListTile(
                        leading: Image.network(post?['imageURL']),
                        title: Text(post?['title']),
                        subtitle: Text(post?['description']),
                      );
                    },
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('Error fetching posts: ${snapshot.error}'),
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error fetching favorites: ${snapshot.error}'),
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

  Future<List<DocumentSnapshot<Map<String, dynamic>>>> _fetchFavoritePosts(
      List<dynamic> favoritePosts) async {
    final snapshot = await FirebaseFirestore.instance
        .collection('Posts')
        .where(FieldPath.documentId, whereIn: favoritePosts)
        .get();

    return snapshot.docs;
  }
}