import 'package:flutter/material.dart';

class GridPointPainter extends CustomPainter {
  final Map<String, Map<String, dynamic>> anchorPoints;
  final Map<String, dynamic> tagPoints;
  final double scale;
  final Offset gridOffset;
  final double pointSize;

  GridPointPainter({
    required this.anchorPoints,
    required this.tagPoints,
    required this.scale,
    required this.gridOffset,
    this.pointSize = 5.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final gridPaint = Paint()
      ..color = Colors.grey.withOpacity(0.5)
      ..style = PaintingStyle.stroke;

    final anchorPaint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.fill;

    final tagPaint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.fill;

    // Draw grid, calculate position based on gridOffset
    final double gridSize = 50 * scale;
    for (double i = -gridSize + gridOffset.dx % gridSize;
        i < size.width;
        i += gridSize) {
      canvas.drawLine(Offset(i, 0), Offset(i, size.height), gridPaint);
    }
    for (double i = -gridSize + gridOffset.dy % gridSize;
        i < size.height;
        i += gridSize) {
      canvas.drawLine(Offset(0, i), Offset(size.width, i), gridPaint);
    }

    // Draw points from anchorPoint
    for (var entry in anchorPoints.values) {
      final x = (entry['anchor_x'] as double) * gridSize * 5 + gridOffset.dx;
      final y = (entry['anchor_y'] as double) * gridSize * 5 + gridOffset.dy;
      canvas.drawCircle(Offset(x, y), pointSize, anchorPaint);
    }

    // final x = (tagPoints['tag_x'] as double) * gridSize * 5 + gridOffset.dx;
    // final y = (tagPoints['tag_y'] as double) * gridSize * 5 + gridOffset.dy;
    // canvas.drawCircle(Offset(x, y), pointSize, tagPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true; // Always redraw if there are changes
  }
}
