import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/timer_provider.dart';
import '../../models/question_set.dart';
import '../summary/session_summary_view.dart';

class ActiveSessionView extends ConsumerStatefulWidget {
  final QuestionSet qSet;

  const ActiveSessionView({super.key, required this.qSet});

  @override
  ConsumerState<ActiveSessionView> createState() => _ActiveSessionViewState();
}

class _ActiveSessionViewState extends ConsumerState<ActiveSessionView> {
  // Filters: All, Completed, In Progress, Unsolved
  String _selectedFilter = 'All';

  @override
  Widget build(BuildContext context) {
    final timerState = ref.watch(timerProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDark ? const Color(0xFF14161E) : const Color(0xFFF6F6F8);
    final textColor = isDark ? const Color(0xFFF1F5F9) : const Color(0xFF0F172A);

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (bool didPop, Object? result) {
        if (didPop) return;
        _showExitConfirmDialog(context, ref);
      },
      child: Scaffold(
        backgroundColor: bgColor,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: isDark ? const Color(0xFF0F172A) : Colors.white,
          elevation: 0,
          scrolledUnderElevation: 0,
          centerTitle: true,
          title: Text(
            widget.qSet.title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: textColor,
              letterSpacing: -0.5,
            ),
          ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(1.0),
            child: Container(
              color: const Color(0xFF4051B5).withValues(alpha: 0.1),
              height: 1.0,
            ),
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.close, color: textColor),
              onPressed: () => _showExitConfirmDialog(context, ref),
            )
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: timerState.status == TimerState.selecting
                  ? _buildSelectingView(context, ref, timerState, isDark)
                  : _buildSolvingView(context, ref, timerState),
            ),
            if (timerState.status == TimerState.selecting)
              _buildFooterAction(context, ref, isDark),
          ],
        ),
      ),
    );
  }

  Widget _buildSelectingView(
      BuildContext context, WidgetRef ref, TimerSessionState state, bool isDark) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Cumulative Selection Time Section
          _buildCumulativeSelectionTime(state.selectingTimeSec, isDark),
          const SizedBox(height: 24),
          
          // Progress Indicators
          _buildProgressIndicators(state, isDark),
          const SizedBox(height: 24),

          // Filters
          _buildFilters(isDark),
          const SizedBox(height: 16),

          // Problem Grid
          _buildProblemGrid(state, isDark),
        ],
      ),
    );
  }

  Widget _buildCumulativeSelectionTime(double totalSeconds, bool isDark) {
    int hours = totalSeconds ~/ 3600;
    int minutes = (totalSeconds % 3600) ~/ 60;
    int seconds = (totalSeconds % 60).toInt();

    final primaryColor = const Color(0xFF4051B5);
    final blockBgColor = isDark
        ? primaryColor.withValues(alpha: 0.2)
        : primaryColor.withValues(alpha: 0.1);

    Widget buildTimeBlock(String value) {
      return Container(
        width: 80,
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: blockBgColor,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Text(
          value,
          style: TextStyle(
            fontSize: 48,
            fontWeight: FontWeight.w900,
            color: primaryColor,
            height: 1.0,
            fontFeatures: const [FontFeature.tabularFigures()],
          ),
        ),
      );
    }

    Widget buildColon() {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Text(
          ':',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: primaryColor.withValues(alpha: 0.3),
          ),
        ),
      );
    }

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 24.0),
          child: Text(
            'CUMULATIVE SELECTION TIME',
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              letterSpacing: 2.0,
              color: primaryColor.withValues(alpha: 0.6),
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            buildTimeBlock(hours.toString().padLeft(2, '0')),
            buildColon(),
            buildTimeBlock(minutes.toString().padLeft(2, '0')),
            buildColon(),
            buildTimeBlock(seconds.toString().padLeft(2, '0')),
          ],
        ),
      ],
    );
  }

  Widget _buildProgressIndicators(TimerSessionState state, bool isDark) {
    final expectedTotalSec = widget.qSet.expectedTotalTime ?? 3600.0; // Default 1 hour if null
    final solvingTime = state.solvingTimeSecByQuestion.values
        .fold(0.0, (sum, val) => sum + val);
    final totalSpentSec = state.selectingTimeSec + solvingTime;
    final remainingSec = (expectedTotalSec - totalSpentSec).clamp(0.0, expectedTotalSec);

    final progressPercent = (totalSpentSec / expectedTotalSec).clamp(0.0, 1.0);

    return Column(
      children: [
        // Progress bar
        Container(
          height: 16,
          width: double.infinity,
          decoration: BoxDecoration(
            color: isDark ? const Color(0xFF1E293B) : const Color(0xFFE2E8F0).withValues(alpha: 0.5),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Stack(
            children: [
              FractionallySizedBox(
                widthFactor: progressPercent,
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFF10B981), // emerald-500
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              if (progressPercent > 0)
                Positioned(
                  left: MediaQuery.of(context).size.width * 0.9 * progressPercent - 16, // approximate pos
                  top: 4,
                  bottom: 4,
                  child: Container(
                    width: 8,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        // Time Cards
        Row(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  color: isDark ? const Color(0xFF1E293B).withValues(alpha: 0.5) : Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: isDark ? const Color(0xFF334155).withValues(alpha: 0.5) : const Color(0xFFF1F5F9),
                    width: 2,
                  ),
                ),
                child: Column(
                  children: [
                    const Text(
                      'TOTAL EST. TIME',
                      style: TextStyle(
                        fontSize: 9,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF94A3B8),
                        letterSpacing: 2.0,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _formatDurationMinutes(expectedTotalSec),
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: isDark ? const Color(0xFFE2E8F0) : const Color(0xFF1E293B),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  color: isDark ? const Color(0xFF1E293B).withValues(alpha: 0.5) : Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: isDark ? const Color(0xFF10B981).withValues(alpha: 0.2) : const Color(0xFF10B981).withValues(alpha: 0.1),
                    width: 2,
                  ),
                ),
                child: Column(
                  children: [
                    const Text(
                      'REMAINING TIME',
                      style: TextStyle(
                        fontSize: 9,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF94A3B8),
                        letterSpacing: 2.0,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _formatDurationMinutes(remainingSec),
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF10B981),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildFilters(bool isDark) {
    List<String> filters = ['All', 'Completed', 'In Progress', 'Unsolved'];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: filters.map((filter) {
          final isSelected = _selectedFilter == filter;

          Color bgColor;
          Color textColor;
          Color borderColor = Colors.transparent;

          if (isSelected) {
            bgColor = const Color(0xFF4051B5); // primary
            textColor = Colors.white;
          } else {
            if (filter == 'Completed') {
              bgColor = isDark ? const Color(0xFF10B981).withValues(alpha: 0.2) : const Color(0xFFECFDF5);
              textColor = isDark ? const Color(0xFF34D399) : const Color(0xFF059669);
              borderColor = isDark ? const Color(0xFF065F46).withValues(alpha: 0.3) : const Color(0xFFD1FAE5);
            } else if (filter == 'In Progress') {
              bgColor = isDark ? const Color(0xFFF59E0B).withValues(alpha: 0.2) : const Color(0xFFFFFBEB);
              textColor = isDark ? const Color(0xFFFBBF24) : const Color(0xFFD97706);
              borderColor = isDark ? const Color(0xFF92400E).withValues(alpha: 0.3) : const Color(0xFFFEF3C7);
            } else {
              bgColor = Colors.transparent;
              textColor = const Color(0xFF94A3B8);
              borderColor = isDark ? const Color(0xFF334155) : const Color(0xFFE2E8F0);
            }
          }

          return Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: InkWell(
              onTap: () {
                setState(() {
                  _selectedFilter = filter;
                });
              },
              borderRadius: BorderRadius.circular(20),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: bgColor,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                      color: isSelected ? Colors.transparent : borderColor,
                      width: isSelected ? 0 : 1.5),
                ),
                child: Text(
                  filter,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildProblemGrid(TimerSessionState state, bool isDark) {
    List<int> visibleQuestions = [];
    for (int i = 1; i <= widget.qSet.questionCount; i++) {
      final isSolved = state.solvedQuestions.contains(i);
      final hasData = (state.solvingTimeSecByQuestion[i] ?? 0.0) > 0;
      
      if (_selectedFilter == 'All') {
        visibleQuestions.add(i);
      } else if (_selectedFilter == 'Completed' && isSolved) {
        visibleQuestions.add(i);
      } else if (_selectedFilter == 'In Progress' && !isSolved && hasData) {
        visibleQuestions.add(i);
      } else if (_selectedFilter == 'Unsolved' && !isSolved && !hasData) {
        visibleQuestions.add(i);
      }
    }

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 1.0,
      ),
      itemCount: visibleQuestions.length,
      itemBuilder: (context, index) {
        final qIdx = visibleQuestions[index];
        final solvedTime = state.solvingTimeSecByQuestion[qIdx] ?? 0.0;
        final isSolved = state.solvedQuestions.contains(qIdx);
        final hasData = solvedTime > 0;

        if (isSolved) {
          // Completed style
          final reviewTime = state.reviewingTimeSecByQuestion[qIdx] ?? 0.0;
          return InkWell(
            onTap: () => ref.read(timerProvider.notifier).selectQuestion(qIdx),
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFF10B981), // emerald-500
                borderRadius: BorderRadius.circular(32),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '$qIdx',
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.timer, color: Colors.white, size: 10),
                      const SizedBox(width: 4),
                      Text(
                        '풀이: ${_formatDurationMinSec(solvedTime)}',
                        style: const TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  if (reviewTime > 0) ...[
                    const SizedBox(height: 2),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.fact_check, color: Colors.white, size: 10),
                        const SizedBox(width: 4),
                        Text(
                          '검토: ${_formatDurationMinSec(reviewTime)}',
                          style: const TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          );
        } else if (hasData) {
          // In Progress style
          return InkWell(
            onTap: () => ref.read(timerProvider.notifier).selectQuestion(qIdx),
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFFFBBF24), // amber-400
                borderRadius: BorderRadius.circular(32),
                border: Border.all(
                  color: const Color(0xFFD97706).withValues(alpha: 0.3), // amber-600
                  width: 2,
                ),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFFFBBF24).withValues(alpha: 0.2),
                    blurRadius: 8,
                    spreadRadius: 2,
                  )
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '$qIdx',
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFF451A03), // amber-950
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'IN PROGRESS',
                    style: TextStyle(
                      fontSize: 8,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                      color: Color(0xFF78350F), // amber-900
                    ),
                  ),
                  const SizedBox(height: 2),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.timer, color: Color(0xFF78350F), size: 10),
                      const SizedBox(width: 4),
                      Text(
                        _formatDurationMinSec(solvedTime),
                        style: const TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF451A03),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        } else {
          // Unsolved style
          return InkWell(
            onTap: () => ref.read(timerProvider.notifier).selectQuestion(qIdx),
            child: Container(
              decoration: BoxDecoration(
                color: isDark ? const Color(0xFF1E293B) : Colors.white,
                borderRadius: BorderRadius.circular(32),
                border: Border.all(
                  color: isDark ? const Color(0xFF334155) : const Color(0xFFF1F5F9),
                  width: 2,
                ),
              ),
              child: Center(
                child: Text(
                  '$qIdx',
                  style: TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.w900,
                    color: isDark ? const Color(0xFF475569) : const Color(0xFFCBD5E1),
                  ),
                ),
              ),
            ),
          );
        }
      },
    );
  }

  Widget _buildFooterAction(BuildContext context, WidgetRef ref, bool isDark) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF0F172A) : Colors.white,
        border: Border(
          top: BorderSide(
            color: const Color(0xFF4051B5).withValues(alpha: 0.1),
          ),
        ),
      ),
      child: SafeArea(
        top: false,
        child: FilledButton.icon(
          onPressed: () => _showExitConfirmDialog(context, ref),
          icon: const Icon(Icons.stop_circle, size: 20),
          label: const Text(
            'Finish',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          style: FilledButton.styleFrom(
            backgroundColor: const Color(0xFF4051B5),
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 20),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            minimumSize: const Size.fromHeight(60),
          ),
        ),
      ),
    );
  }

  Widget _buildSolvingView(
      BuildContext context, WidgetRef ref, TimerSessionState state) {
    final currentQ = state.currentQuestionIndex ?? 1;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    final isReviewing = state.status == TimerState.reviewing;
    final timeSec = isReviewing 
        ? (state.reviewingTimeSecByQuestion[currentQ] ?? 0.0) 
        : (state.solvingTimeSecByQuestion[currentQ] ?? 0.0);

    int hours = timeSec ~/ 3600;
    int minutes = (timeSec % 3600) ~/ 60;
    int seconds = (timeSec % 60).toInt();

    final Color primaryColor = const Color(0xFF8B5CF6); // violet-500
    final events = state.timelineByQuestion[currentQ] ?? [];

    final blockBgColor = isDark
        ? primaryColor.withValues(alpha: 0.2)
        : primaryColor.withValues(alpha: 0.05);

    Widget buildTimeBlock(String value, String label) {
      return Column(
        children: [
          Container(
            height: 80,
            width: 80,
            decoration: BoxDecoration(
              color: blockBgColor,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                  color: primaryColor.withValues(alpha: 0.2), width: 2),
            ),
            child: Center(
              child: Text(
                value,
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label.toUpperCase(),
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w500,
              letterSpacing: -0.5,
              color: isDark ? const Color(0xFF94A3B8) : const Color(0xFF64748B),
            ),
          ),
        ],
      );
    }

    Widget buildColon() {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 24.0),
          child: Text(
            ':',
            style: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
        ),
      );
    }

    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Problem Indicator
                Text(
                  isReviewing ? 'REVIEWING SESSION' : 'ONGOING SESSION',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 2.0,
                    color: isReviewing ? const Color(0xFFF59E0B) : primaryColor,
                  ),
                ),
          const SizedBox(height: 8),
          Text(
            'Current Problem: $currentQ',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w800,
              height: 1.2,
              color: isDark ? const Color(0xFFF1F5F9) : const Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 32),

          // Timer Component
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(32),
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF0F172A) : Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                  color: primaryColor.withValues(alpha: 0.1), width: 1),
              boxShadow: [
                BoxShadow(
                  color: primaryColor.withValues(alpha: 0.05),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                )
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                buildTimeBlock(hours.toString().padLeft(2, '0'), 'Hours'),
                buildColon(),
                buildTimeBlock(minutes.toString().padLeft(2, '0'), 'Minutes'),
                buildColon(),
                buildTimeBlock(seconds.toString().padLeft(2, '0'), 'Seconds'),
              ],
            ),
          ),

          const SizedBox(height: 32),

          // Progress Bar (Mock)
          Container(
            height: 16,
            width: double.infinity,
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF1E293B) : const Color(0xFFE2E8F0),
              borderRadius: BorderRadius.circular(8),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: 0.65, // Mock value
              child: Container(
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'PROGRESS',
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.0,
                  color: const Color(0xFF94A3B8),
                ),
              ),
              Text(
                'ESTIMATED TIME (MIN)',
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.0,
                  color: const Color(0xFF94A3B8),
                ),
              ),
            ],
          ),
            const SizedBox(height: 32),
          
          if (events.isNotEmpty)
            _buildTimeline(events, isDark),
              ],
            ),
          ),
        ),
        // Footer (Navigation & Solved)
        Container(
          padding: const EdgeInsets.all(24.0),
          decoration: BoxDecoration(
            color: isDark ? const Color(0xFF0F172A) : Colors.white,
            border: Border(
              top: BorderSide(
                color: primaryColor.withValues(alpha: 0.1),
              ),
            ),
          ),
          child: SafeArea(
            top: false,
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: _buildNavButton(
                        icon: Icons.chevron_left,
                        label: 'PREVIOUS',
                        isDark: isDark,
                        onTap: currentQ > 1
                            ? () => ref
                                .read(timerProvider.notifier)
                                .selectQuestion(currentQ - 1)
                            : null,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _buildNavButton(
                        icon: Icons.grid_view,
                        label: 'OTHER',
                        isDark: isDark,
                        onTap: () =>
                            ref.read(timerProvider.notifier).pauseToSelect(),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _buildNavButton(
                        icon: Icons.chevron_right,
                        label: 'NEXT',
                        isDark: isDark,
                        onTap: currentQ < widget.qSet.questionCount
                            ? () => ref
                                .read(timerProvider.notifier)
                                .selectQuestion(currentQ + 1)
                            : null,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                FilledButton(
                  style: FilledButton.styleFrom(
                    backgroundColor: isReviewing ? const Color(0xFFF59E0B) : primaryColor,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    minimumSize: const Size.fromHeight(64),
                  ),
                  onPressed: () {
                    if (isReviewing) {
                      ref.read(timerProvider.notifier).finishReview(currentQ);
                    } else {
                      ref.read(timerProvider.notifier).markAsSolved(currentQ);
                    }
                  },
                  child: Text(isReviewing ? '검토 완료' : 'Solved',
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTimeline(List<QuestionEvent> events, bool isDark) {
    List<Widget> timelineItems = [];
    int reviewCount = 0;

    for (int i = 0; i < events.length; i++) {
      final event = events[i];
      if (event.type == QuestionEventType.reviewStart) {
        reviewCount++;
      }

      final isLast = i == events.length - 1;
      Duration? duration;
      if (!isLast) {
        duration = events[i + 1].timestamp.difference(event.timestamp);
      }

      timelineItems.add(
        IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Column(
                children: [
                  Container(
                    width: 12,
                    height: 12,
                    margin: const EdgeInsets.only(top: 4),
                    decoration: BoxDecoration(
                      color: _getEventColor(event.type),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: isDark ? const Color(0xFF0F172A) : Colors.white,
                        width: 2,
                      ),
                    ),
                  ),
                  if (!isLast)
                    Expanded(
                      child: Container(
                        width: 2,
                        color: isDark ? const Color(0xFF334155) : const Color(0xFFE2E8F0),
                      ),
                    ),
                ],
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(bottom: isLast ? 24.0 : 0.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _getEventLabel(event.type, reviewCount),
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: isDark ? Colors.white : const Color(0xFF1E293B),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        _formatEventTime(event.timestamp),
                        style: TextStyle(
                          fontSize: 14,
                          color: isDark ? const Color(0xFF94A3B8) : const Color(0xFF64748B),
                        ),
                      ),
                      if (!isLast && duration != null) ...[
                        const SizedBox(height: 12),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                          decoration: BoxDecoration(
                            color: isDark ? const Color(0xFF1E293B) : const Color(0xFFF1F5F9),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.timer_outlined, 
                                  size: 14, 
                                  color: isDark ? const Color(0xFF94A3B8) : const Color(0xFF64748B)),
                              const SizedBox(width: 6),
                              Text(
                                _formatDurationBetween(duration),
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: isDark ? const Color(0xFF94A3B8) : const Color(0xFF64748B),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),
                      ],
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: Text(
            'Timeline',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: isDark ? const Color(0xFF94A3B8) : const Color(0xFF64748B),
            ),
          ),
        ),
        ...timelineItems,
      ],
    );
  }

  String _formatDurationBetween(Duration d) {
    final minutes = d.inMinutes;
    final seconds = d.inSeconds % 60;
    if (minutes > 0) {
      return '$minutes분 $seconds초';
    }
    return '$seconds초';
  }

  String _getEventLabel(QuestionEventType type, int reviewCount) {
    switch (type) {
      case QuestionEventType.start:
        return '문제 풀이 시작';
      case QuestionEventType.pause:
        return '문제 풀이 중단';
      case QuestionEventType.solved:
        return '문제 풀이 완료';
      case QuestionEventType.reviewStart:
        return '$reviewCount차 검토 시작';
      case QuestionEventType.reviewPause:
        return '$reviewCount차 검토 중단';
      case QuestionEventType.reviewEnd:
        return '$reviewCount차 검토 완료';
    }
  }

  Color _getEventColor(QuestionEventType type) {
    switch (type) {
      case QuestionEventType.start:
        return const Color(0xFF8B5CF6); // violet-500
      case QuestionEventType.pause:
        return const Color(0xFFEF4444); // red-500
      case QuestionEventType.solved:
        return const Color(0xFF10B981); // emerald-500
      case QuestionEventType.reviewStart:
        return const Color(0xFFF59E0B); // amber-500
      case QuestionEventType.reviewPause:
        return const Color(0xFFF97316); // orange-500
      case QuestionEventType.reviewEnd:
        return const Color(0xFF3B82F6); // blue-500
    }
  }

  String _formatEventTime(DateTime time) {
    final hour = time.hour.toString().padLeft(2, '0');
    final min = time.minute.toString().padLeft(2, '0');
    final sec = time.second.toString().padLeft(2, '0');
    return '$hour:$min:$sec';
  }

  Widget _buildNavButton({
    required IconData icon,
    required String label,
    required bool isDark,
    required VoidCallback? onTap,
  }) {
    final textColor = isDark ? const Color(0xFFCBD5E1) : const Color(0xFF334155);
    final disabledColor = isDark ? const Color(0xFF475569) : const Color(0xFF94A3B8);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF0F172A) : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: const Color(0xFF4051B5).withValues(alpha: 0.1),
            width: 1,
          ),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              size: 24,
              color: onTap == null ? disabledColor : textColor,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.bold,
                color: onTap == null ? disabledColor : textColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatDurationMinutes(double totalSeconds) {
    int minutes = totalSeconds ~/ 60;
    int seconds = (totalSeconds % 60).toInt();
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  String _formatDurationMinSec(double totalSeconds) {
    int minutes = totalSeconds ~/ 60;
    int seconds = (totalSeconds % 60).toInt();
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  void _showExitConfirmDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('종료하시겠습니까?'),
        content: const Text('현재까지의 기록이 저장되고 결과 분석 화면으로 이동합니다.'),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(ctx), child: const Text('취소')),
          FilledButton(
            onPressed: () {
              Navigator.pop(ctx); // 다이얼로그 닫기
              ref.read(timerProvider.notifier).finishSession();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const SessionSummaryView()),
              );
            },
            child: const Text('종료 및 저장'),
          ),
        ],
      ),
    );
  }
}

