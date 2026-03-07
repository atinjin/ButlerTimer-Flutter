import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import '../models/question_set.dart';
import '../main.dart'; // isarProvider 가져오기

class QuestionSetNotifier extends StateNotifier<AsyncValue<List<QuestionSet>>> {
  final Isar isar;

  QuestionSetNotifier(this.isar) : super(const AsyncValue.loading()) {
    _loadSets();
  }

  Future<void> _loadSets() async {
    try {
      final sets = await isar.questionSets.where().findAll();
      state = AsyncValue.data(sets);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> addSet(QuestionSet newSet) async {
    try {
      await isar.writeTxn(() async {
        await isar.questionSets.put(newSet);
      });
      _loadSets();
    } catch (e, st) {
      // 오류 발생 시 기존 상태 유지 방식, 실제 상용에선 별도 핸들링
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> deleteSet(int id) async {
    try {
      await isar.writeTxn(() async {
        await isar.questionSets.delete(id);
      });
      _loadSets();
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}

final questionSetProvider =
    StateNotifierProvider<QuestionSetNotifier, AsyncValue<List<QuestionSet>>>(
        (ref) {
  final isar = ref.watch(isarProvider);
  return QuestionSetNotifier(isar);
});
