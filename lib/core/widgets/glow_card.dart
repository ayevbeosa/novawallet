import 'package:flutter/material.dart';
import 'package:novawallet/core/theme/app_colors.dart';

/// A card with a soft neon glow around its border. The glow is purely
/// decorative (a `BoxShadow`) — it never affects the contrast of the text
/// drawn on top of it.
class GlowCard extends StatelessWidget {
  const GlowCard({
    required this.child,
    super.key,
    this.glowColor = AppColors.cyan,
    this.padding = const EdgeInsets.all(20),
    this.borderColor,
  });

  final Widget child;
  final Color glowColor;
  final EdgeInsets padding;
  final Color? borderColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: borderColor ?? AppColors.border),
        boxShadow: [
          BoxShadow(
            color: glowColor.withValues(alpha: 0.16),
            blurRadius: 24,
            spreadRadius: -4,
          ),
        ],
      ),
      child: child,
    );
  }
}
