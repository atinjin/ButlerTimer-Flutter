import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/question_set_provider.dart';
import '../../models/question_set.dart';

class CreateSetView extends ConsumerStatefulWidget {
  const CreateSetView({super.key});

  @override
  ConsumerState<CreateSetView> createState() => _CreateSetViewState();
}

class _CreateSetViewState extends ConsumerState<CreateSetView> {
  final _formKey = GlobalKey<FormState>();
  String _title = '';
  int _questionCount = 10;
  int _expectedMin = 0;

  void _saveSet() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      
      final newSet = QuestionSet()
        ..title = _title
        ..questionCount = _questionCount
        ..expectedTotalTime = _expectedMin > 0 ? (_expectedMin * 60).toDouble() : null;

      ref.read(questionSetProvider.notifier).addSet(newSet);
      if (mounted) Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('새로운 세트 추가'),
        actions: [
          TextButton(
            onPressed: _saveSet,
            child: const Text('저장', style: TextStyle(fontWeight: FontWeight.bold)),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('세트 이름', style: Theme.of(context).textTheme.titleSmall),
              const SizedBox(height: 8),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'ex. 국어 모의평가',
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                    value == null || value.isEmpty ? '이름을 입력하세요.' : null,
                onSaved: (value) => _title = value ?? '',
              ),
              const SizedBox(height: 24),
              
              Text('문제 개수', style: Theme.of(context).textTheme.titleSmall),
              Row(
                children: [
                   IconButton(
                    icon: const Icon(Icons.remove_circle_outline),
                    onPressed: () {
                      if (_questionCount > 1) {
                         setState(() => _questionCount--);
                      }
                    },
                   ),
                   Expanded(
                     child: Text(
                       '$_questionCount 개', 
                       textAlign: TextAlign.center, 
                       style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)
                     ),
                   ),
                   IconButton(
                    icon: const Icon(Icons.add_circle_outline),
                    onPressed: () {
                      setState(() => _questionCount++);
                    },
                   ),
                ],
              ),
              const SizedBox(height: 24),
              
              Text('전체 예상 시간 (선택)', style: Theme.of(context).textTheme.titleSmall),
              const SizedBox(height: 8),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText: '분 단위 입력 (예: 80)',
                  border: OutlineInputBorder(),
                  suffixText: '분'
                ),
                onSaved: (value) {
                  if (value != null && value.isNotEmpty) {
                    _expectedMin = int.tryParse(value) ?? 0;
                  }
                },
              ),
              
              const SizedBox(height: 48),
              SizedBox(
                width: double.infinity,
                height: 54,
                child: FilledButton(
                  onPressed: _saveSet,
                  child: const Text('세트 생성하기', style: TextStyle(fontSize: 18)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
