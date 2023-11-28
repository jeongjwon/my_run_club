import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class ChartWidget extends StatelessWidget {
  const ChartWidget({
    super.key,
    required this.barData,
    required this.type,
  });

  final List<BarChartGroupData> barData;
  final String type;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: Container(
        padding: const EdgeInsets.fromLTRB(20, 20, 10, 20),
        child: BarChart(
          BarChartData(
            barTouchData: barTouchData,
            titlesData: titlesData,
            borderData: FlBorderData(show: false),
            gridData: gridData,
            maxY: type == 'year' ? 100 : 15,
            minY: 0,
            groupsSpace: 2,
            barGroups: barData,
            alignment: BarChartAlignment.spaceBetween,
          ),
        ),
      ),
    );
  }

  FlGridData get gridData => const FlGridData(
        show: true,
        drawHorizontalLine: true,
        drawVerticalLine: false,
      );

  FlTitlesData get titlesData => FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            getTitlesWidget: getTitles,
          ),
        ),
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 40,
          ),
        ),
        leftTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
      );

  BarTouchData get barTouchData => BarTouchData(
        enabled: false,
        handleBuiltInTouches: false,
        touchTooltipData: BarTouchTooltipData(
          tooltipBgColor: Colors.transparent,
          tooltipPadding: EdgeInsets.zero,
          tooltipMargin: 0,
          getTooltipItem: (
            BarChartGroupData group,
            int groupIndex,
            BarChartRodData rod,
            int rodIndex,
          ) {
            return BarTooltipItem(
              rod.toY > 0.0 ? rod.toY.toString() : '',
              const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            );
          },
        ),
      );

  Widget getTitles(double value, TitleMeta meta) {
    String text = '';
    if (type == 'week') {
      switch (value.toInt()) {
        case 0:
          text = '월';
          break;
        case 1:
          text = '화';
          break;
        case 2:
          text = '수';
          break;
        case 3:
          text = '목';
          break;
        case 4:
          text = '금';
          break;
        case 5:
          text = '토';
          break;
        case 6:
          text = '일';
          break;
        default:
          text = '';
          break;
      }
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 3,
      child: Text(type == 'week' ? text : (value.toInt() + 1).toString(),
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w500,
            fontSize: type == 'month' ? 8 : 12,
          )),
    );
  }
}
