import 'package:isar/isar.dart';
import 'question_set.dart';
import 'question_result.dart';

part 'session.g.dart';

@collection
class Session {
  Id id = Isar.autoIncrement;

  @Index()
  final questionSet = IsarLink<QuestionSet>();

  late DateTime dateStarted;
  DateTime? dateFinished;

  /// 문제 고르기에 소요된 누적 총 시간 (초 단위 등)
  double totalSelectionTime = 0.0;

  @Backlink(to: 'session')
  final questionResults = IsarLinks<QuestionResult>();
}
