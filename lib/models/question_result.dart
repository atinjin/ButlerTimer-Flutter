import 'package:isar/isar.dart';
import 'session.dart';

part 'question_result.g.dart';

@collection
class QuestionResult {
  Id id = Isar.autoIncrement;

  @Index()
  final session = IsarLink<Session>();

  late int questionIndex;

  /// 이 문제를 푸는 데 누적된 시간 (초 단위 등)
  double totalSolvingTime = 0.0;

  /// 정답 여부 (null: 채점 전, true: 정답, false: 오답)
  bool? isCorrect;
}
