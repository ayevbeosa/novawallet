import 'dart:async';

import 'package:bloc_signals/bloc_signals.dart';
import 'package:novawallet/core/connectivity/connectivity_service.dart';
import 'package:novawallet/modules/wallet/data/models/wallet_data.dart';
import 'package:novawallet/modules/wallet/data/repositories/wallet_repository.dart';

class WalletState {
  const WalletState({
    required this.status,
    this.data,
    this.isRefreshing = false,
    this.isOnline = true,
    this.errorMessage,
  });

  final WalletStatus status;
  final WalletData? data;
  final bool isRefreshing;
  final bool isOnline;
  final String? errorMessage;

  static const initial = WalletState(status: WalletStatus.loading);

  WalletState copyWith({
    WalletStatus? status,
    WalletData? data,
    bool? isRefreshing,
    bool? isOnline,
    String? errorMessage,
  }) {
    return WalletState(
      status: status ?? this.status,
      data: data ?? this.data,
      isRefreshing: isRefreshing ?? this.isRefreshing,
      isOnline: isOnline ?? this.isOnline,
      errorMessage: errorMessage,
    );
  }
}

class WalletCubit extends CubitSignal<WalletState> {
  WalletCubit({
    required WalletRepository repository,
    required ConnectivityService connectivity,
  }) : _repository = repository,
       _connectivity = connectivity,
       super(initialState: WalletState.initial) {
    _sub = repository.watch().listen((data) {
      emit(value.copyWith(status: WalletStatus.ready, data: data, isRefreshing: false));
    });
    _connSub = connectivity.onStatusChange.listen((online) {
      emit(value.copyWith(isOnline: online));
    });
    emit(value.copyWith(isOnline: connectivity.isOnline));
  }

  final WalletRepository _repository;
  final ConnectivityService _connectivity;
  late final StreamSubscription<WalletData> _sub;
  late final StreamSubscription<bool> _connSub;

  Future<void> refresh() async {
    if (!_connectivity.isOnline) {
      // Nothing to pull — pull-to-refresh just releases immediately; the
      // list already reflects local cache + any queued pending actions.
      return;
    }
    emit(value.copyWith(isRefreshing: true));
    try {
      await _repository.refresh();
    } on Exception catch (_) {
      emit(
        value.copyWith(isRefreshing: false, errorMessage: 'Could not refresh — try again'),
      );
    }
  }

  Future<void> retryFailed(String idempotencyKey) => _repository.retryFailed(idempotencyKey);

  @override
  Future<void> close() async {
    await _sub.cancel();
    await _connSub.cancel();
    return super.close();
  }
}

enum WalletStatus { loading, ready, error }
