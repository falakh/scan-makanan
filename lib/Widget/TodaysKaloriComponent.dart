import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:scanmakan/Page/food_detect.dart';
import 'package:scanmakan/Widget/kalori_chart.dart';

class TodaysKaloriComponent extends StatefulWidget {
  TodaysKaloriComponent({Key key}) : super(key: key);

  @override
  _TodaysKaloriComponentState createState() => _TodaysKaloriComponentState();
}

class _TodaysKaloriComponentState extends State<TodaysKaloriComponent> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: <Widget>[
          Center(
            heightFactor: 1,
            child: new Text(
              "Todays Kalori",
              textScaleFactor: 2.0,
              textAlign: TextAlign.center,
            ),
          ),
          Center(child: KaloriChart()),
          Positioned(
            bottom: 10,
            right: 10,
            child: AddFoodFloatActionButton(),
          ),
        ],
      ),
    );
  }
}

class AddFoodFloatActionButton extends StatefulWidget {
  @override
  _AddFoodFloatActionButtonState createState() =>
      _AddFoodFloatActionButtonState();
}

class _AddFoodFloatActionButtonState extends State<AddFoodFloatActionButton> {
  bool isShowingChild = false;

  @override
  void dispose() {
    isShowingChild= false;
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    var addButton = new FloatingActionButton(
      heroTag: "add",
        child: new Icon(Icons.add),
        onPressed: () => setState(() {
              isShowingChild = !isShowingChild;
            }));
    return !isShowingChild
        ? addButton
        : new Wrap(
            spacing: 10,
            direction: Axis.vertical,
            children: <Widget>[
              new FloatingActionButton(
                heroTag: "edit",
                  onPressed: null,
              child: new Icon(Icons.edit),
              ),
              new FloatingActionButton(
                heroTag: "camera",
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
                    return FoodDetector();
                  }));
                },
                child: new Icon(
                  Icons.camera,
                ),
              ),

              RotationTransition(
                turns: new AlwaysStoppedAnimation(45/360),
                  child: addButton),
            ],
          );
  }
}
