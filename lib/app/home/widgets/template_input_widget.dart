import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:templater/app/home/controllers/home_controller.dart';
import 'package:templater/app/widgets/text_input_widget.dart';

class TemplateInputWidget extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Column(children: [
          TextInputWidget(controller.firstController, 'First text', (value) {
            controller.firstText.value = value;
          }),
          TextInputWidget(controller.secondController, 'Second text', (value) {
            controller.secondText.value = value;
          }),
          TextInputWidget(controller.thirdController, 'Third text', (value) {
            controller.thirdText.value = value;
          }),
        ]),
        ElevatedButton(
            onPressed: () {
              controller.exportToImage();
            },
            child: Text('Export image'))
      ],
    );
  }
}
