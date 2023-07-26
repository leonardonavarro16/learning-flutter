import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:swc_front/presentation/widgets/layout.dart';

class TestingPage extends StatelessWidget {
  const TestingPage({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Layout(
        content: Center(
          child: Stack(
            children: [
              Container(
                height: 300,
                width: 400,
                child: CustomPaint(
                  painter: RoundedBorderPainter(),
                  child: ClipRRect(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(30)),
                    child: Container(
                      color: Colors.red,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class RoundedBorderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;

    final path = Path()
      ..addRRect(RRect.fromLTRBR(
          0, 0, size.width, size.height - 1.25, Radius.circular(30)));

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

otherContent() => Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        border: const Border(
            top: BorderSide(
                color: Colors.white, width: 3, style: BorderStyle.none),
            left: BorderSide(color: Colors.white, width: 3),
            right: BorderSide(color: Colors.white, width: 3),
            bottom: BorderSide.none),
        color: Colors.red,
      ),
      height: 400,
      width: 400,
    );
