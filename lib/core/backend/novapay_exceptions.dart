import 'package:novawallet/core/backend/fake_novapay_api.dart' show FakeNovaPayApi;

/// Raised by [FakeNovaPayApi] to simulate a transient backend/NIP-rail
/// failure (timeout, settlement error). Distinct from a connectivity drop —
/// the device is online, the request reached the "server", but the server
/// said no. The sync queue treats this differently: it burns a retry
/// attempt with backoff rather than silently re-queuing forever.
class NovaPayServerException implements Exception {
  NovaPayServerException(this.message);

  final String message;

  @override
  String toString() => 'NovaPayServerException: $message';
}

class InsufficientFundsException implements Exception {
  @override
  String toString() => 'InsufficientFundsException: balance too low for this amount';
}

class GoalNotFoundException implements Exception {
  @override
  String toString() => 'GoalNotFoundException: savings goal no longer exists';
}

class ConnectivityLostMidRequest implements Exception {
  const ConnectivityLostMidRequest();
}
