import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/foundation.dart';

/// Stretch goal: fires a local notification when a queued action that was
/// sitting offline finally syncs.
class NotificationService {
  NotificationService({AwesomeNotifications? plugin}) : _plugin = plugin ?? AwesomeNotifications();

  final AwesomeNotifications _plugin;
  bool _initialized = false;
  final _channelKey = 'novawallet_sync';

  Future<void> initialize() async {
    if (_initialized) return;
    final isAllowed = await _plugin.isNotificationAllowed();
    if (!isAllowed) {
      await _plugin.requestPermissionToSendNotifications();
    }

    await _plugin.initialize(
      null,
      [
        NotificationChannel(
          channelKey: _channelKey,
          channelName: 'Sync updates',
          channelDescription: 'Notifies when a queued offline action finishes syncing',
          importance: NotificationImportance.High,
        ),
      ],
      debug: kDebugMode,
    );
    _initialized = true;
  }

  Future<void> showSynced({required String title, required String body}) async {
    if (!_initialized) return;

    final isAllowed = await _plugin.isNotificationAllowed();
    if (isAllowed) {
      await _plugin.createNotification(
        content: NotificationContent(
          id: DateTime.now().millisecondsSinceEpoch ~/ 1000,
          channelKey: _channelKey,
          title: title,
          body: body,
        ),
      );
    }
  }
}
