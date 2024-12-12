import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:templater/app/home/widgets/template_canvas_widget.dart';
import 'package:templater/app/home/widgets/template_input_widget.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Templater'),
        centerTitle: true,
      ),
      body: Container(
          width: Get.width,
          height: Get.height,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                  width: Get.width * 0.4,
                  child: TemplateInputWidget()),
              TemplateCanvasWidget()
            ],
          )),
    );
  }
}
