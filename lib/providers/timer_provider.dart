import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:async';
import '../models/question_set.dart';
import '../models/session.dart';

enum TimerState { idle, selecting, solving, reviewing }

enum QuestionEventType { start, pause, solved, reviewStart, reviewPause, reviewEnd }

class QuestionEvent {
  final QuestionEventType type;
  final DateTime timestamp;

  QuestionEvent(this.type, this.timestamp);
}

class TimerSessionState {
  final QuestionSet? currentSet;
  final Session? currentSession;
  final TimerState status;
  final int? currentQuestionIndex;

  // 상태별 누적 시간 (초)
  final double selectingTimeSec;
  final Map<int, double> solvingTimeSecByQuestion;

  final Set<int> solvedQuestions;
  final Map<int, double> reviewingTimeSecByQuestion;
  final Map<int, List<QuestionEvent>> timelineByQuestion;

  TimerSessionState({
    this.currentSet,
    this.currentSession,
    this.status = TimerState.idle,
    this.currentQuestionIndex,
    this.selectingTimeSec = 0.0,
    Map<int, double>? solvingTimeSecByQuestion,
    Set<int>? solvedQuestions,
    Map<int, double>? reviewingTimeSecByQuestion,
    Map<int, List<QuestionEvent>>? timelineByQuestion,
  })  : solvingTimeSecByQuestion = solvingTimeSecByQuestion ?? {},
        solvedQuestions = solvedQuestions ?? {},
        reviewingTimeSecByQuestion = reviewingTimeSecByQuestion ?? {},
        timelineByQuestion = timelineByQuestion ?? {};

  TimerSessionState copyWith({
    QuestionSet? currentSet,
    Session? currentSession,
    TimerState? status,
    int? currentQuestionIndex,
    bool clearQuestionIndex = false,
    double? selectingTimeSec,
    Map<int, double>? solvingTimeSecByQuestion,
    Set<int>? solvedQuestions,
    Map<int, double>? reviewingTimeSecByQuestion,
    Map<int, List<QuestionEvent>>? timelineByQuestion,
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
      solvedQuestions: solvedQuestions ?? Set.from(this.solvedQuestions),
      reviewingTimeSecByQuestion: reviewingTimeSecByQuestion ??
          Map.from(this.reviewingTimeSecByQuestion),
      timelineByQuestion: timelineByQuestion ??
          Map.from(this.timelineByQuestion.map(
              (key, value) => MapEntry(key, List<QuestionEvent>.from(value)))),
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
      solvedQuestions: {},
      reviewingTimeSecByQuestion: {},
      timelineByQuestion: {},
    );
    _startTicker();
  }

  void _addEvent(int qIdx, QuestionEventType type) {
    final timeline = Map<int, List<QuestionEvent>>.from(state.timelineByQuestion.map(
        (key, value) => MapEntry(key, List<QuestionEvent>.from(value))));
    timeline[qIdx] = (timeline[qIdx] ?? [])..add(QuestionEvent(type, DateTime.now()));
    state = state.copyWith(timelineByQuestion: timeline);
  }

  void selectQuestion(int index) {
    if (state.status != TimerState.idle) {
      // 만약 다른 문제를 풀고 있었다면 pause 처리 우선
      if (state.status == TimerState.solving || state.status == TimerState.reviewing) {
        pauseToSelect();
      }

      final isSolved = state.solvedQuestions.contains(index);
      state = state.copyWith(
        status: isSolved ? TimerState.reviewing : TimerState.solving,
        currentQuestionIndex: index,
      );
      
      _addEvent(index, isSolved ? QuestionEventType.reviewStart : QuestionEventType.start);
    }
  }

  void markAsSolved(int index) {
    final newSolved = Set<int>.from(state.solvedQuestions)..add(index);
    state = state.copyWith(solvedQuestions: newSolved);
    _addEvent(index, QuestionEventType.solved);
    
    // pauseToSelect 내부 로직 직접 실행 (이벤트 중복 방지 위해)
    state = state.copyWith(
      status: TimerState.selecting,
      clearQuestionIndex: true,
    );
  }

  void finishReview(int index) {
    _addEvent(index, QuestionEventType.reviewEnd);
    
    state = state.copyWith(
      status: TimerState.selecting,
      clearQuestionIndex: true,
    );
  }

  void pauseToSelect() {
    if (state.status == TimerState.solving || state.status == TimerState.reviewing) {
      if (state.currentQuestionIndex != null) {
        if (state.status == TimerState.solving) {
          _addEvent(state.currentQuestionIndex!, QuestionEventType.pause);
        } else {
          _addEvent(state.currentQuestionIndex!, QuestionEventType.reviewPause);
        }
      }
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
      } else if ((state.status == TimerState.solving || state.status == TimerState.reviewing) &&
          state.currentQuestionIndex != null) {
        final qIdx = state.currentQuestionIndex!;
        if (state.status == TimerState.solving) {
          final currentMap =
              Map<int, double>.from(state.solvingTimeSecByQuestion);
          currentMap[qIdx] = (currentMap[qIdx] ?? 0.0) + _tickInterval;
          state = state.copyWith(solvingTimeSecByQuestion: currentMap);
        } else {
          final currentMap =
              Map<int, double>.from(state.reviewingTimeSecByQuestion);
          currentMap[qIdx] = (currentMap[qIdx] ?? 0.0) + _tickInterval;
          state = state.copyWith(reviewingTimeSecByQuestion: currentMap);
        }
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
