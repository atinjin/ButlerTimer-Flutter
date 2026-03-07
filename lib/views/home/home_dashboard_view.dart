import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class HomeDashboardView extends StatelessWidget {
  const HomeDashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF000000), // Dark theme base
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF1B4019), // Dark green at top
              Color(0xFF000000), // Black at bottom
            ],
            stops: [0.0, 0.4],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top Bar (Back button simulated)
                Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.arrow_back_ios_new,
                            color: Colors.white, size: 18),
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // Title Area
                const Row(
                  children: [
                    Icon(Icons.bolt, color: Color(0xFF4ADE80), size: 28),
                    SizedBox(width: 8),
                    Text(
                      'Training Load Ratio',
                      style: TextStyle(
                        color: Color(0xFF4ADE80),
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Big Number
                const Text(
                  '0.83',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 72,
                    fontWeight: FontWeight.bold,
                    height: 1.0,
                    letterSpacing: -2.0,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Dec 12, 2025',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.6),
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 24),

                // Description
                const Text(
                  'Training load is in its sweet spot. A solid balance of stress and recovery that supports progress with low risk of injury or overtraining.',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    height: 1.5,
                  ),
                ),

                const SizedBox(height: 48),

                // Chart Date Selector
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child:
                          const Icon(Icons.chevron_left, color: Colors.white),
                    ),
                    const Text(
                      'Nov 15 – Dec 12, 2025',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.05),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.chevron_right,
                          color: Colors.white38),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Row(
                        children: [
                          Text('4W', style: TextStyle(color: Colors.white)),
                          SizedBox(width: 4),
                          Icon(Icons.unfold_more,
                              color: Colors.white, size: 16),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 32),

                // Chart Widget
                SizedBox(
                  height: 240,
                  child: _buildChart(),
                ),

                const SizedBox(height: 40),

                // 4-Week Overview
                Text(
                  '4-WEEK OVERVIEW',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.5),
                    fontSize: 12,
                    letterSpacing: 1.2,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),

                Row(
                  children: [
                    Expanded(
                        child: _buildOverviewCard(
                            'Average', '0.92', Icons.calculate_outlined)),
                    const SizedBox(width: 12),
                    Expanded(
                        child: _buildOverviewCard(
                            'Max', '1.37', Icons.trending_up)),
                    const SizedBox(width: 12),
                    Expanded(
                        child: _buildOverviewCard(
                            'Workouts', '0.29', Icons.fitness_center)),
                  ],
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildOverviewCard(String title, String value, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1C1C1E),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Colors.white54, size: 20),
          const SizedBox(height: 8),
          Text(
            title,
            style: const TextStyle(color: Colors.white54, fontSize: 13),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChart() {
    return LineChart(
      LineChartData(
        minY: 0,
        maxY: 1.8,
        minX: 0,
        maxX: 12,
        gridData: FlGridData(
          show: true,
          drawVerticalLine: false,
          horizontalInterval: 0.8,
          getDrawingHorizontalLine: (value) {
            return FlLine(
              color: Colors.white.withOpacity(0.1),
              strokeWidth: 1,
            );
          },
        ),
        titlesData: FlTitlesData(
          show: true,
          topTitles:
              const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 36,
              interval: 0.5,
              getTitlesWidget: (value, meta) {
                if (value == 0.0)
                  return const Text('0.00',
                      style: TextStyle(color: Colors.white54, fontSize: 10));
                if (value == 0.8)
                  return const Text('0.80',
                      style: TextStyle(color: Colors.white54, fontSize: 10));
                if (value == 1.3)
                  return const Text('1.30',
                      style: TextStyle(color: Colors.white54, fontSize: 10));
                if (value == 1.5)
                  return const Text('1.50',
                      style: TextStyle(color: Colors.white54, fontSize: 10));
                return const Text('');
              },
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 65,
              interval: 0.1,
              getTitlesWidget: (value, meta) {
                if (value == 0.2)
                  return const Text('Detraining',
                      style: TextStyle(color: Colors.white54, fontSize: 10));
                if (value == 0.8)
                  return const Text('Optimal',
                      style: TextStyle(color: Color(0xFF4ADE80), fontSize: 10));
                if (value == 1.3)
                  return const Text('Medium R.',
                      style: TextStyle(color: Colors.white54, fontSize: 10));
                if (value == 1.6)
                  return const Text('High Risk',
                      style: TextStyle(color: Colors.white54, fontSize: 10));
                return const Text('');
              },
            ),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 32,
              interval: 3,
              getTitlesWidget: (value, meta) {
                switch (value.toInt()) {
                  case 0:
                    return const Padding(
                        padding: EdgeInsets.only(top: 8),
                        child: Text('16',
                            style: TextStyle(
                                color: Colors.white54, fontSize: 11)));
                  case 3:
                    return const Padding(
                        padding: EdgeInsets.only(top: 8),
                        child: Text('23',
                            style: TextStyle(
                                color: Colors.white54, fontSize: 11)));
                  case 6:
                    return const Column(children: [
                      SizedBox(height: 8),
                      Text('30',
                          style: TextStyle(
                              color: Colors.white54,
                              fontSize: 11,
                              height: 1.0)),
                      Text('Dec',
                          style: TextStyle(
                              color: Colors.white54, fontSize: 9, height: 1.0))
                    ]);
                  case 9:
                    return const Padding(
                        padding: EdgeInsets.only(top: 8),
                        child: Text('7',
                            style: TextStyle(
                                color: Colors.white54, fontSize: 11)));
                }
                return const Text('');
              },
            ),
          ),
        ),
        borderData: FlBorderData(
          show: true,
          border: Border(
            bottom: BorderSide(color: Colors.white.withOpacity(0.2), width: 1),
            right: BorderSide(color: Colors.white.withOpacity(0.2), width: 1),
            top: BorderSide.none,
            left: BorderSide.none,
          ),
        ),
        rangeAnnotations: RangeAnnotations(
          horizontalRangeAnnotations: [
            HorizontalRangeAnnotation(
              y1: 0.8,
              y2: 1.3,
              color: const Color(0xFF4ADE80).withOpacity(0.1),
            ),
          ],
        ),
        extraLinesData: ExtraLinesData(
          horizontalLines: [
            HorizontalLine(
              y: 0.92,
              color: Colors.white,
              strokeWidth: 2,
              label: HorizontalLineLabel(
                show: true,
                alignment: Alignment.topLeft,
                padding: const EdgeInsets.only(bottom: 4, left: 4),
                style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14),
                labelResolver: (line) => '0.92',
              ),
            ),
          ],
        ),
        lineBarsData: [
          LineChartBarData(
            spots: const [
              FlSpot(0, 0.4),
              FlSpot(1, 0.2),
              FlSpot(1.5, 1.6),
              FlSpot(2.5, 0.6),
              FlSpot(3, 0.4),
              FlSpot(3.5, 1.2),
              FlSpot(4.5, 0.6),
              FlSpot(5, 1.4),
              FlSpot(6, 0.8),
              FlSpot(6.5, 0.5),
              FlSpot(7, 1.0),
              FlSpot(7.5, 0.6),
              FlSpot(8.5, 1.5),
              FlSpot(10, 0.3),
              FlSpot(10.5, 0.9),
              FlSpot(11, 0.6),
              FlSpot(11.8, 0.83),
            ],
            isCurved: false,
            color: Colors.white.withOpacity(0.6),
            barWidth: 2,
            isStrokeCapRound: true,
            dotData: FlDotData(
              show: true,
              checkToShowDot: (spot, barData) {
                return spot.x == 11.8;
              },
              getDotPainter: (spot, percent, barData, index) {
                return FlDotCirclePainter(
                  radius: 6,
                  color: const Color(0xFF4ADE80),
                  strokeWidth: 3,
                  strokeColor: Colors.black,
                );
              },
            ),
            belowBarData: BarAreaData(show: false),
          ),
        ],
      ),
    );
  }
}
