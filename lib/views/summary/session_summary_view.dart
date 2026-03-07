import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/timer_provider.dart';

class SessionSummaryView extends ConsumerWidget {
  const SessionSummaryView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(timerProvider);
    final qSet = state.currentSet;
    
    if (qSet == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('결과 분석 에러')),
        body: const Center(child: Text('진행된 세션 정보가 없습니다.')),
      );
    }

    final double totalSolvingSec = state.solvingTimeSecByQuestion.values.fold(0, (a, b) => a + b);
    final double totalSelectionSec = state.selectingTimeSec;
    final double totalSec = totalSolvingSec + totalSelectionSec;

    return Scaffold(
      appBar: AppBar(
        title: const Text('결과 분석'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              '${qSet.title} (${DateTime.now().toString().substring(0, 16)})',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.grey),
            ),
            const SizedBox(height: 24),

            _buildSummaryBox(context, totalSec, totalSolvingSec, totalSelectionSec),
            
            const SizedBox(height: 24),
            const Divider(),
            const SizedBox(height: 16),
            
            Text('문항별 기록 및 오답 채점', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 16),
            
            _buildResultList(context, state),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryBox(BuildContext context, double total, double solving, double selection) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceVariant,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('[ 종합 기록 ]', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Text('총 소모 시간: ${_formatDuration(total)}', style: const TextStyle(fontSize: 16)),
          Text('- 순수 풀이 시간: ${_formatDuration(solving)}', style: const TextStyle(fontSize: 16)),
          Text('- 문제 선택 시간: ${_formatDuration(selection)}', style: const TextStyle(fontSize: 16)),
        ],
      ),
    );
  }

  Widget _buildResultList(BuildContext context, TimerSessionState state) {
    final count = state.currentSet?.questionCount ?? 0;
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: count,
      separatorBuilder: (_, __) => const Divider(height: 1),
      itemBuilder: (context, index) {
        final qIdx = index + 1;
        final timeSec = state.solvingTimeSecByQuestion[qIdx] ?? 0.0;
        final hasSkipped = timeSec == 0;

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            children: [
              SizedBox(width: 40, child: Text('$qIdx번', style: const TextStyle(fontWeight: FontWeight.bold))),
              Expanded(
                child: Text(
                  hasSkipped ? '건너뜀' : _formatDuration(timeSec),
                  style: TextStyle(
                    color: hasSkipped ? Colors.grey : (timeSec > 300 ? Colors.red : null),
                    fontWeight: timeSec > 300 ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              ),
              
              // 채점 버튼 (간단한 SegmentedButton 또는 Row 내 O/X 버튼)
              _OXToggles(qIndex: qIdx),
            ],
          ),
        );
      },
    );
  }

  String _formatDuration(double totalSeconds) {
    int minutes = totalSeconds ~/ 60;
    int seconds = (totalSeconds % 60).toInt();
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }
}

class _OXToggles extends StatefulWidget {
  final int qIndex;
  const _OXToggles({required this.qIndex});

  @override
  State<_OXToggles> createState() => _OXTogglesState();
}

class _OXTogglesState extends State<_OXToggles> {
  bool? isCorrect;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          icon: Icon(Icons.circle_outlined, color: isCorrect == true ? Colors.green : Colors.grey),
          onPressed: () => setState(() => isCorrect = true),
        ),
        IconButton(
          icon: Icon(Icons.close, color: isCorrect == false ? Colors.red : Colors.grey),
          onPressed: () => setState(() => isCorrect = false),
        ),
      ],
    );
  }
}
