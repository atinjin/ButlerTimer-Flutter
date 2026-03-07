import 'package:isar/isar.dart';
import 'session.dart';

part 'question_set.g.dart';

@collection
class QuestionSet {
  Id id = Isar.autoIncrement;

  late String title;
  
  late int questionCount;

  /// 전체 예상 소요 시간 (초 단위 등)
  double? expectedTotalTime;

  /// 문제별 개별 디테일 데이터 리스트
  List<QuestionMetadata>? questionMetadatas;

  @Backlink(to: 'questionSet')
  final sessions = IsarLinks<Session>();
}

@embedded
class QuestionMetadata {
  int? index;
  double? expectedTime;
  String? difficulty;
  String? questionType;

  // Isar embedded 모델은 List<String> 형태만 자체 지원하므로 Key-Value 형태는 별도 인코딩하거나 리스트로 관리.
  // 여기서는 단순히 자유 기술 텍스트들을 리스트로 담아두는 형태로 변경합니다.
  List<String>? extraData; 
}
