import 'package:flutter/material.dart';

class HexagonalPainter extends CustomPainter {
  final List<Offset> positions;
  final Offset offset;
  final Function(int) onTap;

  HexagonalPainter(
      {required this.positions, required this.offset, required this.onTap});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.transparent
      ..style = PaintingStyle.fill;

    for (var position in positions) {
      final adjustedPosition = position + offset;
      if (adjustedPosition.dx >= -75 &&
          adjustedPosition.dy >= -75 &&
          adjustedPosition.dx <= size.width + 75 &&
          adjustedPosition.dy <= size.height + 75) {
        canvas.drawCircle(
            adjustedPosition, 70.0, paint); // Aumenta el tamaño del círculo
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
