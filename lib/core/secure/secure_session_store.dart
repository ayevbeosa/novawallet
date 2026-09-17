import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Holds the mock session/bearer token NovaWallet would use to authorize
/// requests.
class SecureSessionStore {
  SecureSessionStore({FlutterSecureStorage? storage})
      : _storage = storage ?? const FlutterSecureStorage();

  static const _tokenKey = 'novawallet.session_token';

  final FlutterSecureStorage _storage;

  Future<void> saveMockToken(String token) => _storage.write(key: _tokenKey, value: token);

  Future<String?> readToken() => _storage.read(key: _tokenKey);

  Future<void> clear() => _storage.delete(key: _tokenKey);
}
