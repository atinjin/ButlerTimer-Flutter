import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import '../../providers/question_set_provider.dart';
import '../../providers/timer_provider.dart';
import '../timer/active_session_view.dart';
import 'create_set_view.dart';

class QuestionSetListView extends ConsumerWidget {
  const QuestionSetListView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final setListState = ref.watch(questionSetProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDark ? const Color(0xFF14161E) : const Color(0xFFF6F6F8);
    final textColor =
        isDark ? const Color(0xFFF1F5F9) : const Color(0xFF0F172A);
    const primaryColor = Color(0xFF4051B5);

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        titleSpacing: 24,
        backgroundColor: isDark
            ? const Color(0xFF14161E).withValues(alpha: 0.8)
            : const Color(0xFFF6F6F8).withValues(alpha: 0.8),
        elevation: 0,
        scrolledUnderElevation: 0,
        title: Text(
          'Problem Sets',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: textColor,
            letterSpacing: -0.5,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(
            color: primaryColor.withValues(alpha: 0.1),
            height: 1.0,
          ),
        ),
      ),
      body: setListState.when(
        data: (sets) {
          if (sets.isEmpty) {
            return _buildEmptyState(isDark);
          }

          return ListView.separated(
            padding: const EdgeInsets.all(16.0),
            itemCount: sets.length,
            separatorBuilder: (context, index) => const SizedBox(height: 16),
            itemBuilder: (context, index) {
              final qSet = sets[index];
              return _buildSetCard(context, ref, qSet, isDark, primaryColor);
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
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        elevation: 8,
        shape: const CircleBorder(),
        child: const Icon(Icons.add, size: 28),
      ),
    );
  }

  Widget _buildEmptyState(bool isDark) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.inventory_2_outlined,
            size: 64,
            color: isDark ? Colors.white24 : Colors.black26,
          ),
          const SizedBox(height: 16),
          Text(
            'Manage your exam repository',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: isDark ? Colors.white54 : Colors.black54,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSetCard(BuildContext context, WidgetRef ref, dynamic qSet,
      bool isDark, Color primaryColor) {
    final cardBgColor =
        isDark ? const Color(0xFF1E293B).withValues(alpha: 0.5) : Colors.white;
    final titleColor =
        isDark ? const Color(0xFFF1F5F9) : const Color(0xFF0F172A);

    return Container(
      decoration: BoxDecoration(
        color: cardBgColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: primaryColor.withValues(alpha: 0.05)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Slidable(
        key: Key(qSet.id.toString()),
        endActionPane: ActionPane(
          motion: const ScrollMotion(),
          extentRatio: 0.4,
          children: [
            CustomSlidableAction(
              onPressed: (context) {
                // TODO: Edit Action
              },
              backgroundColor:
                  isDark ? const Color(0xFF334155) : const Color(0xFFF1F5F9),
              foregroundColor:
                  isDark ? const Color(0xFFE2E8F0) : const Color(0xFF334155),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.edit, size: 24),
                  SizedBox(height: 4),
                  Text('EDIT',
                      style:
                          TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            CustomSlidableAction(
              onPressed: (context) {
                ref.read(questionSetProvider.notifier).deleteSet(qSet.id);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('${qSet.title} deleted')),
                );
              },
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.delete, size: 24),
                  SizedBox(height: 4),
                  Text('DELETE',
                      style:
                          TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ],
        ),
        child: InkWell(
          onTap: () {
            ref.read(timerProvider.notifier).startSession(qSet);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => ActiveSessionView(qSet: qSet)),
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: primaryColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(Icons.menu_book, color: primaryColor),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        qSet.title,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: titleColor,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        runSpacing: 4,
                        children: [
                          _buildBadge(
                            icon: Icons.format_list_bulleted,
                            text: '${qSet.questionCount} Problems',
                            isDark: isDark,
                          ),
                          _buildBadge(
                            icon: Icons.schedule,
                            text: '100 min', // TODO: Add estimated time
                            isDark: isDark,
                          ),
                          _buildHistoryBadge(
                            icon: Icons.history,
                            text:
                                'Last studied 2h ago', // TODO: Add real history
                            isDark: isDark,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBadge(
      {required IconData icon, required String text, required bool isDark}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: isDark
            ? const Color(0xFF334155).withValues(alpha: 0.5)
            : const Color(0xFFF1F5F9),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 12,
            color: isDark ? const Color(0xFFCBD5E1) : const Color(0xFF475569),
          ),
          const SizedBox(width: 4),
          Text(
            text,
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w500,
              color: isDark ? const Color(0xFFCBD5E1) : const Color(0xFF475569),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHistoryBadge(
      {required IconData icon, required String text, required bool isDark}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: isDark
            ? const Color(0xFF312E81).withValues(alpha: 0.3)
            : const Color(0xFFEEF2FF),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 12,
            color: isDark ? const Color(0xFFA5B4FC) : const Color(0xFF4F46E5),
          ),
          const SizedBox(width: 4),
          Text(
            text,
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w500,
              color: isDark ? const Color(0xFFA5B4FC) : const Color(0xFF4F46E5),
            ),
          ),
        ],
      ),
    );
  }
}
