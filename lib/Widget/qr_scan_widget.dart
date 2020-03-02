import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter/material.dart';
import 'package:scanmakan/Widget/live_barcode_scanner.dart';
import 'package:url_launcher/url_launcher.dart' as launcer;

class QRUrlScanerWidget extends StatefulWidget {
  @override
  _QRUrlScanerWidgetState createState() => _QRUrlScanerWidgetState();
}

class _QRUrlScanerWidgetState extends State<QRUrlScanerWidget> {
//    FirebaseVisionBarcodeDetector barcodeDetector = FirebaseVisionBarcodeDetector.instance;
  BarcodeDetector barcode = FirebaseVision.instance.barcodeDetector();

//    final FirebaseVisionImage visionImage = FirebaseVisionImage.;
  String data ="";
  _launchURL(String link) async {
    var url = link;
    if (await launcer.canLaunch(url)) {
      await launcer.launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          child: LiveBarcodeScanner(
            onBarcode: (data) {
              print("data"+data);
              setState(() {
                this.data = data;
                _launchURL(data);
              });
              return true;
            },

          )
        ),new Text(this.data)
      ],
    );
  }
}
