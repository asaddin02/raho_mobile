import 'dart:ui';
import 'package:flutter/cupertino.dart';

// Media Query
class Screen {
  static double get height =>
      PlatformDispatcher.instance.views.first.physicalSize.height /
      PlatformDispatcher.instance.views.first.devicePixelRatio;

  static double get width =>
      PlatformDispatcher.instance.views.first.physicalSize.width /
      PlatformDispatcher.instance.views.first.devicePixelRatio;
}

// Capitalize Case
String capitalizeWord(String? text) {
  if (text == null || text.isEmpty) return '';

  return text
      .split(' ')
      .map((word) => word.isNotEmpty
          ? '${word[0].toUpperCase()}${word.substring(1).toLowerCase()}'
          : '')
      .join();
}

// Logger
class Logger {
  static void log(String message, {String? tag}) {
    final timestamp = DateTime.now().toString();
    final logMessage = '[$timestamp]${tag != null ? '[$tag]' : ''} $message';
    debugPrint(logMessage);
  }
}
