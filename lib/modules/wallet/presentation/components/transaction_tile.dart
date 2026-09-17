import 'package:flutter/material.dart';
import 'package:novawallet/core/l10n/generated/app_localizations.dart';
import 'package:novawallet/core/money/money.dart';
import 'package:novawallet/core/theme/app_colors.dart';
import 'package:novawallet/core/widgets/status_badge.dart';
import 'package:novawallet/modules/wallet/data/models/transaction_entry.dart';

class TransactionTile extends StatelessWidget {
  const TransactionTile({required this.transaction, super.key, this.onRetry});

  final TransactionEntry transaction;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    final isCredit = transaction.transactionType == TransactionType.credit;
    final money = Money.fromKobo(transaction.amount);
    final sign = isCredit ? '+' : '-';
    final amountColor = isCredit ? AppColors.green : AppColors.textPrimary;
    final l10n = AppLocalizations.of(context)!;

    final (badgeLabel, badgeTone) = switch (transaction.status) {
      TransactionStatus.completed => (null, null),
      TransactionStatus.pending => (l10n.pending, BadgeTone.pending),
      TransactionStatus.failed => (l10n.failed, BadgeTone.failure),
    };

    final typeLabel = isCredit ? l10n.credit : l10n.debit;
    final directionLabel = isCredit ? l10n.from : l10n.to.toLowerCase();

    return Semantics(
      label:
          l10n.transactionSemantics(
            typeLabel,
            money.format(),
            directionLabel,
            transaction.beneficiary,
          ) +
          (badgeLabel != null ? ', $badgeLabel' : ''),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.border),
        ),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: AppColors.surfaceRaised,
              child: Icon(
                isCredit ? Icons.south_west_rounded : Icons.north_east_rounded,
                color: isCredit ? AppColors.green : AppColors.magenta,
                size: 18,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    transaction.beneficiary,
                    style: Theme.of(context).textTheme.bodyLarge,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (badgeLabel != null) ...[
                    const SizedBox(height: 4),
                    StatusBadge(label: badgeLabel, tone: badgeTone!),
                  ],
                ],
              ),
            ),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '$sign${money.format()}',
                  style: TextStyle(color: amountColor, fontWeight: FontWeight.w600),
                ),
                if (onRetry != null)
                  TextButton(
                    onPressed: onRetry,
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      minimumSize: const Size(0, 24),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    child: Text(l10n.retry, style: const TextStyle(fontSize: 12)),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
