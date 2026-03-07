import 'package:flutter/material.dart';

class ComparisonView extends StatelessWidget {
  const ComparisonView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('기록 비교 (준비 중)'),
      ),
      body: const Center(
        child: Text('추후 동일 문제 세트의 다회차 풀이 기록 비교표 구현 영역'),
      ),
    );
  }
}
