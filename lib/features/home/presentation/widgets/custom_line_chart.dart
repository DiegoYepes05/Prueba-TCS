import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:prueba_tcs/features/reports/domain/entities/report_entity.dart';

class CustomLineChart extends StatelessWidget {
  final List<ReportEntity> reports;

  const CustomLineChart({required this.reports, super.key});

  @override
  Widget build(BuildContext context) {
    final List<FlSpot> incomeSpots = _prepareSpots(reports, Category.income);
    final List<FlSpot> expenseSpots = _prepareSpots(reports, Category.expense);

    final ({double end, double start}) dateRange = _getDateRange();
    final ({double end, double start}) amountRange = _getAmountRange();

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: LineChart(
        LineChartData(
          gridData: FlGridData(
            show: true,
            drawVerticalLine: true,
            drawHorizontalLine: true,
            getDrawingHorizontalLine: (double value) {
              return const FlLine(color: Colors.grey, strokeWidth: 0.5);
            },
            getDrawingVerticalLine: (double value) {
              return const FlLine(color: Colors.grey, strokeWidth: 0.5);
            },
          ),

          titlesData: FlTitlesData(
            show: true,
            rightTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            topTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 30,
                getTitlesWidget: (double value, TitleMeta meta) {
                  final List<FlSpot> allSpots = <FlSpot>[
                    ...incomeSpots,
                    ...expenseSpots,
                  ];
                  final FlSpot? matchingSpot = allSpots
                      .where((FlSpot spot) => (spot.x - value).abs() < 3600000)
                      .firstOrNull;

                  if (matchingSpot == null) {
                    return const SizedBox.shrink();
                  }

                  final DateTime date = DateTime.fromMillisecondsSinceEpoch(
                    value.toInt(),
                  );
                  final DateFormat formatter = DateFormat('dd/MM');
                  return SideTitleWidget(
                    axisSide: meta.axisSide,
                    child: Text(
                      formatter.format(date),
                      style: const TextStyle(
                        color: Colors.black54,
                        fontWeight: FontWeight.bold,
                        fontSize: 10,
                      ),
                    ),
                  );
                },
              ),
            ),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 50,
                getTitlesWidget: (double value, TitleMeta meta) {
                  return Text(
                    _formatAmountCOP(value),
                    style: const TextStyle(
                      color: Colors.black54,
                      fontWeight: FontWeight.bold,
                      fontSize: 10,
                    ),
                    textAlign: TextAlign.left,
                  );
                },
              ),
            ),
          ),

          borderData: FlBorderData(
            show: true,
            border: const Border(
              bottom: BorderSide(color: Colors.black26, width: 1),
              left: BorderSide(color: Colors.black26, width: 1),
            ),
          ),

          minX: dateRange.start,
          maxX: dateRange.end,
          minY: 0,
          maxY: amountRange.end,

          lineBarsData: <LineChartBarData>[
            if (incomeSpots.isNotEmpty)
              LineChartBarData(
                isCurved: true,
                color: Category.income.color,
                barWidth: 4,
                isStrokeCapRound: true,
                dotData: FlDotData(
                  show: true,
                  getDotPainter:
                      (
                        FlSpot spot,
                        double percent,
                        LineChartBarData barData,
                        int index,
                      ) => FlDotCirclePainter(
                        radius: 6,
                        color: Colors.white,
                        strokeWidth: 3,
                        strokeColor: Category.income.color,
                      ),
                ),
                belowBarData: BarAreaData(
                  show: true,
                  color: Category.income.color.withValues(alpha: 0.1),
                ),
                spots: incomeSpots,
              ),
            if (expenseSpots.isNotEmpty)
              LineChartBarData(
                isCurved: true,
                color: Category.expense.color,
                barWidth: 4,
                isStrokeCapRound: true,
                dotData: FlDotData(
                  show: true,
                  getDotPainter:
                      (
                        FlSpot spot,
                        double percent,
                        LineChartBarData barData,
                        int index,
                      ) => FlDotCirclePainter(
                        radius: 6,
                        color: Colors.white,
                        strokeWidth: 3,
                        strokeColor: Category.expense.color,
                      ),
                ),
                belowBarData: BarAreaData(
                  show: true,
                  color: Category.expense.color.withValues(alpha: 0.1),
                ),
                spots: expenseSpots,
              ),
          ],

          lineTouchData: LineTouchData(
            enabled: true,
            touchTooltipData: LineTouchTooltipData(
              getTooltipColor: (LineBarSpot touchedSpot) => Colors.black87,
              tooltipRoundedRadius: 8,
              getTooltipItems: (List<LineBarSpot> touchedBarSpots) {
                return touchedBarSpots.map((LineBarSpot barSpot) {
                  final DateTime date = DateTime.fromMillisecondsSinceEpoch(
                    barSpot.x.toInt(),
                  );
                  final String dateStr = DateFormat(
                    'MMM dd, yyyy',
                  ).format(date);
                  final bool isIncome =
                      barSpot.barIndex == 0 && incomeSpots.isNotEmpty;
                  final Category category = isIncome
                      ? Category.income
                      : Category.expense;

                  return LineTooltipItem(
                    '${category.name}\n${_formatAmountCOP(barSpot.y)}\n$dateStr',
                    TextStyle(
                      color: category.color,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                    textAlign: TextAlign.center,
                  );
                }).toList();
              },
            ),
          ),
        ),
      ),
    );
  }

  List<FlSpot> _prepareSpots(List<ReportEntity> reports, Category category) {
    final List<ReportEntity> filteredReports = reports
        .where((ReportEntity report) => report.category == category)
        .toList();

    filteredReports.sort(
      (ReportEntity a, ReportEntity b) => a.date.compareTo(b.date),
    );
    final Map<String, double> dailyAmounts = <String, double>{};
    final Map<String, DateTime> dailyDates = <String, DateTime>{};

    for (final ReportEntity report in filteredReports) {
      final String dateKey = DateFormat('yyyy-MM-dd').format(report.date);
      dailyAmounts[dateKey] = (dailyAmounts[dateKey] ?? 0) + report.amount;
      dailyDates[dateKey] = report.date;
    }

    return dailyAmounts.entries
        .map(
          (MapEntry<String, double> entry) => FlSpot(
            dailyDates[entry.key]!.millisecondsSinceEpoch.toDouble(),
            entry.value,
          ),
        )
        .toList();
  }

  ({double start, double end}) _getDateRange() {
    if (reports.isEmpty) {
      final DateTime now = DateTime.now();
      return (
        start: now
            .subtract(const Duration(days: 30))
            .millisecondsSinceEpoch
            .toDouble(),
        end: now.millisecondsSinceEpoch.toDouble(),
      );
    }

    final List<double> dates = reports
        .map((ReportEntity r) => r.date.millisecondsSinceEpoch.toDouble())
        .toList();
    dates.sort();

    return (start: dates.first, end: dates.last);
  }

  ({double start, double end}) _getAmountRange() {
    if (reports.isEmpty) {
      return (start: 0.0, end: 1000.0);
    }

    final List<double> amounts = reports
        .map((ReportEntity r) => r.amount)
        .toList();
    amounts.sort();

    final double maxAmount = amounts.last;
    return (start: 0.0, end: maxAmount * 1.1);
  }

  String _formatAmountCOP(double amount) {
    final NumberFormat formatter = NumberFormat.currency(
      locale: 'es_CO',
      symbol: '\$',
      decimalDigits: amount % 1 == 0 ? 0 : 2,
    );

    if (amount >= 1000000) {
      return '${formatter.format(amount / 1000000).replaceAll('\$', '\$')}M';
    } else if (amount >= 1000) {
      return '${formatter.format(amount / 1000).replaceAll('\$', '\$')}K';
    } else {
      return formatter.format(amount);
    }
  }
}
