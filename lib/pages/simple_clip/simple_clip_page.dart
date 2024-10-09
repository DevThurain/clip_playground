import 'package:flutter/material.dart';

class SimpleClipPage extends StatelessWidget {
  const SimpleClipPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Simple Clip"),
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                stops: [0.6, 0.99],
                colors: <Color>[
                  Color(0xff440083),
                  Color(0xff9256D7),
                ],
              )),
              child: const Expanded(child: SizedBox()),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: CustomPaint(
              size: Size.infinite, // Set the size of the CustomPaint
              painter: RoundedTopCornersPainterV2(factor: 35),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 200,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TriangleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(size.width / 2, 0); // Move to top center
    path.lineTo(size.width, size.height); // Line to bottom right
    path.lineTo(0, size.height); // Line to bottom left
    path.close(); // Close the path to form a triangle
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false; // No need to reclip unless the shape changes
  }
}

class NotchedClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(0, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.arcToPoint(
      Offset(size.width / 2, 0),
      radius: Radius.circular(50.0),
      clockwise: false,
    );
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}

class WaveShapeClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(0, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);

    path.close(); // Close the path
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class RoundedSquareClipper extends CustomClipper<Path> {
  final double radius; // Radius for the corners

  RoundedSquareClipper({this.radius = 20.0}); // Default radius can be changed

  @override
  Path getClip(Size size) {
    final path = Path();

    // Create a rounded rectangle
    path.addRRect(RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Radius.circular(radius),
    ));

    return path; // Return the rounded rectangle path
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class RoundedTopCornersPainter extends CustomPainter {
  final double radius; // Radius for the top corners

  RoundedTopCornersPainter({this.radius = 20.0});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.blue; // Paint color
    final path = Path();
    final borderPath = Path();

    // path.lineTo(0, size.height);
    final borderPaint = Paint()
      ..color = Colors.greenAccent // Set the color of the border
      ..style = PaintingStyle.stroke // Draw the stroke (border)
      ..strokeWidth = 2.0;

    var width = size.width;
    var height = size.height;
    var factor = 25.0;

    path.moveTo(0, 0);
    path.moveTo(factor, 0); // move to right
    path.quadraticBezierTo(0, 0, 0, factor);
    path.lineTo(0, height);
    path.lineTo(width, height);

    path.lineTo(width, factor);
    path.quadraticBezierTo(width, 0, width - factor, 0);
    path.lineTo(factor, 0);
    canvas.drawPath(path, paint);
    canvas.drawPath(path, borderPaint);

    var yellow = Paint()..color = Colors.blue; // Paint color
    var path2 = Path();

    path2.moveTo(width, -factor);
    path2.lineTo(width, height);
    path2.lineTo(width - factor, height);
    path2.lineTo(width - factor, 0);
    path2.quadraticBezierTo(width, 0, width, -factor);
    canvas.drawPath(path2, yellow);
    canvas.drawPath(path2, borderPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class RoundedTopCornersPainterV2 extends CustomPainter {
  final double factor; // Radius for the top corners

  RoundedTopCornersPainterV2({this.factor = 25.0});

  @override
  void paint(Canvas canvas, Size size) {
    Color purple = const Color.fromARGB(255, 40, 0, 85);
    Color lightPurple = const Color.fromARGB(215, 96, 31, 162);

    final paint = Paint()..color = purple; // Paint color
    final path = Path();
    final borderPath = Path();

    // path.lineTo(0, size.height);
    final borderPaint = Paint()
      ..color = lightPurple // Set the color of the border
      ..style = PaintingStyle.stroke // Draw the stroke (border)
      ..strokeWidth = 1.5;

    var width = size.width;
    var height = size.height;

    path.moveTo(0, 0);
    path.moveTo(factor, 0); // move to right
    path.quadraticBezierTo(0, 0, 0, factor);
    path.lineTo(0, height);
    path.lineTo(width, height);

    path.lineTo(width, factor);
    path.quadraticBezierTo(width, 0, width - factor, 0);
    path.lineTo(factor, 0);
    canvas.drawPath(path, paint);

    var yellow = Paint()..color = purple; // Paint color
    var path2 = Path();

    path2.moveTo(width, -factor);
    path2.lineTo(width, height);
    path2.lineTo(width - factor, height);
    path2.lineTo(width - factor, 0);
    path2.quadraticBezierTo(width, 0, width, -factor);
    canvas.drawPath(path2, yellow);

    borderPath.moveTo(0, factor);
    borderPath.quadraticBezierTo(0, 0, factor, 0);
    borderPath.lineTo(width - factor, 0);
    borderPath.quadraticBezierTo(width, 0, width, -factor);
    canvas.drawPath(borderPath, borderPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
