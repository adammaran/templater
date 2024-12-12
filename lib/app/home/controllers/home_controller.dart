import 'dart:async';
import 'dart:typed_data';
import 'dart:ui';

import 'dart:ui' as ui;
import 'package:flutter/services.dart';
import 'package:universal_html/html.dart' as html;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  RxBool loadingImage = RxBool(true);

  TextEditingController firstController = TextEditingController();
  TextEditingController secondController = TextEditingController();
  TextEditingController thirdController = TextEditingController();

  RxString firstText = RxString('');
  RxString secondText = RxString('');
  RxString thirdText = RxString('');

  ui.Image? bgImage;

  GlobalKey repaintBoundaryKey = GlobalKey();

  @override
  void onInit() async {
    loadImage('background.png').then((value) {
      loadingImage.value = false;
      bgImage = value;
    });
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  Future<void> exportToImage() async {
    try {
      RenderRepaintBoundary boundary = repaintBoundaryKey.currentContext!
          .findRenderObject() as RenderRepaintBoundary;

      // Convert the canvas to an image
      final image = await boundary.toImage(pixelRatio: 3.0);
      final byteData = await image.toByteData(format: ImageByteFormat.png);
      final Uint8List pngBytes = byteData!.buffer.asUint8List();

      // Trigger download in the browser
      final blob = html.Blob([pngBytes]);
      final url = html.Url.createObjectUrlFromBlob(blob);
      final anchor = html.AnchorElement(href: url)
        ..target = 'blank'
        ..download = 'canvas_image.png'
        ..click();
      html.Url.revokeObjectUrl(url);

      ScaffoldMessenger.of(Get.context!).showSnackBar(
        SnackBar(content: Text("Image generated and ready for download")),
      );
    } catch (e) {
      print("Error exporting image: $e");
      ScaffoldMessenger.of(Get.context!).showSnackBar(
        SnackBar(content: Text("Failed to generate image")),
      );
    }
  }

  Future<ui.Image> loadImage(String imageAssetPath) async {
    final ByteData data = await rootBundle.load(imageAssetPath);
    final Completer<ui.Image> completer = Completer();
    ui.decodeImageFromList(Uint8List.view(data.buffer), (ui.Image img) {
      return completer.complete(img);
    });
    return completer.future;
  }

  @override
  void onClose() {
    super.onClose();
  }
}
