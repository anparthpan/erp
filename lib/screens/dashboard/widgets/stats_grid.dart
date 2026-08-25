import 'package:flutter/material.dart';
import 'package:balamurugan_erp/core/theme/colors.dart';
import 'package:balamurugan_erp/models/stat_data.dart';
import 'package:balamurugan_erp/models/mock_data.dart';

class StatsGrid extends StatelessWidget {
  const StatsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final columns = constraints.maxWidth < 540
            ? 2
            : constraints.maxWidth < 980
                ? 2
                : 4;
        final gap = columns == 2 ? 10.0 : 15.0;
        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: statCardsData.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: columns,
            crossAxisSpacing: gap,
            mainAxisSpacing: gap,
            mainAxisExtent: 132,
          ),
          itemBuilder: (context, index) => StatCard(data: statCardsData[index]),
        );
      },
    );
  }
}

class StatCard extends StatelessWidget {
  const StatCard({super.key, required this.data});

  final StatData data;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: AppColors.line),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(18, 17, 18, 14),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      data.title,
                      style: const TextStyle(
                        color: AppColors.muted,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Container(
                      width: 29,
                      height: 29,
                      decoration: BoxDecoration(
                        color: data.softColor,
                        borderRadius: BorderRadius.circular(9),
                      ),
                      child: Icon(data.icon, color: data.color, size: 15),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  data.value,
                  style: const TextStyle(
                    color: AppColors.ink,
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                    letterSpacing: -0.55,
                  ),
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    Icon(
                      data.positive
                          ? Icons.trending_up_rounded
                          : Icons.trending_down_rounded,
                      color: data.positive ? AppColors.green : AppColors.red,
                      size: 12,
                    ),
                    const SizedBox(width: 3),
                    Text(
                      data.trend,
                      style: TextStyle(
                        color: data.positive ? AppColors.green : AppColors.red,
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(width: 7),
                    Flexible(
                      child: Text(
                        data.foot,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: AppColors.muted,
                          fontSize: 11,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Positioned(
              right: 0,
              bottom: 0,
              child: CustomPaint(
                size: const Size(82, 34),
                painter: SparklinePainter(color: data.color, points: data.points),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SparklinePainter extends CustomPainter {
  const SparklinePainter({required this.color, required this.points});

  final Color color;
  final List<double> points;

  @override
  void paint(Canvas canvas, Size size) {
    if (points.length < 2) return;
    final maxValue = points.reduce((a, b) => a > b ? a : b);
    final minValue = points.reduce((a, b) => a < b ? a : b);
    final range = (maxValue - minValue).abs() < 1 ? 1 : maxValue - minValue;
    final path = Path();
    for (var i = 0; i < points.length; i++) {
      final x = i * size.width / (points.length - 1);
      final y = size.height - ((points[i] - minValue) / range * (size.height - 5)) - 2;
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }
    final area = Path.from(path)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();
    canvas.drawPath(area, Paint()..color = color.withValues(alpha: .12));
    canvas.drawPath(
      path,
      Paint()
        ..color = color
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.2
        ..strokeCap = StrokeCap.round
        ..strokeJoin = StrokeJoin.round,
    );
  }

  @override
  bool shouldRepaint(covariant SparklinePainter oldDelegate) => false;
}
