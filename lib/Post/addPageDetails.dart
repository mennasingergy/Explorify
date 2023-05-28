import 'package:explorify/Post/post.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddPostDetailsPage extends StatefulWidget {
  final String imageURL;

  const AddPostDetailsPage({required this.imageURL});

  @override
  _AddPostDetailsPageState createState() => _AddPostDetailsPageState();
}

class _AddPostDetailsPageState extends State<AddPostDetailsPage> {
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Post Details'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              Image.network(widget.imageURL),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _categoryController,
                decoration: InputDecoration(
                  labelText: 'Category',
                ),
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(
                  labelText: 'Description',
                ),
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _cityController,
                decoration: InputDecoration(
                  labelText: 'City',
                ),
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(
                  labelText: 'Title',
                ),
              ),
              SizedBox(height: 32.0),
              ElevatedButton(
                onPressed: _savePost,
                child: Text('Save Post'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _savePost() {
    // Get the values from the text controllers
    final String category = _categoryController.text;
    final String description = _descriptionController.text;
    final String city = _cityController.text;
    final String title = _titleController.text;
    final String imageURL = widget.imageURL;

    // Create the post object using the values
    final Post post = Post(
        //id: '', // Generate a unique ID for the post
        title: title,
        description: description,
        ratings: [],
        recommendation: '',
        isFavorite: false,
        city: city,
        type: '',
        category: category,
        imageURL: imageURL,
        comments: []);

    // Save the post to Firebase
    savePostToFirebase(post);
  }

  // Method to save the post to Firebase
  void savePostToFirebase(Post post) async {
    try {
      // Create a new document reference for the post in the "posts" collection
      final DocumentReference postRef =
          FirebaseFirestore.instance.collection('posts').doc();

      // Set the data of the post document
      await postRef.set({
        'id': postRef.id,
        'title': post.title,
        'description': post.description,
        'ratings': post.ratings,
        'recommendation': post.recommendation,
        'isFavorite': post.isFavorite,
        'city': post.city,
        'type': post.type,
        'category': post.category,
        'imageURL': post.imageURL,
      });
      // Display a success message to the user
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Success'),
            content: Text('Post saved successfully!'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    } catch (error) {
      // Handle the error and display an error message to the user
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Failed to save the post. Please try again.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }
}