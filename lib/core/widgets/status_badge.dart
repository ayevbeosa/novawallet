import 'package:flutter/material.dart';
import 'package:novawallet/core/theme/app_colors.dart';

enum BadgeTone { neutral, pending, success, failure }

class StatusBadge extends StatelessWidget {
  const StatusBadge({required this.label, required this.tone, super.key});

  final String label;
  final BadgeTone tone;

  Color get _color => switch (tone) {
    BadgeTone.neutral => AppColors.textSecondary,
    BadgeTone.pending => AppColors.gold,
    BadgeTone.success => AppColors.green,
    BadgeTone.failure => AppColors.red,
  };

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: _color.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: _color.withValues(alpha: 0.5)),
      ),
      child: Text(
        label,
        style: TextStyle(color: _color, fontSize: 12, fontWeight: FontWeight.w600),
      ),
    );
  }
}
