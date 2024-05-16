import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

import '../constants/color_constants.dart';

class ClockView extends StatefulWidget {
  const ClockView({super.key, required this.size});
  final double size;

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
      height: widget.size,
      width: widget.size,
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
    var centerX = size.width / 2;
    var centerY = size.height / 2;
    var center = Offset(centerX, centerY);

    var radius = min(centerX, centerY);

   //Draw fillbrush fill
    var fillBrush = Paint()..color = color2;
    canvas.drawCircle(center, radius *.75, fillBrush);

    //Draw outline
    var outLineBrush = Paint()
      ..color = color3
      ..strokeWidth = size.width/20
      ..style = PaintingStyle.stroke;
    canvas.drawCircle(center, radius *.75, outLineBrush);

    // Draw clock numbers
    for (int i = 1; i <= 12; i++) {
      double angle = (i * 30) * pi / 180;
      double x = centerX + 0.6 * radius * cos(angle);
      double y = centerY + 0.6 * radius * sin(angle);
      drawRotatedText(canvas, i.toString(), Offset(x, y), pi / 2); // Rotate each number 90 degrees anticlockwise
    }

    // Draw Hour Hand
    var hourHandBrush = Paint()
      ..shader =
       const RadialGradient(colors: [color4,color5]).createShader(
        Rect.fromCircle(center: center, radius: radius),
      )
      ..strokeCap=StrokeCap.round
      ..strokeWidth = size.width/24
      ..style = PaintingStyle.stroke;
    double hourHandX = centerX + radius * 0.35 * cos((dateTime.hour * 30 + dateTime.minute * 0.5) * pi / 180);
    double hourHandY = centerY + radius * 0.35 * sin((dateTime.hour * 30 + dateTime.minute * 0.5) * pi / 180);
    canvas.drawLine(center,  Offset(hourHandX, hourHandY), hourHandBrush);

    // Draw minute Hand
    var minHandBrush = Paint()
      ..shader =
      const RadialGradient(colors: [color6, color5 ]).createShader(
        Rect.fromCircle(center: center, radius: radius),
      )
      ..strokeCap=StrokeCap.round
      ..strokeWidth = size.width/30
      ..style = PaintingStyle.stroke;
    double minHandX = centerX + radius * 0.5 * cos(dateTime.minute * 6 * pi / 180);
    double minHandY = centerY + radius * 0.5 * sin(dateTime.minute * 6 * pi / 180);
    canvas.drawLine(center,  Offset(minHandX, minHandY), minHandBrush);

    // Draw Second Hand
    var secHandBrush = Paint()
      ..color = Colors.orange[300]!
      ..strokeCap=StrokeCap.round
      ..strokeWidth =size.width/60
      ..style = PaintingStyle.stroke;
    double secHandX = centerX + radius * 0.6 * cos(dateTime.second * 6 * pi / 180);
    double secHandY = centerY + radius * 0.6 * sin(dateTime.second * 6 * pi / 180);
    canvas.drawLine(center,  Offset(secHandX, secHandY), secHandBrush);

    // Draw center fill
    var centerFillBrush = Paint()..color = color3;
    canvas.drawCircle(center, radius * 0.1, centerFillBrush);


    //Draw Dashes
    var outerCircleRadius = radius;
    var innerCircleRadius = radius*0.9;
    var dashBrush = Paint()
      ..color = Color(0xFFEAECFF)
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 1;
    for (double i = 0; i < 360; i += 12) {
      var x1 = centerX + outerCircleRadius * cos(i * pi / 180);
      var y1 = centerY + outerCircleRadius * sin(i * pi / 180);

      var x2 = centerX + innerCircleRadius * cos(i * pi / 180);
      var y2 = centerY + innerCircleRadius * sin(i * pi / 180);
      canvas.drawLine(Offset(x1, y1), Offset(x2, y2), dashBrush);
    }
  }
  void drawRotatedText(Canvas canvas, String text, Offset position, double angle) {
    canvas.save();
    canvas.translate(position.dx, position.dy);
    canvas.rotate(angle);
    TextSpan span = TextSpan(
      text: text,
      style: TextStyle(
        color: Colors.white,
        fontSize: 18.0,
        fontWeight: FontWeight.bold,
      ),
    );
    TextPainter tp = TextPainter(
      text: span,
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );
    tp.layout();
    tp.paint(canvas, Offset(-tp.width / 2, -tp.height / 2));
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
