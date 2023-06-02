import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:explorify/Explore/exploreCard.dart';
import 'package:flutter/material.dart';

class Post {
  final String id;
  final String title;
  final String imageURL;

  Post({required this.id, required this.title, required this.imageURL});

  factory Post.fromDocumentSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    return Post(
        id: snapshot.id, title: data['title'], imageURL: data['imageURL']);
  }
}

class PostSearchPage extends StatefulWidget {
  @override
  _PostSearchPageState createState() => _PostSearchPageState();
}

class _PostSearchPageState extends State<PostSearchPage> {
  final TextEditingController _searchController = TextEditingController();
  List<Post> _searchResults = [];

  Future<void> _searchPosts(String searchQuery) async {
    final querySnapshot = await FirebaseFirestore.instance
        .collection('Posts')
        .where('title', isGreaterThanOrEqualTo: searchQuery)
        .where('title', isLessThanOrEqualTo: searchQuery + '\uf8ff')
        .get();

    setState(() {
      _searchResults = querySnapshot.docs
          .map((doc) => Post.fromDocumentSnapshot(doc))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    var postsInstance = FirebaseFirestore.instance.collection("chats");
    var stream = postsInstance.snapshots();

    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              onChanged: (value) {
                _searchPosts(value.trim());
              },
              decoration: InputDecoration(
                labelText: 'Search by title',
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _searchResults.length,
              itemBuilder: (context, index) {
                final post = _searchResults[index];
                return GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed("/postRoute",
                          arguments: {'postId': post.id});
                    },
                    child: Card(
                        child: Column(
                      children: [
                        Text(post.title),
                        ClipRRect(
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(15),
                                topRight: Radius.circular(15)),
                            child: Image.network(post.imageURL,
                                height: 250,
                                width: double.infinity,
                                fit: BoxFit.cover))
                      ],
                    )));
              },
            ),
          ),
        ],
      ),
    );
  }
}
