import 'package:flutter/material.dart';

class CustomCursor extends StatefulWidget {
  final Widget child;

  const CustomCursor({super.key, required this.child});

  @override
  State<CustomCursor> createState() => _CustomCursorState();
}

class _CustomCursorState extends State<CustomCursor> {
  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}

class ArrowCursorPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final path = Path();
    // Replicating the sharp black arrow with white outline (Mac Style)

    // Main arrow shape (Slightly larger and sharper)
    path.moveTo(0, 0); // Tip
    path.lineTo(5.8, 17.6); // Left edge inner
    path.lineTo(8.4, 15.6); // Indent
    path.lineTo(12.6, 26); // Tail left
    path.lineTo(16.5, 24.5); // Tail right
    path.lineTo(12.4, 14.4); // Indent right
    path.lineTo(19.2, 14.4); // Right wing
    path.close();

    // Shadow for depth ("Amazing" feel)
    canvas.drawShadow(path, Colors.black.withOpacity(0.3), 4, true);

    // White Outline (Thicker for better contrast)
    final outlinePaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    // Gradient Fill (Subtle Premium effect)
    final fillPaint = Paint()
      ..shader = const LinearGradient(
        colors: [Color(0xFF000000), Color(0xFF2C2C2E)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height))
      ..style = PaintingStyle.fill;

    // Draw outline first
    canvas.drawPath(path, outlinePaint);
    canvas.drawPath(path, fillPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
