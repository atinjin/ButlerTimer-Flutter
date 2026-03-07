import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/question_set_provider.dart';
import '../../providers/timer_provider.dart';
import '../timer/active_session_view.dart';
import 'create_set_view.dart';

class QuestionSetListView extends ConsumerWidget {
  const QuestionSetListView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final setListState = ref.watch(questionSetProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('문제 세트'),
      ),
      body: setListState.when(
        data: (sets) {
          if (sets.isEmpty) {
            return const Center(child: Text('새로운 문제 세트를 추가해보세요!'));
          }

          return ListView.builder(
            itemCount: sets.length,
            itemBuilder: (context, index) {
              final qSet = sets[index];
              return Dismissible(
                key: Key(qSet.id.toString()),
                direction: DismissDirection.endToStart,
                background: Container(
                  color: Colors.red,
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.only(right: 20),
                  child: const Icon(Icons.delete, color: Colors.white),
                ),
                onDismissed: (direction) {
                  ref.read(questionSetProvider.notifier).deleteSet(qSet.id);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('${qSet.title} 삭제됨')),
                  );
                },
                child: ListTile(
                  title: Text(qSet.title),
                  subtitle: Text('총 ${qSet.questionCount}문제'),
                  trailing: IconButton(
                    icon: const Icon(Icons.play_circle_fill, size: 36, color: Colors.deepPurple),
                    onPressed: () {
                      ref.read(timerProvider.notifier).startSession(qSet);
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => ActiveSessionView(qSet: qSet)),
                      );
                    },
                  ),
                  onTap: () {
                    // TODO: 세트 수정 또는 세부 내용 확인
                  },
                ),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const CreateSetView()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
