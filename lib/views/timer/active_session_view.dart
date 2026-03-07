import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/timer_provider.dart';
import '../../models/question_set.dart';
import '../summary/session_summary_view.dart';

class ActiveSessionView extends ConsumerWidget {
  final QuestionSet qSet;

  const ActiveSessionView({super.key, required this.qSet});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final timerState = ref.watch(timerProvider);

    return WillPopScope(
      onWillPop: () async {
        _showExitConfirmDialog(context, ref);
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(qSet.title),
          actions: [
            IconButton(
              icon: const Icon(Icons.close),
              onPressed: () => _showExitConfirmDialog(context, ref),
            )
          ],
        ),
        body: timerState.status == TimerState.selecting
            ? _buildSelectingView(context, ref, timerState)
            : _buildSolvingView(context, ref, timerState),
      ),
    );
  }

  Widget _buildSelectingView(
      BuildContext context, WidgetRef ref, TimerSessionState state) {
    return Column(
      children: [
        const SizedBox(height: 20),
        const Text('고민 / 문제 이동 누적 시간',
            style: TextStyle(fontSize: 18, color: Colors.grey)),
        Text(
          _formatDuration(state.selectingTimeSec),
          style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 20),
        const Divider(),
        Expanded(
          child: GridView.builder(
            padding: const EdgeInsets.all(16),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 1.0,
            ),
            itemCount: qSet.questionCount,
            itemBuilder: (context, index) {
              final qIdx = index + 1;
              final solvedTime = state.solvingTimeSecByQuestion[qIdx] ?? 0.0;
              final hasData = solvedTime > 0;

              // TODO: 색상 로직 구체화 필요 (보류 중이면 yellow, 완전 완료면 green 등)
              final color = hasData
                  ? Colors.yellow.shade200
                  : Theme.of(context).colorScheme.surfaceContainerHighest;

              return InkWell(
                onTap: () =>
                    ref.read(timerProvider.notifier).selectQuestion(qIdx),
                borderRadius: BorderRadius.circular(16),
                child: Container(
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('$qIdx번',
                          style: const TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold)),
                      if (hasData)
                        Text(_formatDuration(solvedTime),
                            style: const TextStyle(color: Colors.black54)),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildSolvingView(
      BuildContext context, WidgetRef ref, TimerSessionState state) {
    final currentQ = state.currentQuestionIndex ?? 1;
    final timeSec = state.solvingTimeSecByQuestion[currentQ] ?? 0.0;

    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 40),
          Text('현재 문제: $currentQ 번',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 24, color: Colors.grey)),
          const SizedBox(height: 20),
          Text(
            _formatDuration(timeSec),
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 64, fontWeight: FontWeight.w900),
          ),
          const Spacer(),
          SizedBox(
            height: 120,
            child: FilledButton(
              style: FilledButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24))),
              onPressed: () {
                // TODO: 완전 완료 로직
                ref.read(timerProvider.notifier).pauseToSelect();
              },
              child: const Text('문제 풀이 완료',
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
            ),
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              OutlinedButton(
                onPressed: currentQ > 1
                    ? () => ref
                        .read(timerProvider.notifier)
                        .selectQuestion(currentQ - 1)
                    : null,
                child: const Text('이전 문제'),
              ),
              OutlinedButton(
                onPressed: () =>
                    ref.read(timerProvider.notifier).pauseToSelect(),
                child: const Text('다른 문제 고르기'),
              ),
              OutlinedButton(
                onPressed: currentQ < qSet.questionCount
                    ? () => ref
                        .read(timerProvider.notifier)
                        .selectQuestion(currentQ + 1)
                    : null,
                child: const Text('다음 문제'),
              ),
            ],
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  String _formatDuration(double totalSeconds) {
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
