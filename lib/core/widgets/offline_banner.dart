import 'package:flutter/material.dart';
import 'package:novawallet/core/theme/app_colors.dart';

/// Persistent, accessible banner shown across the app while offline. Uses
/// `Semantics(liveRegion: true)` so a screen reader announces the
/// transition without the user having to go find it.
class OfflineBanner extends StatelessWidget {
  const OfflineBanner({required this.visible, super.key, this.pendingCount = 0});

  final bool visible;
  final int pendingCount;

  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      duration: const Duration(milliseconds: 250),
      child: visible
          ? Semantics(
              liveRegion: true,
              child: Container(
                width: double.infinity,
                color: AppColors.gold.withValues(alpha: 0.14),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                child: Row(
                  children: [
                    const Icon(Icons.cloud_off_rounded, color: AppColors.gold, size: 18),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        pendingCount > 0
                            ? "You're offline — $pendingCount action${pendingCount == 1 ? '' : 's'} pending, will send when back online"
                            : "You're offline — actions will queue and send when back online",
                        style: const TextStyle(
                          color: AppColors.gold,
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          : const SizedBox.shrink(),
    );
  }
}
