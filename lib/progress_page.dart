// progress_page.dart
// Dependencies:
//   flutter_bloc: ^9.1.0
//   percent_indicator: ^4.2.3
//   fl_chart: ^0.64.0
//   google_fonts: ^6.1.0
//   intl: ^0.19.0

import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class ProgressPage extends StatelessWidget {
  const ProgressPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Progress', style: GoogleFonts.roboto()),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Circular progress indicator
            Text('Overall Progress', style: GoogleFonts.roboto(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            Center(
              child: CircularPercentIndicator(
                radius: 60.0,
                lineWidth: 13.0,
                animation: true,
                percent: 0.60,
                center: Text(
                  "60%",
                  style: GoogleFonts.roboto(fontWeight: FontWeight.bold, fontSize: 20.0),
                ),
                footer: Text(
                  "of your yearly goal",
                  style: GoogleFonts.roboto(fontWeight: FontWeight.bold, fontSize: 14.0),
                ),
                circularStrokeCap: CircularStrokeCap.round,
                progressColor: Colors.blueAccent,
              ),
            ),
            const SizedBox(height: 32),
            // Line chart for progress
            Text('Monthly Activity', style: GoogleFonts.roboto(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            SizedBox(
              height: 200,
              child: LineChart(
                LineChartData(
                  gridData: FlGridData(show: true),
                  titlesData: FlTitlesData(
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          final weeks = ['W1', 'W2', 'W3', 'W4'];
                          return Text(weeks[value.toInt() % 4], style: GoogleFonts.roboto(fontSize: 12));
                        },
                        interval: 1,
                      ),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) => Text('${value.toInt()}', style: GoogleFonts.roboto(fontSize: 12)),
                        interval: 2,
                      ),
                    ),
                  ),
                  borderData: FlBorderData(show: true),
                  minX: 0,
                  maxX: 3,
                  minY: 0,
                  maxY: 10,
                  lineBarsData: [
                    LineChartBarData(
                      spots: [
                        FlSpot(0, 4),
                        FlSpot(1, 6),
                        FlSpot(2, 5),
                        FlSpot(3, 8),
                      ],
                      isCurved: true,
                      color: Colors.blueAccent,
                      barWidth: 4,
                      belowBarData: BarAreaData(show: false),
                      dotData: FlDotData(show: true),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 32),
            // Progress details
            Text('Last Updated: ${DateFormat('yMMMd').format(DateTime.now())}', style: GoogleFonts.roboto(fontSize: 14)),
          ],
        ),
      ),
    );
  }
}
