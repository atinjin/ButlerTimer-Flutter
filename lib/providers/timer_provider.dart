import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:async';
import '../models/question_set.dart';
import '../models/session.dart';

enum TimerState { idle, selecting, solving }

class TimerSessionState {
  final QuestionSet? currentSet;
  final Session? currentSession;
  final TimerState status;
  final int? currentQuestionIndex;

  // 상태별 누적 시간 (초)
  final double selectingTimeSec;
  final Map<int, double> solvingTimeSecByQuestion;

  TimerSessionState({
    this.currentSet,
    this.currentSession,
    this.status = TimerState.idle,
    this.currentQuestionIndex,
    this.selectingTimeSec = 0.0,
    Map<int, double>? solvingTimeSecByQuestion,
  }) : solvingTimeSecByQuestion = solvingTimeSecByQuestion ?? {};

  TimerSessionState copyWith({
    QuestionSet? currentSet,
    Session? currentSession,
    TimerState? status,
    int? currentQuestionIndex,
    bool clearQuestionIndex = false,
    double? selectingTimeSec,
    Map<int, double>? solvingTimeSecByQuestion,
  }) {
    return TimerSessionState(
      currentSet: currentSet ?? this.currentSet,
      currentSession: currentSession ?? this.currentSession,
      status: status ?? this.status,
      currentQuestionIndex: clearQuestionIndex
          ? null
          : (currentQuestionIndex ?? this.currentQuestionIndex),
      selectingTimeSec: selectingTimeSec ?? this.selectingTimeSec,
      solvingTimeSecByQuestion:
          solvingTimeSecByQuestion ?? Map.from(this.solvingTimeSecByQuestion),
    );
  }
}

class TimerNotifier extends StateNotifier<TimerSessionState> {
  TimerNotifier() : super(TimerSessionState());

  Timer? _ticker;
  final double _tickInterval = 0.1; // 100ms

  void startSession(QuestionSet qSet) {
    // Session 초기화 로직 등
    state = state.copyWith(
      currentSet: qSet,
      status: TimerState.selecting,
      selectingTimeSec: 0.0,
      solvingTimeSecByQuestion: {},
    );
    _startTicker();
  }

  void selectQuestion(int index) {
    if (state.status != TimerState.idle) {
      state = state.copyWith(
        status: TimerState.solving,
        currentQuestionIndex: index,
      );
    }
  }

  void pauseToSelect() {
    if (state.status == TimerState.solving) {
      state = state.copyWith(
        status: TimerState.selecting,
        clearQuestionIndex: true,
      );
    }
  }

  void finishSession() {
    _ticker?.cancel();
    state = state.copyWith(status: TimerState.idle);
  }

  void _startTicker() {
    _ticker?.cancel();
    _ticker = Timer.periodic(
        Duration(milliseconds: (_tickInterval * 1000).toInt()), (timer) {
      if (state.status == TimerState.selecting) {
        state = state.copyWith(
          selectingTimeSec: state.selectingTimeSec + _tickInterval,
        );
      } else if (state.status == TimerState.solving &&
          state.currentQuestionIndex != null) {
        final currentMap =
            Map<int, double>.from(state.solvingTimeSecByQuestion);
        final qIdx = state.currentQuestionIndex!;
        currentMap[qIdx] = (currentMap[qIdx] ?? 0.0) + _tickInterval;

        state = state.copyWith(solvingTimeSecByQuestion: currentMap);
      }
    });
  }

  @override
  void dispose() {
    _ticker?.cancel();
    super.dispose();
  }
}

final timerProvider =
    StateNotifierProvider<TimerNotifier, TimerSessionState>((ref) {
  return TimerNotifier();
});
