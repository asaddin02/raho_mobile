import 'dart:io';
import 'dart:convert';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:raho_member_apps/l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

class FirebaseService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _localNotifications =
      FlutterLocalNotificationsPlugin();

  static const String _notificationGroupKey = 'notification_groups';
  static const String _groupKey = 'com.rahomemberapps.notifications';
  static const int _summaryNotificationId = 0;

  BuildContext? _context;
  Function(Map<String, dynamic>)? onNotificationTapped;

  void setContext(BuildContext context) {
    _context = context;
  }

  AppLocalizations? get _l10n {
    if (_context != null) {
      return AppLocalizations.of(_context!);
    }
    return null;
  }

  Future<void> initialize({
    Function(Map<String, dynamic>)? onTapped,
    BuildContext? context,
  }) async {
    onNotificationTapped = onTapped;
    if (context != null) {
      _context = context;
    }
    await _initializeLocalNotifications();
    await _requestPermissions();
    FirebaseMessaging.onMessage.listen(_handleForegroundMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(_handleBackgroundMessage);
    RemoteMessage? initialMessage = await _firebaseMessaging
        .getInitialMessage();
    if (initialMessage != null) {
      _handleBackgroundMessage(initialMessage);
    }
  }

  Future<int> _getAndroidInfo() async {
    if (Platform.isAndroid) {
      final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
      final AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      return androidInfo.version.sdkInt ?? 33;
    }
    return 0;
  }

  Future<void> _initializeLocalNotifications() async {
    const androidSettings = AndroidInitializationSettings(
      '@mipmap/ic_launcher',
    );
    const iosSettings = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );
    const initSettings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );
    await _localNotifications.initialize(
      initSettings,
      onDidReceiveNotificationResponse: _onNotificationTapped,
    );

    if (Platform.isAndroid) {
      await _createNotificationChannels();
    }
  }

  Future<void> _createNotificationChannels() async {
    final plugin = _localNotifications
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >();
    if (plugin == null) return;

    const group = AndroidNotificationChannelGroup(
      'event_group',
      'Event Notifications Group',
    );
    await plugin.createNotificationChannelGroup(group);

    const mainChannel = AndroidNotificationChannel(
      'event_channel',
      'Event Notifications',
      description: 'Notifications for events and promotions',
      importance: Importance.high,
      playSound: true,
      enableVibration: true,
      groupId: 'event_group',
    );

    const summaryChannel = AndroidNotificationChannel(
      'summary_channel',
      'Summary Notifications',
      description: 'Summary of grouped notifications',
      importance: Importance.high,
      playSound: false,
      enableVibration: false,
      groupId: 'event_group',
    );

    await plugin.createNotificationChannel(mainChannel);
    await plugin.createNotificationChannel(summaryChannel);
  }

  Future<void> _requestPermissions() async {
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
      provisional: false,
      announcement: false,
      carPlay: false,
      criticalAlert: false,
    );
    settings;
    if (Platform.isAndroid) {
      final androidInfo = await _getAndroidInfo();
      if (androidInfo >= 33) {
        final status = await Permission.notification.request();
        if (status.isPermanentlyDenied) {
          await openAppSettings();
        }
      }
    }
  }

  Future<String?> getToken() async {
    try {
      bool isSupported = await _firebaseMessaging.isSupported();
      if (!isSupported) {
        return null;
      }
      String? token = await _firebaseMessaging.getToken();
      return token;
    } catch (e) {
      return null;
    }
  }

  Future<void> _handleForegroundMessage(RemoteMessage message) async {
    if (message.notification != null) {
      await _showGroupedNotification(message);
    }
  }

  String _getNotificationTypeText(String? type) {
    if (_l10n == null) {
      return _getDefaultTypeText(type);
    }
    switch (type) {
      case 'event_promotion':
        return _l10n!.notificationTypeEvent;
      default:
        return _l10n!.notificationTypeDefault;
    }
  }

  String _getDefaultTypeText(String? type) {
    switch (type) {
      case 'event_promotion':
        return 'Event';
      default:
        return 'Notification';
    }
  }

  String _getNowText() {
    return _l10n?.timeNow ?? 'now';
  }

  String _getNotificationTitle() {
    return _l10n?.notificationTitle ?? 'Notifications';
  }

  Future<void> _showGroupedNotification(RemoteMessage message) async {
    final notification = message.notification;
    if (notification == null) return;

    final notificationId = message.data['event_id'] != null
        ? int.tryParse(message.data['event_id'].toString()) ?? message.hashCode
        : message.hashCode;

    await _saveNotificationToGroup(notificationId, message);

    final notificationCount = await _getNotificationCount();

    final bigTextStyle = BigTextStyleInformation(
      notification.body ?? '',
      contentTitle: notification.title,
      summaryText:
          message.data['event_name'] ??
          (_l10n?.notificationTypeEvent ?? 'Event'),
      htmlFormatContent: true,
      htmlFormatContentTitle: true,
    );

    final androidDetails = AndroidNotificationDetails(
      'event_channel',
      'Event Notifications',
      channelDescription: 'Notifications for events and promotions',
      importance: Importance.high,
      priority: Priority.high,
      styleInformation: bigTextStyle,
      groupKey: _groupKey,
      setAsGroupSummary: false,
      showWhen: true,
      when: DateTime.now().millisecondsSinceEpoch,
      enableVibration: true,
      playSound: true,
      ticker: notification.title,
      autoCancel: true,
    );

    const iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
      threadIdentifier: 'event_notifications',
    );

    final notificationDetails = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    await _localNotifications.show(
      notificationId,
      notification.title,
      notification.body,
      notificationDetails,
      payload: jsonEncode(message.data),
    );

    if (Platform.isAndroid && notificationCount > 1) {
      await _showGroupSummaryNotification(notificationCount);
    }
  }

  Future<void> _showGroupSummaryNotification(int count) async {
    final prefs = await SharedPreferences.getInstance();
    final groups = prefs.getStringList(_notificationGroupKey) ?? [];

    Map<String, int> typeCount = {};
    List<String> summaryLines = [];

    for (String groupData in groups) {
      final data = jsonDecode(groupData);
      final type = data['type'] ?? 'event_promotion';
      final typeText = _getNotificationTypeText(type);
      typeCount[typeText] = (typeCount[typeText] ?? 0) + 1;
      if (summaryLines.length < 5) {
        final title =
            data['title'] ?? (_l10n?.notificationTypeEvent ?? 'Event');
        final body = data['body'] ?? '';
        summaryLines.add(
          '$title: ${body.length > 50 ? body.substring(0, 50) + '...' : body}',
        );
      }
    }

    String summaryText;
    final nowText = _getNowText();

    if (typeCount.length == 1) {
      final entry = typeCount.entries.first;
      summaryText = '${entry.value} ${entry.key} • $nowText';
    } else {
      final typesText = typeCount.entries
          .map((e) => '${e.value} ${e.key}')
          .join(', ');
      summaryText = '$typesText • $nowText';
    }

    final summaryTitle = _getNotificationTitle();

    final inboxStyle = InboxStyleInformation(
      summaryLines,
      contentTitle: summaryTitle,
      summaryText: summaryText,
    );

    final androidDetails = AndroidNotificationDetails(
      'summary_channel',
      'Summary Notifications',
      channelDescription: 'Summary of grouped notifications',
      importance: Importance.high,
      priority: Priority.defaultPriority,
      styleInformation: inboxStyle,
      groupKey: _groupKey,
      setAsGroupSummary: true,
      showWhen: false,
      autoCancel: true,
      onlyAlertOnce: true,
    );

    await _localNotifications.show(
      _summaryNotificationId,
      summaryTitle,
      summaryText,
      NotificationDetails(android: androidDetails),
    );
  }

  Future<void> _saveNotificationToGroup(int id, RemoteMessage message) async {
    final prefs = await SharedPreferences.getInstance();
    final groups = prefs.getStringList(_notificationGroupKey) ?? [];

    groups.removeWhere((item) {
      final data = jsonDecode(item);
      return data['id'] == id;
    });

    final notificationData = {
      'id': id,
      'title':
          message.notification?.title ??
          message.data['event_name'] ??
          (_l10n?.notificationTypeEvent ?? 'Event'),
      'body': message.notification?.body ?? '',
      'type': message.data['type'] ?? 'event_promotion',
      'event_id': message.data['event_id'],
      'event_name': message.data['event_name'],
      'date_start': message.data['date_start'],
      'location': message.data['location'],
      'timestamp': DateTime.now().toIso8601String(),
    };

    groups.add(jsonEncode(notificationData));

    if (groups.length > 20) {
      groups.removeAt(0);
    }

    await prefs.setStringList(_notificationGroupKey, groups);
  }

  Future<int> _getNotificationCount() async {
    final prefs = await SharedPreferences.getInstance();
    final groups = prefs.getStringList(_notificationGroupKey) ?? [];
    return groups.length;
  }

  Future<void> _removeNotificationFromGroup(String eventId) async {
    final prefs = await SharedPreferences.getInstance();
    final groups = prefs.getStringList(_notificationGroupKey) ?? [];

    groups.removeWhere((item) {
      final data = jsonDecode(item);
      return data['event_id'] == eventId;
    });

    await prefs.setStringList(_notificationGroupKey, groups);

    if (groups.isEmpty) {
      await _localNotifications.cancel(_summaryNotificationId);
    } else if (groups.length > 1) {
      await _showGroupSummaryNotification(groups.length);
    }
  }

  void _onNotificationTapped(NotificationResponse response) async {
    if (response.payload != null) {
      try {
        final data = jsonDecode(response.payload!);
        if (data['event_id'] != null) {
          await clearEventNotification(data['event_id'].toString());
        }
        onNotificationTapped?.call(data);
      } catch (e) {
        debugPrint(e.toString());
      }
    }
  }

  void _handleBackgroundMessage(RemoteMessage message) async {
    if (message.data['event_id'] != null) {
      await clearEventNotification(message.data['event_id'].toString());
    }
    onNotificationTapped?.call(message.data);
  }

  Future<void> clearEventNotification(String eventId) async {
    try {
      final notificationId = int.tryParse(eventId) ?? eventId.hashCode;
      await _localNotifications.cancel(notificationId);
      await _removeNotificationFromGroup(eventId);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void onTokenRefresh(Function(String) callback) {
    _firebaseMessaging.onTokenRefresh.listen((String token) {
      callback(token);
    });
  }

  Future<void> subscribeToTopic(String topic) async {
    await _firebaseMessaging.subscribeToTopic(topic);
  }

  Future<void> unsubscribeFromTopic(String topic) async {
    await _firebaseMessaging.unsubscribeFromTopic(topic);
  }

  Future<void> deleteToken() async {
    await _firebaseMessaging.deleteToken();
    await clearAllNotifications();
  }

  Future<void> clearAllNotifications() async {
    await _localNotifications.cancelAll();
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_notificationGroupKey);
  }

  Future<void> clearNotification(int id) async {
    await _localNotifications.cancel(id);
  }
}
