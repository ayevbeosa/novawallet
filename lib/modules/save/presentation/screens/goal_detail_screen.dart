import 'package:bloc_signals_flutter/bloc_signals_flutter.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:novawallet/core/l10n/generated/app_localizations.dart';
import 'package:novawallet/core/money/money.dart';
import 'package:novawallet/core/theme/app_colors.dart';
import 'package:novawallet/core/widgets/glow_card.dart';
import 'package:novawallet/core/widgets/neon_progress_bar.dart';
import 'package:novawallet/core/widgets/status_badge.dart';
import 'package:novawallet/modules/save/presentation/components/contribute_sheet.dart';
import 'package:novawallet/modules/save/presentation/cubits/save_goals_cubit.dart';

class GoalDetailScreen extends StatelessWidget {
  const GoalDetailScreen({required this.goalId, super.key});

  final String goalId;

  @override
  Widget build(BuildContext context) {
    final state = context.value<SaveGoalsCubit, SaveGoalsState>();
    final match = state.goals.where((g) => g.goal.id == goalId);
    final l10n = AppLocalizations.of(context)!;

    if (match.isEmpty) {
      return Scaffold(body: Center(child: Text(l10n.goalNotFound)));
    }
    final data = match.first;
    final goal = data.goal;
    final saved = Money.fromKobo(data.displaySavedAmount);
    final target = Money.fromKobo(goal.targetAmount);
    final progress = saved.progressTowards(target);
    final remaining = target - saved;

    return Scaffold(
      appBar: AppBar(title: Text(goal.name)),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            GlowCard(
              glowColor: AppColors.magenta,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(saved.format(), style: Theme.of(context).textTheme.headlineMedium),
                      if (data.hasPendingContribution)
                        StatusBadge(label: l10n.pendingOffline, tone: BadgeTone.pending)
                      else if (data.displaySavedAmount >= goal.targetAmount)
                        StatusBadge(label: l10n.reached, tone: BadgeTone.success),
                    ],
                  ),
                  Text(l10n.ofTarget(target.format()), style: const TextStyle(color: AppColors.textSecondary)),
                  const SizedBox(height: 16),
                  NeonProgressBar(progress: progress),
                  const SizedBox(height: 10),
                  Text(
                    l10n.percentComplete((progress * 100).round()),
                    style: const TextStyle(color: AppColors.textSecondary),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    data.displaySavedAmount >= goal.targetAmount
                        ? l10n.goalReached
                        : l10n.leftToReachTarget(remaining.format()),
                    style: const TextStyle(color: AppColors.textSecondary),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    l10n.targetDateLabel(DateFormat('yyyy-MM-dd').format(goal.targetDate)),
                    style: const TextStyle(color: AppColors.textMuted, fontSize: 12),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 52,
              child: ElevatedButton(
                onPressed: data.displaySavedAmount >= goal.targetAmount
                    ? null
                    : () => showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        backgroundColor: AppColors.surface,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                        ),
                        builder: (_) => ContributeSheet(goalId: goal.id, goalName: goal.name),
                      ),
                child: Text(l10n.contribute),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
