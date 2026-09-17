import 'package:bloc_signals_flutter/bloc_signals_flutter.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:novawallet/core/l10n/generated/app_localizations.dart';
import 'package:novawallet/core/router/app_routes.dart';
import 'package:novawallet/core/theme/app_colors.dart';
import 'package:novawallet/modules/wallet/data/models/transaction_entry.dart';
import 'package:novawallet/modules/wallet/presentation/components/balance_card.dart';
import 'package:novawallet/modules/wallet/presentation/components/transaction_tile.dart';
import 'package:novawallet/modules/wallet/presentation/cubits/wallet_cubit.dart';

class WalletHomeScreen extends StatelessWidget {
  const WalletHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<WalletCubit>();
    final state = context.value<WalletCubit, WalletState>();
    final data = state.data;
    final l10n = AppLocalizations.of(context)!;

    return RefreshIndicator(
      color: AppColors.cyan,
      backgroundColor: AppColors.surface,
      onRefresh: cubit.refresh,
      child: CustomScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        slivers: [
          SliverAppBar(
            floating: true,
            title: Text(l10n.appTitle),
            actions: [
              IconButton(
                icon: const Icon(Icons.settings_outlined),
                tooltip: l10n.settings,
                onPressed: () => context.push(AppRoutes.settings),
              ),
            ],
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
            sliver: SliverToBoxAdapter(
              child: BalanceCard(
                balance: data?.displayBalance ?? 0,
                accountName: data?.wallet?.accountName,
                accountNumber: data?.wallet?.accountNumber,
                hasPending: data?.hasPendingActions ?? false,
                loading: state.status == WalletStatus.loading,
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
            sliver: SliverToBoxAdapter(
              child: Row(
                children: [
                  Expanded(
                    child: _QuickActionButton(
                      icon: Icons.north_east_rounded,
                      label: l10n.send,
                      color: AppColors.cyan,
                      onTap: () => context.push(AppRoutes.send),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _QuickActionButton(
                      icon: Icons.savings_rounded,
                      label: l10n.save,
                      color: AppColors.magenta,
                      onTap: () => context.push(AppRoutes.createGoal),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverToBoxAdapter(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(l10n.recentActivity, style: Theme.of(context).textTheme.titleMedium),
                  if (data != null && data.transactions.isNotEmpty)
                    TextButton(
                      onPressed: () => context.push(AppRoutes.transactions),
                      child: Text(l10n.seeAll),
                    ),
                ],
              ),
            ),
          ),
          const SliverPadding(padding: EdgeInsets.only(top: 8)),
          if (data == null || data.transactions.isEmpty)
            SliverFillRemaining(
              hasScrollBody: false,
              child: Center(child: Text(l10n.noTransactions)),
            )
          else
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 32),
              sliver: SliverList.builder(
                itemCount: data.transactions.length,
                itemBuilder: (context, index) {
                  final tx = data.transactions[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: TransactionTile(
                      transaction: tx,
                      onRetry: tx.status == TransactionStatus.failed ? () => cubit.retryFailed(tx.id) : null,
                    ),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}

class _QuickActionButton extends StatelessWidget {
  const _QuickActionButton({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: label,
      child: Material(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 14),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: color.withValues(alpha: 0.5)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(icon, color: color),
                const SizedBox(height: 6),
                Text(
                  label,
                  style: TextStyle(color: color, fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
