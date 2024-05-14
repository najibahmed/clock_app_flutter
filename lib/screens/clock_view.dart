import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

import '../constants/color_constants.dart';

class ClockView extends StatefulWidget {
  const ClockView({super.key});

  @override
  State<ClockView> createState() => _ClockViewState();
}

class _ClockViewState extends State<ClockView> {

  @override
  void initState() {
    Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
      });
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      width: 300,
      child: Transform.rotate(
        angle: -pi / 2,
        child: CustomPaint(
          painter: ClockPainter(),
        ),
      ),
    );
  }
}

class ClockPainter extends CustomPainter {
  var dateTime=DateTime.now();

  @override
  void paint(Canvas canvas, Size size) {
    var centerx = size.width / 2;
    var centery = size.height / 2;
    var center = Offset(centerx, centery);
    var radius = min(centerx, centery);

    var fillBrush = Paint()..color = color2;

    var outLineBrush = Paint()
      ..color = color3
      ..strokeWidth = 16
      ..style = PaintingStyle.stroke;

    var centerFillBrush = Paint()..color = color3;

    var secHandBrush = Paint()
      ..color = Colors.orange[300]!
      ..strokeCap=StrokeCap.round
      ..strokeWidth = 8
      ..style = PaintingStyle.stroke;

    var minHandBrush = Paint()
      ..shader =
          const RadialGradient(colors: [color6, color5 ]).createShader(
        Rect.fromCircle(center: center, radius: radius),
      )
      ..strokeCap=StrokeCap.round
      ..strokeWidth = 10
      ..style = PaintingStyle.stroke;

    var hourHandBrush = Paint()
      ..shader =
       const RadialGradient(colors: [color4,color5]).createShader(
        Rect.fromCircle(center: center, radius: radius),
      )
      ..strokeCap=StrokeCap.round
      ..strokeWidth = 12
      ..style = PaintingStyle.stroke;

    canvas.drawCircle(center, radius - 40, fillBrush);
    canvas.drawCircle(center, radius - 40, outLineBrush);

    var hourHandX = centerx + 60 * cos((dateTime.hour *30 + dateTime.minute*0.5) *pi/180);
    var hourHandY = centerx + 60 * sin((dateTime.hour *30 + dateTime.minute*0.5) *pi/180);
    canvas.drawLine(center,  Offset(hourHandX, hourHandY), hourHandBrush);

    var minHandX = centerx + 80 * cos(dateTime.minute *6 *pi/180);
    var minHandY = centerx + 80 *sin(dateTime.minute *6 *pi/180);
    canvas.drawLine(center,  Offset(minHandX, minHandY), minHandBrush);

    var secHandX = centerx + 80 * cos(dateTime.second*6 *pi/180);
    var secHandY = centerx + 80 *sin(dateTime.second*6 *pi/180);
    canvas.drawLine(center,  Offset(secHandX, secHandY), secHandBrush);
    canvas.drawCircle(center, 16, centerFillBrush);

    var outerCircleRadius = radius;
    var innerCircleRadius = radius - 14;
    var dashBrush = Paint()
      ..color = Color(0xFFEAECFF)
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 1;

    for (double i = 0; i < 360; i += 12) {
      var x1 = centerx + outerCircleRadius * cos(i * pi / 180);
      var y1 = centery + outerCircleRadius * sin(i * pi / 180);

      var x2 = centerx + innerCircleRadius * cos(i * pi / 180);
      var y2 = centery + innerCircleRadius * sin(i * pi / 180);
      canvas.drawLine(Offset(x1, y1), Offset(x2, y2), dashBrush);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
