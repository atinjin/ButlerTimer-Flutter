import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

import 'models/question_set.dart';
import 'models/session.dart';
import 'models/question_result.dart';
import 'views/main_tab_view.dart';

// 전역 Isar 인스턴스 Provider 선언
final isarProvider = Provider<Isar>((ref) {
  throw UnimplementedError('Isar is not initialized');
});

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Isar 데이터베이스 초기화
  final dir = await getApplicationDocumentsDirectory();
  final isar = await Isar.open(
    [QuestionSetSchema, SessionSchema, QuestionResultSchema],
    directory: dir.path,
  );

  runApp(
    ProviderScope(
      overrides: [
        isarProvider.overrideWithValue(isar),
      ],
      child: const ButlerTimerApp(),
    ),
  );
}

class ButlerTimerApp extends StatelessWidget {
  const ButlerTimerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ButlerTimer',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      themeMode: ThemeMode.system, // 시스템 설정에 따라 라이트/다크 모드 변경
      home: const MainTabView(),
      debugShowCheckedModeBanner: false,
    );
  }
}
