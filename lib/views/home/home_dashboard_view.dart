import 'package:flutter/material.dart';

class HomeDashboardView extends StatefulWidget {
  const HomeDashboardView({super.key});

  @override
  State<HomeDashboardView> createState() => _HomeDashboardViewState();
}

class _HomeDashboardViewState extends State<HomeDashboardView> {
  DateTime _currentMonth = DateTime.now();

  void _previousMonth() {
    setState(() {
      _currentMonth = DateTime(_currentMonth.year, _currentMonth.month - 1);
    });
  }

  void _nextMonth() {
    setState(() {
      _currentMonth = DateTime(_currentMonth.year, _currentMonth.month + 1);
    });
  }

  String _getMonthName(int month) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];
    return months[month - 1];
  }

  int daysInMonth(int year, int month) {
    return DateTime(year, month + 1, 0).day;
  }

  int _getActivityLevel(DateTime date) {
    DateTime today = DateTime.now();
    DateTime todayDate = DateTime(today.year, today.month, today.day);
    if (date.isAfter(todayDate)) return -1;
    // Just a predictable but varied pattern for UI
    return ((date.day * 7 + date.month * 3) % 6);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDark ? const Color(0xFF14161E) : const Color(0xFFF6F6F8);
    final textColor =
        isDark ? const Color(0xFFF1F5F9) : const Color(0xFF0F172A);
    final cardBgColor =
        isDark ? const Color(0xFF1E293B).withValues(alpha: 0.5) : Colors.white;
    const primaryColor = Color(0xFF4051B5);

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        titleSpacing: 24,
        backgroundColor: isDark
            ? const Color(0xFF14161E).withValues(alpha: 0.8)
            : const Color(0xFFF6F6F8).withValues(alpha: 0.8),
        elevation: 0,
        scrolledUnderElevation: 0,
        title: Row(
          children: [
            const Icon(Icons.timer, color: primaryColor, size: 28),
            const SizedBox(width: 8),
            Text(
              'ButlerTimer',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: textColor,
                letterSpacing: -0.5,
              ),
            ),
          ],
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 24),
            decoration: BoxDecoration(
              color: primaryColor.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: const Icon(Icons.notifications, color: primaryColor),
              onPressed: () {},
            ),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(
            color: primaryColor.withValues(alpha: 0.1),
            height: 1.0,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Study Progress Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Monthly Study Progress",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: const Text(
                    'Details',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: primaryColor,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Heatmap Card
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: cardBgColor,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: primaryColor.withValues(alpha: 0.05)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Month Navigator
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.chevron_left),
                        color: textColor,
                        onPressed: _previousMonth,
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                      ),
                      Text(
                        '${_getMonthName(_currentMonth.month)} ${_currentMonth.year}',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: textColor,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.chevron_right),
                        color: textColor,
                        onPressed: _nextMonth,
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Heatmap Grid
                  _buildHeatmapDayLabels(),
                  const SizedBox(height: 8),
                  _buildMonthlyHeatmapGrid(),

                  const SizedBox(height: 24),

                  // Legend
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Text(
                        'LESS',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF94A3B8),
                        ),
                      ),
                      const SizedBox(width: 8),
                      _buildHeatmapCell(0, smallLegend: true),
                      const SizedBox(width: 6),
                      _buildHeatmapCell(2, smallLegend: true),
                      const SizedBox(width: 6),
                      _buildHeatmapCell(3, smallLegend: true),
                      const SizedBox(width: 6),
                      _buildHeatmapCell(5, smallLegend: true),
                      const SizedBox(width: 8),
                      const Text(
                        'MORE',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF94A3B8),
                          letterSpacing: 0.5,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),

            // Recent Summary Section
            Text(
              "Recent Summary",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
            ),
            const SizedBox(height: 16),

            // Stat Cards
            _buildStatCard(
              isDark: isDark,
              textColor: textColor,
              cardBgColor: cardBgColor,
              primaryColor: primaryColor,
              icon: Icons.menu_book,
              iconColor: const Color(0xFF2563EB), // blue-600
              iconBgColor:
                  const Color(0xFF3B82F6).withValues(alpha: 0.1), // blue-500/10
              title: "Today's Problems",
              value: "35",
              trailing: const Row(
                children: [
                  Icon(Icons.trending_up, color: Color(0xFF22C55E), size: 16),
                  SizedBox(width: 4),
                  Text('+5',
                      style: TextStyle(
                          color: Color(0xFF22C55E),
                          fontSize: 12,
                          fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            const SizedBox(height: 16),

            _buildStatCard(
              isDark: isDark,
              textColor: textColor,
              cardBgColor: cardBgColor,
              primaryColor: primaryColor,
              icon: Icons.hourglass_top,
              iconColor: const Color(0xFFD97706), // amber-600
              iconBgColor: const Color(0xFFF59E0B)
                  .withValues(alpha: 0.1), // amber-500/10
              title: "Cumulative Selection",
              value: "10m 20s",
            ),
            const SizedBox(height: 16),

            _buildStatCard(
              isDark: isDark,
              textColor: textColor,
              cardBgColor: cardBgColor,
              primaryColor: primaryColor,
              icon: Icons.verified,
              iconColor: primaryColor,
              iconBgColor: primaryColor.withValues(alpha: 0.1),
              title: "Avg. Accuracy",
              value: "75%",
              trailing: SizedBox(
                width: 64,
                height: 8,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(
                    value: 0.75,
                    backgroundColor: isDark
                        ? const Color(0xFF334155)
                        : const Color(0xFFE2E8F0),
                    valueColor:
                        const AlwaysStoppedAnimation<Color>(primaryColor),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 48),
          ],
        ),
      ),
    );
  }

  Widget _buildHeatmapDayLabels() {
    final days = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 7,
        crossAxisSpacing: 8,
        mainAxisSpacing: 0,
        childAspectRatio: 2.0, // wider to fit text nicely
      ),
      itemCount: 7,
      itemBuilder: (context, index) {
        return Center(
          child: Text(
            days[index],
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Color(0xFF94A3B8), // slate-400
            ),
          ),
        );
      },
    );
  }

  Widget _buildMonthlyHeatmapGrid() {
    int year = _currentMonth.year;
    int month = _currentMonth.month;
    int totalDays = daysInMonth(year, month);
    DateTime firstDay = DateTime(year, month, 1);
    int firstWeekday = firstDay.weekday; // 1 = Monday, 7 = Sunday

    // empty blocks before the 1st
    int emptyPrefix = firstWeekday - 1;

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 7,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
      itemCount: emptyPrefix + totalDays,
      itemBuilder: (context, index) {
        if (index < emptyPrefix) {
          return const SizedBox();
        }
        DateTime date = DateTime(year, month, index - emptyPrefix + 1);
        int level = _getActivityLevel(date);
        bool isToday = date.year == DateTime.now().year &&
            date.month == DateTime.now().month &&
            date.day == DateTime.now().day;
        return _buildHeatmapCell(level, isToday: isToday, day: date.day);
      },
    );
  }

  Widget _buildHeatmapCell(int level,
      {bool isToday = false, bool smallLegend = false, int? day}) {
    // For GridView, Layout delegate controls the size.
    // For Legend, we constraint it to small specific dimensions.
    Widget cell = Container(
      decoration: BoxDecoration(
        color: _getHeatmapColor(level),
        borderRadius: BorderRadius.circular(4),
        border: isToday
            ? Border.all(color: const Color(0x7DEF4444), width: 2)
            : null,
      ),
      child: (day != null && !smallLegend)
          ? Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 4.0, top: 4.0),
                child: Text(
                  '$day',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: level == -1
                        ? const Color(0xFF94A3B8).withValues(alpha: 0.5)
                        : (level >= 3
                            ? Colors.white.withValues(alpha: 0.9)
                            : const Color(0xFF94A3B8)), // slate-400
                  ),
                ),
              ),
            )
          : null,
    );

    if (smallLegend) {
      return SizedBox(width: 14, height: 14, child: cell);
    }
    return cell;
  }

  Color _getHeatmapColor(int level) {
    if (level == -1) {
      final isDark = Theme.of(context).brightness == Brightness.dark;
      return isDark ? const Color(0xFF334155) : const Color(0xFFE2E8F0); // slate-700 : slate-200
    }
    switch (level) {
      case 0:
        return const Color(0xFFFEF2F2); // red-50
      case 1:
        return const Color(0xFFFEE2E2); // red-100
      case 2:
        return const Color(0xFFFECACA); // red-200
      case 3:
        return const Color(0xFFF87171); // red-400
      case 4:
        return const Color(0xFFEF4444); // red-500
      case 5:
        return const Color(0xFFDC2626); // red-600
      default:
        return const Color(0xFFFEF2F2);
    }
  }

  Widget _buildStatCard({
    required bool isDark,
    required Color textColor,
    required Color cardBgColor,
    required Color primaryColor,
    required IconData icon,
    required Color iconColor,
    required Color iconBgColor,
    required String title,
    required String value,
    Widget? trailing,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: cardBgColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: primaryColor.withValues(alpha: 0.05)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: iconBgColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: iconColor),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF64748B), // slate-500
                  ),
                ),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                ),
              ],
            ),
          ),
          if (trailing != null) trailing,
        ],
      ),
    );
  }
}
