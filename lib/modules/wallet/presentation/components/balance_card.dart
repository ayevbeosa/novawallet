import 'package:flutter/material.dart';
import 'package:novawallet/core/l10n/generated/app_localizations.dart';
import 'package:novawallet/core/money/money.dart';
import 'package:novawallet/core/theme/app_colors.dart';
import 'package:novawallet/core/widgets/glow_card.dart';
import 'package:novawallet/core/widgets/status_badge.dart';

class BalanceCard extends StatelessWidget {
  const BalanceCard({
    required this.balance,
    required this.accountName,
    required this.accountNumber,
    required this.hasPending,
    required this.loading,
    super.key,
  });

  final int balance;
  final String? accountName;
  final String? accountNumber;
  final bool hasPending;
  final bool loading;

  @override
  Widget build(BuildContext context) {
    final money = Money.fromKobo(balance);
    final l10n = AppLocalizations.of(context)!;
    return GlowCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(l10n.availableBalance, style: Theme.of(context).textTheme.bodyMedium),
              if (hasPending) StatusBadge(label: l10n.pendingActivity, tone: BadgeTone.pending),
            ],
          ),
          const SizedBox(height: 10),
          Semantics(
            label: l10n.availableBalance,
            value: loading ? l10n.loading : money.format(),
            child: FittedBox(
              fit: BoxFit.scaleDown,
              alignment: Alignment.centerLeft,
              child: Text(
                loading ? '₦ — — —' : money.format(),
                style: Theme.of(
                  context,
                ).textTheme.displaySmall?.copyWith(fontWeight: FontWeight.w700, color: AppColors.textPrimary),
              ),
            ),
          ),
          const SizedBox(height: 14),
          if (accountName != null)
            Text(
              '$accountName • ${accountNumber ?? ''}',
              style: const TextStyle(color: AppColors.textSecondary, fontSize: 13),
            ),
        ],
      ),
    );
  }
}
