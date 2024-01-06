import "package:flutter/material.dart";

class HighlightPainter extends CustomPainter {
  HighlightPainter({
    this.dx,
    this.dy,
    this.width,
    this.height,
    this.color,
    this.borderRadius,
  });
  final double? dx;
  final double? dy;
  final double? width;
  final double? height;
  final Color? color;
  final Radius? borderRadius;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color!;
    canvas.drawPath(
      Path.combine(
        PathOperation.difference,
        Path()..addRect(Rect.fromLTWH(0, 0, size.width, size.height)),
        Path()
          ..addRRect(
            RRect.fromRectAndCorners(
              Rect.fromLTWH(
                dx! - (width! / 2),
                dy! - (height! / 2),
                width!,
                height!,
              ),
              topRight: borderRadius!,
              topLeft: borderRadius!,
              bottomRight: borderRadius!,
              bottomLeft: borderRadius!,
            ),
          )
          ..close(),
      ),
      paint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
