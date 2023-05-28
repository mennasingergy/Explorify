import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class GalleryAccess extends StatefulWidget {
  @override
  State<GalleryAccess> createState() => _GalleryAccessState();
}

class _GalleryAccessState extends State<GalleryAccess> {
  File? galleryFile;
  final picker = ImagePicker();
  @override
  Widget build(BuildContext context) {
    //display image selected from gallery

    return Builder(
      builder: (BuildContext context) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.green)),
                child: const Text('Select Image from Gallery and Camera'),
                onPressed: () {
                  _showPicker(context: context);
                },
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 90.0,
                width: 100.0,
                child: galleryFile == null
                    ? const Center(child: Text('Sorry nothing selected!!'))
                    : Center(child: Image.file(galleryFile!)),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showPicker({
    required BuildContext context,
  }) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Photo Library'),
                onTap: () {
                  getImage(ImageSource.gallery);
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_camera),
                title: const Text('Camera'),
                onTap: () {
                  getImage(ImageSource.camera);
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future getImage(
    ImageSource img,
  ) async {
    final pickedFile = await picker.pickImage(source: img);
    XFile? xfilePick = pickedFile;
    setState(
      () {
        if (xfilePick != null) {
          galleryFile = File(pickedFile!.path);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Please select a Photo')));
        }
      },
    );
  }
}
