import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/sample_controller.dart';

class SampleView extends GetView<SampleController> {
  const SampleView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SampleView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'SampleView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
