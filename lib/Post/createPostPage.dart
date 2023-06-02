import 'dart:io';

import 'package:explorify/Explore/explore_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../notification_api.dart';

class CreatePost extends StatefulWidget {
  @override
  _CreatePostState createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {
  File? _image;
  final ImagePicker _imagePicker = ImagePicker();
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _recommendationController =
      TextEditingController();
  bool isFavorite = false;
  var uuid = Uuid();

  void _openGallery() async {
    final pickedImage =
        await _imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
      });
    }
  }

  Future<void> _uploadImageAndSavePost() async {
    if (_image == null) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('No Image Selected'),
            content: Text('Please select an image from the gallery.'),
            actions: [
              TextButton(
                onPressed: () => {Navigator.of(context).pop()},
                child: Text('OK'),
              ),
            ],
          );
        },
      );
      return ;
    }
    
    

    final Reference storageReference =
        _storage.ref().child('Posts').child('image.jpg');
    final UploadTask uploadTask = storageReference.putFile(_image!);
    final TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() {});
    final String imageURL = await taskSnapshot.ref.getDownloadURL();

    final String category = _categoryController.text;
    final String description = _descriptionController.text;
    final String city = _cityController.text;
    final String title = _titleController.text;
    final String recommendation = _recommendationController.text;

    final Map<String, dynamic> post = {
      'id': uuid.v4(), // Generate UUID using the v4 method
      'title': title,
      'description': description,
      'ratings': [],
      'recommendation': recommendation,
      'isFavorite': isFavorite,
      'city': city,
      'category': category,
      'imageURL': imageURL,
      'comments': [],
    };

    try {
      await FirebaseFirestore.instance.collection('Posts').add(post);

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Success'),
            content: Text('Post saved successfully!'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).popUntil(ModalRoute.withName('/'));
                  NotificationsApi().showNotification(
                      id: 0,
                      title: 'New Post',
                      body: 'A new post has been added.');
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    } catch (error) {
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

  final user = FirebaseAuth.instance.currentUser!;
  //final userId = FirebaseFirestore.instance.collection('Users').doc(id).get();
  //   if (userId == user) {
  //     return true;
  //   }
  //   return false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Color.fromARGB(210, 214,132,17),
      //   title: Text('Create Post'),
      // ),
      body: (!user.isAnonymous)
          ? SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    _image == null
                        ? Text('No image selected')
                        : Image.file(_image!),
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
                    SizedBox(height: 16.0),
                    TextFormField(
                      controller: _recommendationController,
                      decoration: InputDecoration(
                        labelText: 'Recommendation',
                      ),
                    ),
                    SizedBox(height: 32.0),
                    FloatingActionButton(
                      child: Icon(Icons.add_photo_alternate),
                      onPressed: _openGallery,
                    ),
                    SizedBox(height: 32.0),
                    ElevatedButton(
                      onPressed: _uploadImageAndSavePost,
                      child: Text('Save Post'),
                    ),
                  ],
                ),
              ),
            )
          : Center(child: Text("please sign in first!")),
    );
  }
}

