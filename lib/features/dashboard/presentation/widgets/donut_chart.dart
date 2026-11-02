import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';

class DonutSegment {
  const DonutSegment(this.value, this.color);
  final double value;
  final Color color;
}

class DonutChart extends StatelessWidget {
  const DonutChart({
    super.key,
    required this.segments,
    this.size = 222,
    this.thickness = 56,
  });

  final List<DonutSegment> segments;
  final double size;
  final double thickness;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(painter: _DonutPainter(segments, thickness)),
    );
  }
}

class _DonutPainter extends CustomPainter {
  _DonutPainter(this.segments, this.thickness);

  final List<DonutSegment> segments;
  final double thickness;

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final outer = size.width / 2;
    final inner = outer - thickness;
    const corner = 5.0;
    const gap = 0.05; // radians

    // centre disc
    canvas.drawCircle(center, inner - 2, Paint()..color = AppColors.chartCenter);

    final total = segments.fold<double>(0, (s, e) => s + e.value);
    if (total <= 0) return;

    final ro = outer - corner;
    final ri = inner + corner;
    double start = -math.pi / 2;

    for (final seg in segments) {
      final sweep = seg.value / total * 2 * math.pi;
      final a0 = start + gap / 2;
      final a1 = start + sweep - gap / 2;
      start += sweep;

      final s0o = a0 + corner / ro;
      final sweepO = (a1 - a0) - 2 * corner / ro;
      final s0i = a1 - corner / ri;
      final sweepI = -((a1 - a0) - 2 * corner / ri);
      if (sweepO <= 0) continue;

      final path = Path()
        ..arcTo(Rect.fromCircle(center: center, radius: ro), s0o, sweepO, false)
        ..arcTo(Rect.fromCircle(center: center, radius: ri), s0i, sweepI, false)
        ..close();

      canvas.drawPath(path, Paint()..color = seg.color);
      canvas.drawPath(
        path,
        Paint()
          ..color = seg.color
          ..style = PaintingStyle.stroke
          ..strokeWidth = corner * 2
          ..strokeJoin = StrokeJoin.round,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _DonutPainter old) =>
      old.segments != segments || old.thickness != thickness;
}
