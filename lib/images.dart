import 'package:flutter/material.dart';

class images extends StatelessWidget{
  Widget build(BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: const Color.fromARGB(255, 219, 218, 218),
        appBar: AppBar(
          title: const Text("Medication"),
          backgroundColor: Colors.deepPurple,
        ),
        body: const SingleChildScrollView(
          child: Wrap(
            spacing: 20,
            runSpacing: 30,
           children: [
             Padding(
               padding: EdgeInsets.all(40.0),
               child: Wrap(
                runSpacing: 20,
                 children: [
                   Image(image: AssetImage("assets/m.png"),width: 70, height: 70),
                   Padding(
                     padding: EdgeInsets.only(left:20, top: 0),
                     child: Text("this is for the body organ transplant", style: TextStyle(fontSize: 20),),
                   ),
        
                   Image(image: AssetImage("assets/m2.png"),width: 70, height: 70),
                   Padding(
                     padding: EdgeInsets.only(left:20, top:0),
                     child: Text("this is for skin allergies", style: TextStyle(fontSize: 20),),
                   ),
        
                   Image(image: AssetImage("assets/m3.png"),width: 70, height: 70),
                   Padding(
                     padding: EdgeInsets.only(left:20, top:0),
                     child: Text("this is for epileptic attack", style: TextStyle(fontSize: 20),),
                   ),
        
                   Image(image: AssetImage("assets/m4.png"),width: 70, height: 70),
                   Padding(
                     padding: EdgeInsets.only(left:20, top:0),
                     child: Text("this is for  pain-relieving and fever-reducing", style: TextStyle(fontSize: 20),),
                   ),
        
                   Image(image: AssetImage("assets/m5.png"),width: 70, height: 70),
                   Padding(
                     padding: EdgeInsets.only(left:20, top:0),
                     child: Text("this is for Reducing inflammation, primarily swelling", style: TextStyle(fontSize: 20),),
                   )
                 ],
               ),
             )
        
          ],),
        ),
      ),
    );
  }

} 