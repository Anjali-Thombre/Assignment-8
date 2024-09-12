import 'package:flutter/material.dart';
import 'dart:math' as math;

class CustomLoadingSpinner extends StatefulWidget {
  @override
  _CustomLoadingSpinnerState createState() => _CustomLoadingSpinnerState();
}

class _CustomLoadingSpinnerState extends State<CustomLoadingSpinner>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;  // Use 'late' to ensure it is initialized

  @override
  void initState() {
    super.initState();
    // Initialize the controller
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    )..repeat(); // Start the animation loop
  }

  @override
  void dispose() {
    // Always dispose of controllers when done
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.rotate(
          angle: _controller.value * 2 * math.pi,
          child: CustomPaint(
            painter: _SpinnerPainter(),
            size: Size(100, 100),
          ),
        );
      },
    );
  }
}

class _SpinnerPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    double radius = size.width / 2;
    var paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8.0;

    List<Color> colors = [Colors.red, Colors.green, Colors.blue, Colors.yellow];

    for (int i = 0; i < colors.length; i++) {
      paint.color = colors[i];
      double startAngle = i * (math.pi / 2);
      double sweepAngle = math.pi / 3;
      canvas.drawArc(
        Rect.fromCircle(center: Offset(radius, radius), radius: radius),
        startAngle,
        sweepAngle,
        false,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      body: Center(
        child: CustomLoadingSpinner(),
      ),
    ),
  ));
}
