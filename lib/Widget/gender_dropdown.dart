import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:scanmakan/model/user_model.dart';

class GenderForm extends StatefulWidget {
  @override
  _GenderFormState createState() =>
      _GenderFormState();
}

class _GenderFormState extends State<GenderForm> {
  static Gender currentValue = Gender.Wanita;

  _GenderFormState();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        RadioListTile(
            selected: currentValue == Gender.Pria,
            value: Gender.Pria,
            groupValue: currentValue,
            title: new Text("Pria"),
            onChanged: (radioValue) {
              currentValue = radioValue;
              print(currentValue);
            }),
        RadioListTile(
            selected: currentValue == Gender.Wanita,
            value: Gender.Wanita,
            groupValue: currentValue,
            title: new Text("Wanita"),
            onChanged: (radioValue) {
              currentValue = radioValue;
              print(currentValue);
            }),
      ],
    );
  }
}


