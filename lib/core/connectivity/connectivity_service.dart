import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';

/// Thin wrapper around `connectivity_plus` that collapses its list-of-types
/// result into a single online/offline boolean stream, and exposes a
/// `synchronous` current-value getter for one-shot checks (e.g. on app
/// start, before deciding whether to try draining the queue immediately).
class ConnectivityService {
  ConnectivityService({Connectivity? connectivity})
    : _connectivity = connectivity ?? Connectivity(),
      _isOnline = true,
      _usesPlugin = true;

  /// Bypasses the platform channel entirely. Used by widget/integration
  /// tests to drive offline/online transitions deterministically via
  /// [simulateStatusChange] instead of mocking `connectivity_plus`.
  ConnectivityService.test({bool initiallyOnline = true})
    : _connectivity = null,
      _isOnline = initiallyOnline,
      _usesPlugin = false;

  final Connectivity? _connectivity;
  final bool _usesPlugin;
  bool _isOnline;
  final _controller = StreamController<bool>.broadcast();

  StreamSubscription<List<ConnectivityResult>>? _subscription;

  bool get isOnline => _isOnline;

  Stream<bool> get onStatusChange => _controller.stream;

  Future<void> initialize() async {
    if (!_usesPlugin) return;
    final connectivity = _connectivity!;
    final initial = await connectivity.checkConnectivity();
    _isOnline = _toOnline(initial);
    _subscription = connectivity.onConnectivityChanged.listen((results) {
      final online = _toOnline(results);
      if (online == _isOnline) return;
      _isOnline = online;
      _controller.add(online);
    });
  }

  /// Test-only hook (see [ConnectivityService.test]) for driving an
  /// offline/online transition without a real platform event.
  void simulateStatusChange({required bool online}) {
    if (online == _isOnline) return;
    _isOnline = online;
    _controller.add(online);
  }

  bool _toOnline(List<ConnectivityResult> results) => results.any((r) => r != ConnectivityResult.none);

  void dispose() {
    if (_subscription != null) unawaited(_subscription!.cancel());
    unawaited(_controller.close());
  }
}
