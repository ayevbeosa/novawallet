import 'package:flutter/material.dart';
import 'package:novawallet/core/money/money.dart';
import 'package:novawallet/core/theme/app_colors.dart';
import 'package:novawallet/core/widgets/glow_card.dart';
import 'package:novawallet/core/widgets/neon_progress_bar.dart';
import 'package:novawallet/core/widgets/status_badge.dart';
import 'package:novawallet/modules/save/data/models/goal_view_data.dart';

class GoalCard extends StatelessWidget {
  const GoalCard({required this.data, required this.onTap, super.key});

  final GoalViewData data;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final goal = data.goal;
    final saved = Money.fromKobo(data.displaySavedAmount);
    final target = Money.fromKobo(goal.targetAmount);
    final progress = saved.progressTowards(target);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: GlowCard(
        glowColor: AppColors.magenta,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(goal.name, style: Theme.of(context).textTheme.titleLarge),
                ),
                if (data.hasPendingContribution)
                  const StatusBadge(label: 'Pending', tone: BadgeTone.pending)
                else if (data.hasFailedContribution)
                  const StatusBadge(label: 'Failed', tone: BadgeTone.failure),
              ],
            ),
            const SizedBox(height: 12),
            NeonProgressBar(progress: progress),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('${saved.format()} saved', style: const TextStyle(color: AppColors.textSecondary)),
                Text('${(progress * 100).round()}% of ${target.format()}'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
