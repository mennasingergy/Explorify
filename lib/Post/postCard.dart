import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:explorify/Explore/explore_screen.dart';

class PostCard extends StatefulWidget {
  final DocumentSnapshot postSnapshot; // Firestore document snapshot

  PostCard({required this.postSnapshot});

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  bool _showCommentSection = false;
  TextEditingController _commentController = TextEditingController();
  var _isFavorite = false;
  int _rating = 0;

  static const IconData commentIcon =
      IconData(0xe17e, fontFamily: 'MaterialIcons');

final user = FirebaseAuth.instance.currentUser!;

 

  @override
  Widget build(BuildContext context) {
    final post = widget.postSnapshot.data() as Map<String, dynamic>;
    final currentUser = FirebaseAuth.instance.currentUser;

    // Check if the user is logged in
    final bool isLoggedIn = currentUser != null;

    List<Widget> starIcons = List.generate(
      5,
      (index) => GestureDetector(
        onTap: () {
          setState(() {
            _rating = index + 1;
          });
        },
        child: Icon(
          index < (_rating != 0
                  ? _rating
                  : post['ratings'] != null
                      ? (post['ratings'] as List<dynamic>)
                              .cast<int>()
                              .reduce((a, b) => a + b) ~/
                          (post['ratings'] as List<dynamic>).length
                      : 0)
              ? Icons.star
              : Icons.star_border,
          color: Colors.yellow,
        ),
      ),
    );

    Future<void> submitComment() async {
      if (_commentController.text.isNotEmpty) {
        try {
          if (!user.isAnonymous){
          final commentData = _commentController.text;

          await widget.postSnapshot.reference.update({
            'comments': FieldValue.arrayUnion([commentData]),
          });

          setState(() {
            post['comments'].add(commentData);
            _commentController.clear();
          });}
        } catch (e) {
          // Handle the error
          print('Error submitting comment: $e');
        }
      }
    }

    Future<void> submitRating() async {
      try {if (!user.isAnonymous){
        print('aaaaaaaaaaaaaaaaaaaaaaaaaaaahh');
        await widget.postSnapshot.reference.update({
          'ratings': FieldValue.arrayUnion([_rating]),
        });print("ÿouhhhhhhhhhhhhhhhhhh");}
      } catch (e) {
        // Handle the error
        print('Error submitting rating: $e');
      }
    }

    Future<void> toggleFavorite() async {
      setState(() {
        _isFavorite = !_isFavorite;
      });

      if (isLoggedIn) {
        final userId = currentUser!.uid;
        final postId = widget.postSnapshot.id;

        final userRef =
            FirebaseFirestore.instance.collection('Users').doc(userId);

        if (_isFavorite) {
          await userRef.update({
            'favorites': FieldValue.arrayUnion([postId]),
          });
        } else {
          await userRef.update({
            'favorites': FieldValue.arrayRemove([postId]),
          });
        }
      }
    }

  double getAVGrate(){
      double averageRating = 0.0;
      if (post['ratings'] != null) {
        final ratings = post['ratings'] as List<dynamic>;
        if (ratings.isNotEmpty) {
          final sum = ratings.cast<int>().reduce((a, b) => a + b);
          averageRating = sum / ratings.length;
        }
      }
      return averageRating;
      }
    double rating = getAVGrate();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('Post Details'),
      ),
      body: SingleChildScrollView(
        child: Card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.3,
                width: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(post['imageURL']),
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
                        if (!user.isAnonymous){
                        setState(() {
                          _showCommentSection = !_showCommentSection;
                        });}
                        else { setState(() {showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                 title: Text("Please sign in first!"), actions: [
                    FloatingActionButton(
                        backgroundColor: Color.fromARGB(207, 188, 106, 29),
                        child: Text("OK"),
                        onPressed: () {
                          Navigator.pop(context);
                        })
     ]);
            });});
                      };},
                      child: Row(
                        children: [
                          Icon(commentIcon),
                          SizedBox(width: 5),
                          Text('Comment'),
                        ],
                      ),
                    ),
                    if (isLoggedIn)
                      IconButton(
                        onPressed: toggleFavorite,
                        icon: Icon(
                          _isFavorite ? Icons.favorite : Icons.favorite_border,
                          color: _isFavorite ? Colors.red : Colors.grey,
                        ),
                      ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  post['title'],
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  post['description'],
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[600],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  'The location of this ${post['type']} is in ${post['city']}. It is recommended to ${post['recommendation']}. ',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              if (rating > 0.0) ...[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Average Rating: ${rating.toStringAsFixed(1)}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
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
                    child: Text('Submit Comment'),
                  ),
                ),
              ],
              Row(
                children: starIcons,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: ElevatedButton(
                  onPressed: () {
                        if (!user.isAnonymous){
                        setState(() {
                          submitRating();
                          getAVGrate();
                        });
                        }
                        else { setState(() {showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                 title: Text("Please sign in first!"), actions: [
                    FloatingActionButton(
                        backgroundColor: Color.fromARGB(207, 188, 106, 29),
                        child: Text("OK"),
                        onPressed: () {
                          Navigator.pop(context);
                        })
     ]);
            });});
                      };},
                  child: Text('Submit Rating'),
                ),
              ),
              if (post['comments'] != null && post['comments'].isNotEmpty) ...[
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
                  itemCount: (post['comments'] as List<dynamic>).length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8.0,
                        vertical: 2.0,
                      ),
                      child: Text(post['comments'][index]),
                    );
                  },
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}