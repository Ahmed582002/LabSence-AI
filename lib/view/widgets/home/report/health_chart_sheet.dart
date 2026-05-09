import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:labsense_ai/controllers/home/reports_controller.dart';

class HealthChartSheet extends StatefulWidget {
  const HealthChartSheet({super.key});
  @override
  State<HealthChartSheet> createState() => _HealthChartSheetState();
}

class _HealthChartSheetState extends State<HealthChartSheet>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;
  final ReportsController reportsController = Get.find();
  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    animation = CurvedAnimation(parent: controller, curve: Curves.easeOut);
    controller.forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (reportsController.isLoading.value) {
        return const SizedBox(
          height: 300,
          child: Center(child: CircularProgressIndicator()),
        );
      }
      final spots = reportsController.getHealthScoreSpots();
      if (spots.isEmpty) {
        return const SizedBox(
          height: 300,
          child: Center(child: Text("No data yet")),
        );
      }
      return Container(
        height: MediaQuery.of(context).size.height * 0.6,
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
        ),
        child: Column(
          children: [
            const SizedBox(height: 10),
            Container(
              width: 50,
              height: 5,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              "81".tr,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: AnimatedBuilder(
                animation: animation,
                builder: (context, child) {
                  return LineChart(
                    LineChartData(
                      minX: 0,
                      maxX: (spots.length - 1).toDouble(),
                      minY: 0,
                      maxY: 99,
                      // lineTouchData: LineTouchData(
                      //   enabled: false, // ❌ نلغي اللمس
                      //   touchTooltipData: LineTouchTooltipData(
                      //     tooltipBgColor: Colors.transparent,
                      //     getTooltipItems: (touchedSpots) {
                      //       return touchedSpots.map((spot) {
                      //         return LineTooltipItem(
                      //           spot.y.toInt().toString(), // الرقم نفسه
                      //           const TextStyle(
                      //             color: Colors.black,
                      //             fontSize: 10,
                      //             fontWeight: FontWeight.bold,
                      //           ),
                      //         );
                      //       }).toList();
                      //     },
                      //   ),
                      // ),
                      gridData: FlGridData(show: true),
                      titlesData: FlTitlesData(
                        topTitles: AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),

                        rightTitles: AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),

                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            interval: 1,
                            getTitlesWidget: (value, meta) {
                              return Padding(
                                padding: const EdgeInsets.only(top: 8),
                                child: Text(
                                  value.toInt().toString(),
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),

                        leftTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            interval: 20,
                            reservedSize: 30,
                          ),
                        ),
                      ),
                      borderData: FlBorderData(
                        show: true,
                        border: Border(
                          left: BorderSide(color: Colors.grey),
                          bottom: BorderSide(color: Colors.grey),

                          top: BorderSide.none,
                          right: BorderSide.none,
                        ),
                      ),
                      lineBarsData: [
                        LineChartBarData(
                          spots: spots
                              .map((e) => FlSpot(e.x, e.y * animation.value))
                              .toList(),
                          isCurved: true,
                          barWidth: 4,
                          dotData: FlDotData(show: true),
                          showingIndicators: List.generate(
                            spots.length,
                            (index) => index,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      );
    });
  }
}
