import 'package:flutter/material.dart';
import 'package:balamurugan_erp/core/theme/colors.dart';

class IncomeExpenseCard extends StatelessWidget {
  const IncomeExpenseCard({
    super.key,
    required this.chartRange,
    required this.onRangeChanged,
  });

  final String chartRange;
  final ValueChanged<String> onRangeChanged;

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
        padding: const EdgeInsets.fromLTRB(21, 19, 18, 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Income & expenses',
                        style: TextStyle(
                          color: AppColors.ink,
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        'Track your cash movement over the last 6 months',
                        style: TextStyle(color: AppColors.muted, fontSize: 11),
                      ),
                      SizedBox(height: 9),
                      Row(
                        children: [
                          _LegendDot(color: AppColors.primary),
                          SizedBox(width: 6),
                          Text('Income', style: TextStyle(color: AppColors.muted, fontSize: 10)),
                          SizedBox(width: 15),
                          _LegendDot(color: Color(0xFFAEBBD0)),
                          SizedBox(width: 6),
                          Text('Expenses', style: TextStyle(color: AppColors.muted, fontSize: 10)),
                        ],
                      ),
                    ],
                  ),
                ),
                DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: chartRange,
                    style: const TextStyle(color: Color(0xFF59677E), fontSize: 11),
                    borderRadius: BorderRadius.circular(8),
                    items: const [
                      DropdownMenuItem(value: 'Last 6 months', child: Text('Last 6 months')),
                      DropdownMenuItem(value: 'Last 12 months', child: Text('Last 12 months')),
                      DropdownMenuItem(value: 'This financial year', child: Text('This financial year')),
                    ],
                    onChanged: (value) {
                      if (value != null) onRangeChanged(value);
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 5),
            const SizedBox(
              height: 220,
              width: double.infinity,
              child: CustomPaint(painter: IncomeExpensePainter()),
            ),
          ],
        ),
      ),
    );
  }
}

class _LegendDot extends StatelessWidget {
  const _LegendDot({required this.color});

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 7,
      height: 7,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }
}

class IncomeExpensePainter extends CustomPainter {
  const IncomeExpensePainter();

  @override
  void paint(Canvas canvas, Size size) {
    const left = 43.0;
    const right = 7.0;
    const top = 12.0;
    const bottom = 32.0;
    final chartWidth = size.width - left - right;
    final chartHeight = size.height - top - bottom;
    final gridPaint = Paint()
      ..color = const Color(0xFFEDF0F5)
      ..strokeWidth = 1;

    for (var i = 0; i <= 4; i++) {
      final y = top + chartHeight * i / 4;
      canvas.drawLine(Offset(left, y), Offset(size.width - right, y), gridPaint);
      _drawText(
        canvas,
        i == 4 ? '₹0' : '₹${4 - i}L',
        Offset(4, y - 6),
        const TextStyle(color: Color(0xFF9BA6B7), fontSize: 10),
      );
    }

    const income = [2.4, 2.8, 2.2, 3.0, 3.3, 3.7];
    const expenses = [1.5, 1.7, 1.3, 1.9, 2.1, 2.3];
    const labels = ['Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug'];
    const maxValue = 4.0;
    final groupWidth = chartWidth / labels.length;
    final barWidth = (groupWidth * .23).clamp(14.0, 27.0).toDouble();
    final incomePaint = Paint()..color = const Color(0xFFDBE6FF);
    final highlightPaint = Paint()..color = AppColors.primary;
    final expensePaint = Paint()..color = const Color(0xFFEDF0F4);
    final linePaint = Paint()
      ..color = const Color(0xFF3E77F9)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;
    final path = Path();

    for (var i = 0; i < labels.length; i++) {
      final center = left + groupWidth * (i + .5);
      final incomeHeight = chartHeight * income[i] / maxValue;
      final expenseHeight = chartHeight * expenses[i] / maxValue;
      final incomeRect = RRect.fromRectAndRadius(
        Rect.fromLTWH(
          center - barWidth - 3,
          top + chartHeight - incomeHeight,
          barWidth,
          incomeHeight,
        ),
        const Radius.circular(5),
      );
      final expenseRect = RRect.fromRectAndRadius(
        Rect.fromLTWH(
          center + 3,
          top + chartHeight - expenseHeight,
          barWidth,
          expenseHeight,
        ),
        const Radius.circular(5),
      );
      canvas.drawRRect(
        incomeRect,
        i == labels.length - 1 ? highlightPaint : incomePaint,
      );
      canvas.drawRRect(expenseRect, expensePaint);
      final point = Offset(center - barWidth / 2 - 3, top + chartHeight - incomeHeight);
      if (i == 0) {
        path.moveTo(point.dx, point.dy);
      } else {
        path.lineTo(point.dx, point.dy);
      }
      _drawCenteredText(
        canvas,
        labels[i],
        Offset(center, size.height - 13),
        const TextStyle(color: Color(0xFF9BA6B7), fontSize: 10),
      );
    }
    canvas.drawPath(path, linePaint);
    final finalCenter = left + groupWidth * (labels.length - .5);
    final finalHeight = chartHeight * income.last / maxValue;
    canvas.drawCircle(
      Offset(finalCenter - barWidth / 2 - 3, top + chartHeight - finalHeight),
      4,
      Paint()
        ..color = Colors.white
        ..style = PaintingStyle.fill,
    );
    canvas.drawCircle(
      Offset(finalCenter - barWidth / 2 - 3, top + chartHeight - finalHeight),
      4,
      Paint()
        ..color = AppColors.primary
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2,
    );
  }

  void _drawText(Canvas canvas, String text, Offset offset, TextStyle style) {
    final painter = TextPainter(
      text: TextSpan(text: text, style: style),
      textDirection: TextDirection.ltr,
    )..layout();
    painter.paint(canvas, offset);
  }

  void _drawCenteredText(Canvas canvas, String text, Offset center, TextStyle style) {
    final painter = TextPainter(
      text: TextSpan(text: text, style: style),
      textDirection: TextDirection.ltr,
    )..layout();
    painter.paint(canvas, Offset(center.dx - painter.width / 2, center.dy - painter.height / 2));
  }

  @override
  bool shouldRepaint(covariant IncomeExpensePainter oldDelegate) => false;
}
