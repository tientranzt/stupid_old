import 'dart:math';
import 'package:flutter/material.dart';

class CircleProgress extends CustomPainter {

  double currentProgress;
  CircleProgress({this.currentProgress});

  @override
  void paint(Canvas canvas, Size size) {
    Paint outerCircle = Paint()
      ..strokeWidth = 18
      ..color = Colors.grey
      ..style = PaintingStyle.stroke;

    Paint completeArc = Paint()
      ..strokeWidth = 16
      ..color = Color(0xFF237658)
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    Offset center = Offset(size.width/2, size.height /2);

    double radius = min(size.width / 2, size.height / 2 ) - 65;

    canvas.drawCircle(center, radius, outerCircle);

    double angle = 2  * pi * (currentProgress / 100);

    canvas.drawArc(Rect.fromCircle(center: center, radius: radius), -pi/2, angle, false, completeArc);

//    canvas.drawArc(rect, startAngle, sweepAngle, useCenter, paint)
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
