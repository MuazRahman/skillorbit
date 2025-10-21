// gradient_circular_progress_indicator_widget.dart
import 'dart:math';
import 'package:flutter/material.dart';

class GradientCircularProgressIndicator extends StatelessWidget {
  final double progress; // Now accepts 0–100
  final double strokeWidth;
  final Color backgroundColor;
  final Gradient? gradient;
  final Widget? child;

  const GradientCircularProgressIndicator({
    super.key,
    required this.progress,
    this.strokeWidth = 10.0,
    this.backgroundColor = Colors.grey,
    this.gradient,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _GradientCircularProgressPainter(
        progress: progress / 100, // convert to 0–1 range internally
        strokeWidth: strokeWidth,
        backgroundColor: backgroundColor,
        gradient: gradient ??
            const SweepGradient(
              colors: [
                Colors.blue,
                Colors.green,
                Colors.yellow,
                Colors.orange,
                Colors.purple,
                Colors.blue,
              ],
              startAngle: 0.0,
              endAngle: 2 * pi,
            ),
      ),
      child: child,
    );
  }
}

class _GradientCircularProgressPainter extends CustomPainter {
  final double progress;
  final double strokeWidth;
  final Color backgroundColor;
  final Gradient gradient;

  _GradientCircularProgressPainter({
    required this.progress,
    required this.strokeWidth,
    required this.backgroundColor,
    required this.gradient,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - strokeWidth) / 2;

    final backgroundPaint = Paint()
      ..color = backgroundColor
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    canvas.drawCircle(center, radius, backgroundPaint);

    final foregroundPaint = Paint()
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..shader =
      gradient.createShader(Rect.fromCircle(center: center, radius: radius));

    final startAngle = -pi / 2;
    final sweepAngle = 2 * pi * progress;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      sweepAngle,
      false,
      foregroundPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
