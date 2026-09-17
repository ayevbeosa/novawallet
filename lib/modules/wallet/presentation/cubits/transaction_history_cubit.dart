import 'dart:async';

import 'package:bloc_signals/bloc_signals.dart';
import 'package:equatable/equatable.dart';
import 'package:novawallet/modules/wallet/data/models/transaction_entry.dart';
import 'package:novawallet/modules/wallet/data/repositories/wallet_repository.dart';

class TransactionHistoryCubit extends CubitSignal<TransactionHistoryState> {
  TransactionHistoryCubit({required this._repository}) : super(initialState: const TransactionHistoryState()) {
    unawaited(loadNextPage());
  }

  final WalletRepository _repository;
  int _nextPage = 0;

  Future<void> loadNextPage() async {
    if (value.isLoadingNextPage || !value.hasMore) return;
    emit(value.copyWith(isLoadingNextPage: true, clearError: true));
    try {
      final page = await _repository.transactionPage(page: _nextPage);
      _nextPage++;
      emit(
        value.copyWith(
          transactions: [...value.transactions, ...page],
          isLoadingFirstPage: false,
          isLoadingNextPage: false,
          hasMore: page.length == 20,
        ),
      );
    } on Exception {
      emit(
        value.copyWith(
          isLoadingFirstPage: false,
          isLoadingNextPage: false,
          errorMessage: 'Could not load more transactions — try again',
        ),
      );
    }
  }
}

class TransactionHistoryState extends Equatable {
  const TransactionHistoryState({
    this.transactions = const [],
    this.isLoadingFirstPage = true,
    this.isLoadingNextPage = false,
    this.hasMore = true,
    this.errorMessage,
  });

  final List<TransactionEntry> transactions;
  final bool isLoadingFirstPage;
  final bool isLoadingNextPage;
  final bool hasMore;
  final String? errorMessage;

  TransactionHistoryState copyWith({
    List<TransactionEntry>? transactions,
    bool? isLoadingFirstPage,
    bool? isLoadingNextPage,
    bool? hasMore,
    String? errorMessage,
    bool clearError = false,
  }) {
    return TransactionHistoryState(
      transactions: transactions ?? this.transactions,
      isLoadingFirstPage: isLoadingFirstPage ?? this.isLoadingFirstPage,
      isLoadingNextPage: isLoadingNextPage ?? this.isLoadingNextPage,
      hasMore: hasMore ?? this.hasMore,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
    );
  }

  @override
  List<Object?> get props => [transactions, isLoadingFirstPage, isLoadingNextPage, hasMore, errorMessage];
}
