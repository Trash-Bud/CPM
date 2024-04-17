import 'dart:math';

import 'package:assignment2/utils/constants.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import 'bar_data.dart';

class BarGraphWidget extends StatelessWidget {
  final List<String> currency;
  final List<double> amount;
  final List<Color> color;

  const BarGraphWidget({super.key, required this.currency, required this.amount, required this.color});

  @override
  Widget build(BuildContext context) {
    BarData data = BarData(currency, amount,color);

    data.initializeBarData();

    return BarChart(BarChartData(
        minY: 0,
        maxY: double.parse(amount.reduce(max).toStringAsFixed(0))+1,
        gridData: FlGridData(show: false),
        borderData: FlBorderData(show: false),
        titlesData: FlTitlesData(
            show: true,
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                reservedSize: 40,
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  if (value == double.parse(amount.reduce(max).toStringAsFixed(0))+1 ){
                    return SideTitleWidget(axisSide: meta.axisSide, child: const SizedBox.shrink());
                  }
                  return SideTitleWidget(axisSide: meta.axisSide, child: Text(meta.formattedValue));
                },
              ),
            ),
            rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                    showTitles: true, getTitlesWidget: getBottomTiles))),
        barGroups: data.barData
            .map(
              (e) => BarChartGroupData(
                x: e.x,
                barRods: [
                  BarChartRodData(
                    toY: e.y,
                    width: 40,
                    borderRadius: BorderRadius.circular(4),
                    color: e.color,
                    
                  )
                ],
              ),
            )
            .toList()));
  }

  Widget getBottomTiles(double value, TitleMeta meta) {
    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: Text(
        currency[value.toInt()],
        style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
      ),
    );
  }
}
