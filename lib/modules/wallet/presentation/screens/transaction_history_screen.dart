import 'dart:async';

import 'package:bloc_signals_flutter/bloc_signals_flutter.dart';
import 'package:flutter/material.dart';
import 'package:novawallet/core/di/service_locator.dart';
import 'package:novawallet/core/theme/app_colors.dart';
import 'package:novawallet/modules/wallet/data/repositories/wallet_repository.dart';
import 'package:novawallet/modules/wallet/presentation/components/transaction_tile.dart';
import 'package:novawallet/modules/wallet/presentation/cubits/transaction_history_cubit.dart';

class TransactionHistoryScreen extends StatefulWidget {
  const TransactionHistoryScreen({super.key});

  @override
  State<TransactionHistoryScreen> createState() => _TransactionHistoryScreenState();
}

class _TransactionHistoryScreenState extends State<TransactionHistoryScreen> {
  late final _cubit = TransactionHistoryCubit(repository: getIt<WalletRepository>());
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 200) {
      unawaited(_cubit.loadNextPage());
    }
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    unawaited(_cubit.close());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('All transactions')),
      body: RefreshIndicator(
        color: AppColors.cyan,
        backgroundColor: AppColors.surface,
        onRefresh: _cubit.refresh,
        child: BlocSignalBuilder<TransactionHistoryCubit, TransactionHistoryState>(
          bloc: _cubit,
          builder: (context, state) {
            if (state.isLoadingFirstPage) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state.transactions.isEmpty) {
              return const Center(child: Text('No transactions yet'));
            }
            return ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
              itemCount: state.transactions.length + 1,
              itemBuilder: (context, index) {
                if (index == state.transactions.length) {
                  return _FooterIndicator(state: state, onRetry: _cubit.loadNextPage);
                }
                return Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: TransactionTile(transaction: state.transactions[index]),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

class _FooterIndicator extends StatelessWidget {
  const _FooterIndicator({required this.state, required this.onRetry});

  final TransactionHistoryState state;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    if (state.errorMessage != null) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Column(
          children: [
            Text(state.errorMessage!, style: const TextStyle(color: AppColors.red)),
            const SizedBox(height: 8),
            TextButton(onPressed: onRetry, child: const Text('Retry')),
          ],
        ),
      );
    }
    if (state.isLoadingNextPage) {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: 20),
        child: Center(child: CircularProgressIndicator(strokeWidth: 2)),
      );
    }
    return const SizedBox.shrink();
  }
}
