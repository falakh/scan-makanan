import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class FoodDetector extends StatelessWidget {
  const FoodDetector() : super();

  Future<File> getImage(BuildContext buildContext) async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    if (image == null) {
      Navigator.pop(buildContext);
    }
    return Future.value(image);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            photoWidget(context),
            // pictureDummy(),
            resultCard("Sate", "1500")
          ],
        ),
      ),
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
