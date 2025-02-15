import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

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

// Prefix Number Phone
final List<String> commonPhonePrefixes = [
  "+1",
  "+44",
  "+62",
  "+91",
  "+86",
  "+81",
  "+49",
  "+33",
  "+39",
  "+55",
  "+34",
  "+61",
  "+61",
  "+52",
  "+27",
  "+7",
  "+60",
  "+63",
  "+91",
  "+971",
  "+965",
  "+974",
  "+973",
  "+971",
  "+54",
  "+53",
  "+98",
  "+234",
  "+254",
];

// Remove All Routes
void clearAndNavigate(String path, BuildContext context) {
  while (context.canPop() == true) {
    context.pop();
  }
  context.pushReplacement(path);
}

// Format Text for Diagnosis Page
String formatBulletPoints(String text) {
  if (text.isEmpty) return '';

  List<String> lines = text.split('\n');
  List<String> formattedLines = [];
  String currentMainPoint = '';
  List<String> subPoints = [];

  for (int i = 0; i < lines.length; i++) {
    String line = lines[i].trim();

    if (line.isEmpty) continue;

    if (line.startsWith('-')) {
      subPoints.add(line.substring(1).trim());
    } else {
      if (currentMainPoint.isNotEmpty) {
        formattedLines.add('• $currentMainPoint');
        for (String subPoint in subPoints) {
          formattedLines.add('    - $subPoint');
        }
        subPoints = [];
      }
      currentMainPoint = line;
    }

    if (i == lines.length - 1 && currentMainPoint.isNotEmpty) {
      formattedLines.add('• $currentMainPoint');
      for (String subPoint in subPoints) {
        formattedLines.add('    - $subPoint');
      }
    }
  }

  return formattedLines.join('\n');
}

// Format date to default
DateTime formatToDefault(String dateString) {
  DateTime date = DateFormat("dd-MM-yyyy").parse(dateString);
  return date;
}
