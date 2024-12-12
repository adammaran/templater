import 'dart:ui' as ui show Image;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:templater/app/home/controllers/home_controller.dart';
import 'package:templater/app/tools/hrom_hex.dart';

class TemplateCanvasWidget extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    double canvasWidth = 500;
    double canvasHeight = canvasWidth * 1.29;

    return Obx(
      () => controller.loadingImage.value
          ? const CircularProgressIndicator()
          : Container(
              height: canvasHeight,
              width: canvasWidth,
              child: RepaintBoundary(
                key: controller.repaintBoundaryKey,
                child: CustomPaint(
                  size: Size(controller.bgImage!.width.toDouble(),
                      controller.bgImage!.height.toDouble()),
                  painter: TemplatePainter(
                      controller.firstText.value,
                      controller.secondText.value,
                      controller.thirdText.value,
                      controller.bgImage),
                  child: Container(),
                ),
              ),
            ),
    );
  }
}

class TemplatePainter extends CustomPainter {
  String firstText;
  String secondText;
  String thirdText;

  ui.Image? image;

  TemplatePainter(this.firstText, this.secondText, this.thirdText, this.image);

  @override
  void paint(Canvas canvas, Size size) {
    ///BACKGROUND PAINT
    final srcRect =
        Rect.fromLTWH(0, 0, image!.width.toDouble(), image!.height.toDouble());
    final dstRect = Rect.fromLTWH(0, 0, size.width, size.height);

    if (image != null) {
      canvas.drawImageRect(image!, srcRect, dstRect, Paint());
    }

    double firstElementHeight = size.height *
        (0.15 - getTextPositionByNewLines(newLinesCount(firstText)));
    double secondElementHeight = size.height *
        (0.48 - getTextPositionByNewLines(newLinesCount(secondText)));
    double thirdElementHeight = size.height *
        (0.8 - getTextPositionByNewLines(newLinesCount(thirdText)));

    ///TEXT PAINT
    drawText(canvas, size, firstText, firstElementHeight);
    drawText(canvas, size, secondText, secondElementHeight);
    drawText(canvas, size, thirdText, thirdElementHeight);
  }

  RRect drawRRect(Size size, double heightPosition) {
    final rect =
        Rect.fromLTWH(20, heightPosition, size.width - 40, size.height * 0.24);
    return RRect.fromRectAndRadius(rect, Radius.circular(18));
  }

  int newLinesCount(String text) {
    int count = 0;

    for (int i = 0; i < text.length; i++) {
      if (text[i] == '\n') {
        count++;
      }
    }

    return count;
  }

  double getTextPositionByNewLines(int newLines) {
    switch (newLines) {
      case 0:
        return 0;
      case 1:
        return 0.03;
      case 2:
        return 0.05;
      default:
        return 0;
    }
  }

  void drawText(Canvas canvas, Size size, String text, double position) {
    const textStyle = TextStyle(
      color: Colors.black,
      decoration: TextDecoration.underline,
      fontWeight: FontWeight.w600,
      fontFamily: 'Verdana',
      fontSize: 26,
    );

    final textSpan = TextSpan(
      text: text,
      style: textStyle,
    );

    final TextPainter textPainter = TextPainter(
        text: textSpan,
        textAlign: TextAlign.left,
        textDirection: TextDirection.ltr);

    textPainter.layout(minWidth: 0, maxWidth: size.width);

    final offset = Offset(
      80,
      position,
    );

    textPainter.paint(canvas, offset);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
