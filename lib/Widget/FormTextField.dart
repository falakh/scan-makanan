import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextFormFieldWithBorder extends StatelessWidget {
  String labelText;
  String suffixText;
  TextEditingController controller;

  TextFormFieldWithBorder(this.labelText, {this.controller, this.suffixText});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5),
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: labelText,
            suffixText: suffixText),
      ),
    );
  }
}

class NumberFormFieldWithBorder extends StatelessWidget {
  final String labelText;
  final TextEditingController controller;

  NumberFormFieldWithBorder(this.labelText, {this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5),
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: labelText,
        ),
      ),
    );
  }
}
