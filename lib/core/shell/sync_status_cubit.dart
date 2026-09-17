import 'dart:async';

import 'package:bloc_signals/bloc_signals.dart';
import 'package:novawallet/core/connectivity/connectivity_service.dart';
import 'package:novawallet/core/database/app_database.dart';
import 'package:rxdart/rxdart.dart';

class SyncStatusState {
  const SyncStatusState({
    required this.isOnline,
    required this.pendingCount,
    required this.failedCount,
  });

  final bool isOnline;
  final int pendingCount;
  final int failedCount;

  static const initial = SyncStatusState(isOnline: true, pendingCount: 0, failedCount: 0);
}

/// Drives the offline banner and nav-bar pending badge from the two
/// sources of truth: live connectivity and the persisted queue.
class SyncStatusCubit extends CubitSignal<SyncStatusState> {
  SyncStatusCubit({required AppDatabase db, required ConnectivityService connectivity})
    : _connectivity = connectivity,
      super(initialState: SyncStatusState.initial) {
    _subscription = Rx.combineLatest2<bool, List<QueuedActionRow>, SyncStatusState>(
      connectivity.onStatusChange.startWith(connectivity.isOnline),
      db.watchQueue(),
      (online, queue) => SyncStatusState(
        isOnline: online,
        pendingCount: queue.where((r) => r.status == 'pending' || r.status == 'syncing').length,
        failedCount: queue.where((r) => r.status == 'failed').length,
      ),
    ).listen(emit);
  }

  final ConnectivityService _connectivity;
  late final StreamSubscription<SyncStatusState> _subscription;

  bool get isOnline => _connectivity.isOnline;

  @override
  Future<void> close() async {
    await _subscription.cancel();
    return super.close();
  }
}
