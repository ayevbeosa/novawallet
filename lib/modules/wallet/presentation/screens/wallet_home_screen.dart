import 'package:bloc_signals_flutter/bloc_signals_flutter.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:novawallet/core/theme/app_colors.dart';
import 'package:novawallet/modules/wallet/data/models/transaction_entry/transaction_entry.dart';
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

    return RefreshIndicator(
      color: AppColors.cyan,
      backgroundColor: AppColors.surface,
      onRefresh: cubit.refresh,
      child: CustomScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        slivers: [
          SliverAppBar(
            floating: true,
            title: const Text('NovaWallet'),
            actions: [
              IconButton(
                icon: const Icon(Icons.send_rounded),
                tooltip: 'Send money',
                onPressed: () => context.push('/send'),
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
            padding: const EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverToBoxAdapter(
              child: Text('Recent activity', style: Theme.of(context).textTheme.titleMedium),
            ),
          ),
          const SliverPadding(padding: EdgeInsets.only(top: 8)),
          if (data == null || data.transactions.isEmpty)
            const SliverFillRemaining(
              hasScrollBody: false,
              child: Center(child: Text('No transactions yet')),
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
