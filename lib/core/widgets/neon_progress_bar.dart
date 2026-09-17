import 'package:flutter/material.dart';
import 'package:novawallet/core/l10n/generated/app_localizations.dart';
import 'package:novawallet/core/theme/app_colors.dart';

/// A progress bar for savings-goal completion. [progress] must already be
/// the exact, pre-computed ratio (see `Money.progressTowards`) — this
/// widget does no division of its own, so it can never introduce float
/// drift into a number that was already computed safely upstream.
class NeonProgressBar extends StatelessWidget {
  const NeonProgressBar({required this.progress, super.key, this.height = 10});

  final double progress;
  final double height;

  @override
  Widget build(BuildContext context) {
    final clamped = progress.clamp(0.0, 1.0);
    final l10n = AppLocalizations.of(context)!;
    return Semantics(
      label: l10n.goalProgress,
      value: '${(clamped * 100).round()}%',
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Stack(
            children: [
              Container(
                height: height,
                decoration: BoxDecoration(
                  color: AppColors.surfaceRaised,
                  borderRadius: BorderRadius.circular(height),
                ),
              ),
              AnimatedContainer(
                duration: const Duration(milliseconds: 400),
                curve: Curves.easeOutCubic,
                height: height,
                width: constraints.maxWidth * clamped,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(height),
                  gradient: const LinearGradient(
                    colors: [AppColors.cyan, AppColors.magenta],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.cyan.withValues(alpha: 0.5),
                      blurRadius: 8,
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
