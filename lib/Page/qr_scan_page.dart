
import 'package:flutter/material.dart';
import 'package:scanmakan/Widget/qr_scan_widget.dart';



class QRScannerPage extends StatelessWidget {

  Future<String> getImage() async {

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: QRUrlScanerWidget()
      ),
    );
  }
}
