import 'dart:io';

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'addPageDetails.dart';
import 'addPageDetails.dart';

class AddPostPage extends StatefulWidget {
  @override
  _AddPostPageState createState() => _AddPostPageState();
}

class _AddPostPageState extends State<AddPostPage> {
  File? _image;
  final ImagePicker _imagePicker = ImagePicker();
  final FirebaseStorage _storage = FirebaseStorage.instance;
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
                onPressed: () => Navigator.of(context).pop(),
                child: Text('OK'),
              ),
            ],
          );
        },
      );
      return;
    }
    final Reference storageReference =
        _storage.ref().child('posts').child('image.jpg');
    final UploadTask uploadTask = storageReference.putFile(_image!);
    final TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() {});
    final String imageURL = await taskSnapshot.ref.getDownloadURL();

    setState(() {
      _image = null;
    });
    Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => AddPostDetailsPage(imageURL: imageURL)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Post'),
        actions: [
          IconButton(
            icon: Icon(Icons.add_photo_alternate),
            onPressed: _openGallery,
          ),
        ],
      ),
      body: Center(
        child: _image == null ? Text('No image selected') : Image.file(_image!),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.check),
        onPressed: _uploadImageAndSavePost,
      ),
    );
  }
}