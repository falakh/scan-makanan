import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:tflite/tflite.dart';
import 'dart:math' as math;


var now = new List();
var sub = new List();

int temp;
var map2 = Map();
var map1 = Map();
typedef void Callback(List<dynamic> list, int h, int w);

class CameraRecognizerWidget extends StatefulWidget {
  final List<CameraDescription> cameras;

  final Callback setRecognitions;
  final String model;

  CameraRecognizerWidget(this.cameras, this.model, this.setRecognitions);

  @override
  _CameraRecognizerWidgetState createState() => new _CameraRecognizerWidgetState();
}

class _CameraRecognizerWidgetState extends State<CameraRecognizerWidget> {
  CameraController controller;
  bool isDetecting = false;

  @override
  void initState() {
    super.initState();
    ///now = [0,0,0];
    if (widget.cameras == null || widget.cameras.length < 1) {
      print('No camera is found');
    } else {
      controller = new CameraController(
        widget.cameras[0],
        ResolutionPreset.low,
      );
      controller.initialize().then((_) {
        if (!mounted) {
          return;
        }
        setState(() {});

        controller.startImageStream((CameraImage img) {
          if (!isDetecting) {
            isDetecting = true;

            int startTime = new DateTime.now().millisecondsSinceEpoch;

            Tflite.runModelOnFrame(
                bytesList: img.planes.map((plane) {
                  return plane.bytes;
                }).toList(),

                imageHeight: img.height,
                imageWidth: img.width,
                imageMean: 127.5,
                imageStd:127.5,
                numResults: 3,
                rotation: 0,
                threshold:0.1
            ).then((recognitions) {
              print("data "+recognitions.toString());
              recognitions.map((res) {
                isDetecting=false;
              });



              print(recognitions);




              int endTime = new DateTime.now().millisecondsSinceEpoch;
              print("Detection took ${endTime - startTime}");

              widget.setRecognitions(recognitions, img.height, img.width);

              isDetecting = false;
            });
          }
        });
      });
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (controller == null || !controller.value.isInitialized) {
      return Container();
    }

    var tmp = MediaQuery.of(context).size;

    var screenW = math.min(tmp.height, tmp.width);
    tmp = controller.value.previewSize;



    return Container(
      child: CameraPreview(controller),
      constraints: BoxConstraints(
        maxHeight: 500,
        maxWidth: screenW,
      )  ,
    );


  }
}