import 'package:flutter/material.dart';
import 'package:novawallet/core/l10n/generated/app_localizations.dart';
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
    final l10n = AppLocalizations.of(context)!;

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
                  StatusBadge(label: l10n.pending, tone: BadgeTone.pending)
                else if (data.hasFailedContribution)
                  StatusBadge(label: l10n.failed, tone: BadgeTone.failure)
                else if (data.displaySavedAmount >= goal.targetAmount)
                  StatusBadge(label: l10n.reached, tone: BadgeTone.success),
              ],
            ),
            const SizedBox(height: 12),
            NeonProgressBar(progress: progress),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(l10n.savedAmount(saved.format()), style: const TextStyle(color: AppColors.textSecondary)),
                Text(l10n.progressOfTarget((progress * 100).round(), target.format())),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
