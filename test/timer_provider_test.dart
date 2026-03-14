import 'package:flutter_test/flutter_test.dart';
import 'package:butler_timer/providers/timer_provider.dart';
import 'package:butler_timer/models/question_set.dart';

void main() {
  group('TimerNotifier State Machine Tests', () {
    test('Session starts in selecting state with initial values', () {
      final notifier = TimerNotifier();
      final qSet = QuestionSet()
        ..title = 'Math'
        ..questionCount = 3;

      notifier.startSession(qSet);

      expect(notifier.state.status, TimerState.selecting);
      expect(notifier.state.currentSet?.title, 'Math');
      expect(notifier.state.selectingTimeSec, 0.0);
      expect(notifier.state.solvingTimeSecByQuestion.isEmpty, true);

      notifier.finishSession();
      notifier.dispose();
    });

    test('Transitions to solving state when a question is selected', () {
      final notifier = TimerNotifier();
      final qSet = QuestionSet()..questionCount = 5;

      notifier.startSession(qSet);
      notifier.selectQuestion(1);

      expect(notifier.state.status, TimerState.solving);
      expect(notifier.state.currentQuestionIndex, 1);

      notifier.finishSession();
      notifier.dispose();
    });

    test('Pausing returns to selecting state', () {
      final notifier = TimerNotifier();
      final qSet = QuestionSet()..questionCount = 5;

      notifier.startSession(qSet);
      notifier.selectQuestion(1);

      expect(notifier.state.status, TimerState.solving);

      notifier.pauseToSelect();

      expect(notifier.state.status, TimerState.selecting);
      expect(notifier.state.currentQuestionIndex, isNull);

      notifier.finishSession();
      notifier.dispose();
    });
  });
}
