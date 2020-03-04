import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:automl_mlkit/automl_mlkit.dart';
import 'package:scanmakan/Widget/ml_kit_widget_example.dart';

class FoodDetector extends StatelessWidget {
  const FoodDetector() : super();

  Future<File> getImage(BuildContext buildContext) async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    if (image == null) {
      Navigator.pop(buildContext);
    }
    return Future.value(image);
  }

  

  Future<void> loadModel() async {
    String dataset = "model";
    // String dataset = "pens";
    // await createLocalFiles(dataset);
    String modelLoadStatus;
    try {
      await AutomlMlkit.loadModelFromCache(dataset: dataset);
      
      modelLoadStatus = "AutoML model successfully loaded";
    } on PlatformException catch (e) {
      modelLoadStatus = "Error loading model";
      print("error from platform on calling loadModelFromCache");
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ml_example()
      
    );
  }

  Center pictureDummy() {
    return Center(
      child: SizedBox.fromSize(
        size: Size(300, 300),
        child: Container(
          color: Colors.red,
        ),
      ),
    );
  }

  FutureBuilder<File> photoWidget(BuildContext buildContext) {
    return FutureBuilder<File>(
      future: getImage(buildContext),
      builder: (context, fileSnapshoot) {
        if (fileSnapshoot.hasData) {
          return SizedBox.fromSize(
            size: Size(400, 400),
            child: Image.file(
              fileSnapshoot.data,
              fit: BoxFit.fill,
            ),
          );
        } else {
          return Container(
            child: CircularProgressIndicator(
              semanticsLabel: "Loading",
              backgroundColor: Theme.of(context).primaryColor,
            ),
          );
        }
      },
    );
  }

  Widget resultCard(String nama, String kalori) {
    return Card(
      margin: EdgeInsets.all(10),
      child: (ListTile(
        leading: Icon(Icons.fastfood),
        title: Text(
          "Nama : $nama",
          style: TextStyle(),
        ),
        subtitle: new Text("Kalori :$kalori"),
      )),
    );
  }
}
