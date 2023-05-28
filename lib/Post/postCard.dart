import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import './post.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// StreamBuilder<QuerySnapshot>(
//   stream: FirebaseFirestore.instance.collection('post').snapshots(),
//   builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//     if (snapshot.hasError) {
//       return Text('Something went wrong');
//     }

//     if (snapshot.connectionState == ConnectionState.waiting) {
//       return Text("Loading");
//     }

//     return ListView(
//       children: snapshot.data!.docs.map((DocumentSnapshot document) {
//         Map<String, dynamic> data = document.data() as M


class PostCard extends StatefulWidget {
  final DocumentSnapshot postSnapshot; // Firestore document snapshot
  PostCard({required this.postSnapshot});
  

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  bool _showCommentSection = false;
  TextEditingController _commentController = TextEditingController();
  var _isFavourite = false;

  static const IconData commentIcon =
      IconData(0xe17e, fontFamily: 'MaterialIcons');

// Future<void> getData() async {
//   final post = await FirebaseFirestore.instance
//             .collection('Posts')
//             .get();
// }

  @override
  Widget build(BuildContext context) {
    final post = Post.fromSnapshot(widget.postSnapshot);
    //Map<String,dynamic> post = widget.postSnapshot.data() as Map<String,dynamic>;
    // var post= getData();

    num averageRating = post.ratings != null
        ? post.ratings!.reduce((a, b) => a + b) / post.ratings!.length
        : 0;

    List<Widget> starIcons = List.generate(
      5,
      (index) => Icon(
        index < averageRating ? Icons.star : Icons.star_border,
        color: Colors.yellow,
      ),
    );

    Future<void> submitComment() async {
      if (_commentController.text.isNotEmpty) {
        setState(() {
          post.comments?.add(_commentController.text);
          _commentController.clear();
        });

        try {
          final commentData = {
            'comment': _commentController.text,
            'timestamp': FieldValue.serverTimestamp(),
          };

          await widget.postSnapshot.reference.collection('comments').add(commentData);
        } catch (e) {
          // Handle the error
          print('Error submitting comment: $e');
        }
      }
    }

    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.3,
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(post.imageURL),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _showCommentSection = !_showCommentSection;
                    });
                  },
                  child: Row(
                    children: [
                      Icon(commentIcon),
                      SizedBox(width: 5),
                      Text('Comment'),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      post.isFavorite = post.isFavorite;
                    });
                  },
                  icon: Icon(
                    _isFavourite
                        ? Icons.favorite
                        : Icons.favorite_border,
                        color: _isFavourite ? Colors.red : Colors.grey
                  ),
                ),
                Row(
                  children: starIcons,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              post.title,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              post.description!,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              'The location of this ${post.type} is in ${post.city}. It is recommended to ${post.recommendation}. ',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          if (_showCommentSection) ...[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _commentController,
                decoration: InputDecoration(
                  hintText: 'Add a comment...',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: ElevatedButton(
                onPressed: submitComment,
                child: Text('Submit'),
              ),
            ),
          ],
          if (post.comments!.isNotEmpty) ...[
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 8.0,
                vertical: 4.0,
              ),
              child: Text(
                'Comments:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: post.comments?.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8.0,
                    vertical: 2.0,
                  ),
                  child: Text(post.comments![index]),
                );
              },
            ),
          ],
        ],
      ),
    );
  }
}