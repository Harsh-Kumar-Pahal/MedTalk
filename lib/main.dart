import 'package:arkit_plugin/arkit_plugin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:med/uploadImage.dart';
import 'package:translator/translator.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ARScreen(),
    );
  }
}

class ARScreen extends StatefulWidget {
  @override
  _ARScreenState createState() => _ARScreenState();
}

class _ARScreenState extends State<ARScreen> {
  bool arKitSceneVisible = false;
  final translator = GoogleTranslator();
  final FlutterTts flutterTts = FlutterTts();

  Future<void> translateAndSpeak(String text) async {
    try {
      // Translate text to Hindi
      var translation = await translator.translate(text, from: 'en', to: 'hi');
      String translatedText = translation.text;

      // Speak the translated text
      await flutterTts.setLanguage("hi-IN");
      await flutterTts.speak(translatedText);
    } catch (e) {
      print("Translation error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 219, 218, 218),
      appBar: AppBar(
        title: const Text("MedTalk"),
        backgroundColor: Colors.deepPurple,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (arKitSceneVisible) buildARKitSceneView(),
          if (arKitSceneVisible) const Image(image: AssetImage("assets/voice.gif"),width:100, height: 100, color: Colors.deepPurple,),
          buildStartARButton(),

        ],
      ),
    );
  }

  Widget buildStartARButton() {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, bottom: 50, right: 20, top: 20),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            fixedSize: Size(500, 90),
            backgroundColor: Colors.deepPurple,
            side: const BorderSide(color:Color.fromARGB(255, 255, 255, 255), width: 3.0),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0))),
        onPressed: () {
          setState(() {
            arKitSceneVisible = true;
            translateAndSpeak("Scanning");
            // Navigate to ImagesPage
            Navigator.push(context, MaterialPageRoute(builder: (context) => ImageUploadScreen()));
          });
        },
        child: const Column(
          children: [
            Text(""),
            Icon(Icons.camera_alt_rounded, size: 50,),
          ],
        ),
      ),
    );
  }

  Widget buildARKitSceneView() {
    return Expanded(
      child: ARKitSceneView(
        detectionImagesGroupName: 'AR Resources',
        onARKitViewCreated: (c) {
          List<ARKitNode> addedNodes = [];

          c.onAddNodeForAnchor = (anchor) {
            if (anchor is ARKitImageAnchor) {
              final detectedImageName = anchor.referenceImageName;

              // Remove previous nodes
              for (ARKitNode node in addedNodes) {
                c.add(node);
              }
              addedNodes.clear();

              if (detectedImageName == "m") {
                print("this is for the body's defense system in check, making sure it doesn't harm the new organ or cause problems inside the body");
                translateAndSpeak("this is for the body's defense system in check, making sure it doesn't harm the new organ or cause problems inside the body. This is to be take in the morning");
                final node = ARKitNode(
                  geometry: ARKitText(
                    extrusionDepth: 1,
                    text: "Target",
                  ),
                );
                c.add(node);
                addedNodes.add(node);
              } 

              else if (detectedImageName == "m2") {
                print("this is for skin allergies");
                translateAndSpeak("this is for skin allergies.There is no fix for this, whenever you feel like");
                final node = ARKitNode(
                  geometry: ARKitText(
                    extrusionDepth: 1,
                    text: "Target",
                  ),
                );
                c.add(node);
                addedNodes.add(node);
              } 

              else if (detectedImageName == "m3") {
                print("this is for epileptic attack");
                translateAndSpeak("this is for epileptic attack, This is to be take in the morning and evening, both time");
                final node = ARKitNode(
                  geometry: ARKitText(
                    extrusionDepth: 1,
                    text: "Target",
                  ),
                );
                c.add(node);
                addedNodes.add(node);
              } 

              else if (detectedImageName == "m4") {
                print("this is for  pain-relieving and fever-reducing");
                translateAndSpeak("this is for pain-relieving and fever-reducing, This is to be take in the morning after breakfast");
                final node = ARKitNode(
                  geometry: ARKitText(
                    extrusionDepth: 1,
                    text: "Target",
                  ),
                );
                c.add(node);
                addedNodes.add(node);
              } 
              else if (detectedImageName == "m5") {
                print("this is for Reducing inflammation, primarily swelling");
                translateAndSpeak("primarily this is for Reducing inflammation, This is to be take on more swelling");
                final node = ARKitNode(
                  geometry: ARKitText(
                    extrusionDepth: 1,
                    text: "Target",
                  ),
                );
                c.add(node);
                addedNodes.add(node);
              } 

              // Add translations and speak commands for other images...

            } else {
              print("Nothing is being detected");
            }
          };
        },
      ),
    );
  }
}

