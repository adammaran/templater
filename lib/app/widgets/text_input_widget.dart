import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TextInputWidget extends StatelessWidget {
  TextEditingController controller;
  String hint;
  Function(String) onChange;

  TextInputWidget(this.controller, this.hint, this.onChange);

  @override
  Widget build(BuildContext context) {
    return TextField(
        controller: controller,
        decoration: InputDecoration(hintText: hint),
        onChanged: onChange,
        keyboardType: TextInputType.multiline,
        maxLines: null);
  }
}
