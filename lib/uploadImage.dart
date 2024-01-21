import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:med/images.dart';
// import 'package:med/main.dart';
import 'package:path_provider/path_provider.dart';


class ImageUploadScreen extends StatefulWidget {
  @override
  _ImageUploadScreenState createState() => _ImageUploadScreenState();
}

class _ImageUploadScreenState extends State<ImageUploadScreen> {
  File? _image;

  Future<void> pickAndSaveImage() async {
    await _pickImage();
    await _saveImageToLocalStorage();
  }

  Future<void> _pickImage() async {
  try {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = pickedFile != null ? File(pickedFile.path) : null;
    });
  } catch (e) {
    print('Error picking image: $e');
  }
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
      await _image?.copy(savedImagePath);

      print('Image saved to: $savedImagePath');
    } catch (e) {
      print('Error saving image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: const Color.fromARGB(255, 219, 218, 218),
        appBar: AppBar(
          title: const Text('Add Medication'),
          backgroundColor: Colors.deepPurple,
        ),
        body: Center(
          child: _image == null
              ? const Text('No Medication selected.')
              : Image.file(_image!),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.deepPurple,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            
          onPressed: () {
            _pickImage();
          },
          tooltip: 'Pick Image',
          child: const Icon(Icons.image),
        ),
        bottomNavigationBar: BottomAppBar(
          child: Container(
            padding:const EdgeInsets.symmetric(vertical: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                  fixedSize: const Size(90, 90),
                  backgroundColor: Colors.deepPurple,
                  side: const BorderSide(color: Color.fromARGB(255, 255, 255, 255), width: 3.0),
                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0))),
                  onPressed: () {
                    _saveImageToLocalStorage();
                  },
                  child: const Text('+', style: TextStyle(fontSize: 50),),
                ),
                const Text("                                      "),
                ElevatedButton(
        style: ElevatedButton.styleFrom(
            fixedSize: const Size(90, 90),
            backgroundColor: Colors.deepPurple,
            side: const BorderSide(color: Color.fromARGB(255, 255, 255, 255), width: 3.0),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0))),
        onPressed: () {
          setState(() {
            Navigator.push(context, MaterialPageRoute(builder: (context) => images()));
          });
        },
        child: const Column(
          children: [
            Text(""),
            Icon(Icons.medication_sharp, size: 50,),
          ],
        ),
      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: ImageUploadScreen(),
  ));
}