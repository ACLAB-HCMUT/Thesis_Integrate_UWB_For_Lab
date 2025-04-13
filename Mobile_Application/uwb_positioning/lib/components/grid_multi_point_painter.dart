import 'package:flutter/material.dart';
import 'package:uwb_positioning/models/anchor.dart';
import 'package:uwb_positioning/models/device_location.dart';

class GridMultiPointPainter extends CustomPainter {
  final Map<String, Anchor> anchorPoints;
  final Map<String, DeviceLocation> tagPoints;
  final double scale;
  final Offset gridOffset;
  final double pointSize;

  GridMultiPointPainter({
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
      final x = (entry.anchorX) * gridSize * 5 + gridOffset.dx;
      final y = (entry.anchorY) * gridSize * 5 + gridOffset.dy;
      canvas.drawCircle(Offset(x, y), pointSize, anchorPaint);
    }

    List<Offset> tagPositions = [];
    for (int i = 0; i < tagPoints.length; i++) {
      final entry = tagPoints.values.elementAt(i);
      final x = (entry.tagX) * gridSize * 5 + gridOffset.dx;
      final y = (entry.tagY) * gridSize * 5 + gridOffset.dy;
      final tagPosition = Offset(x, y);
      tagPositions.add(tagPosition);

      // Tính toán màu sắc của điểm dựa trên vị trí của nó trong danh sách
      Color pointColor = Color.lerp(const Color.fromARGB(255, 233, 192, 205),
          const Color.fromARGB(255, 216, 0, 0), i / (tagPoints.length - 1))!;

      final paint = Paint()
        ..color = pointColor
        ..style = PaintingStyle.fill;

      // Vẽ điểm (circle) với màu sắc đã tính toán
      canvas.drawCircle(Offset(x, y), pointSize, paint);
    }

    // Store tag positions for line drawing

    for (int i = 0; i < tagPositions.length - 1; i++) {
      final dashedLinePaint = tagPaint
        ..color = Colors.red.withOpacity(0.2) // Màu đường vẽ
        ..strokeWidth = 3.0; // Độ dày đường vẽ (chỉnh theo ý muốn)

      canvas.drawLine(tagPositions[i], tagPositions[i + 1], dashedLinePaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true; // Always redraw if there are changes
  }
}
