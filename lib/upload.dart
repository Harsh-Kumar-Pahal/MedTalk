import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class ImageUploadScreen extends StatefulWidget {
  @override
  _ImageUploadScreenState createState() => _ImageUploadScreenState();
}

class _ImageUploadScreenState extends State<ImageUploadScreen> {
  late File _image;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future<void> _saveImageToLocalStorage() async {
    // Check if an image is selected
    if (_image == null) {
      print('No image selected.');
      return;
    }

    try {
      // Get the local app directory
      final appDir = await getApplicationDocumentsDirectory();

      // Create a new directory (you can customize the directory name)
      final imagesDir = Directory('${appDir.path}/images/');
      imagesDir.createSync(recursive: true);

      // Save the image with a unique filename
      final savedImagePath = '${imagesDir.path}${DateTime.now().millisecondsSinceEpoch}.png';
      await _image.copy(savedImagePath);

      print('Image saved to: $savedImagePath');
    } catch (e) {
      print('Error saving image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Upload'),
      ),
      body: Center(
        child: _image == null
            ? Text('No image selected.')
            : Image.file(_image),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _pickImage();
        },
        tooltip: 'Pick Image',
        child: Icon(Icons.image),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  _saveImageToLocalStorage();
                },
                child: Text('Save Image'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}