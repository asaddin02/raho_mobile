import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

// Capitalize Case
String capitalizeWord(String? text) {
  if (text == null || text.isEmpty) return '';

  return text
      .split(' ')
      .map(
        (word) => word.isNotEmpty
            ? '${word[0].toUpperCase()}${word.substring(1).toLowerCase()}'
            : '',
      )
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

// Bold on text
Widget richTextFromIntl({
  required String text,
  required Map<String, TextStyle> highlight,
  TextStyle? defaultStyle,
  TextAlign? textAlign,
}) {
  final spans = <TextSpan>[];

  int currentIndex = 0;

  final sortedHighlights = highlight.entries.toList()
    ..sort((a, b) => text.indexOf(a.key).compareTo(text.indexOf(b.key)));

  for (final entry in sortedHighlights) {
    final key = entry.key;
    final style = entry.value;
    final index = text.indexOf(key, currentIndex);

    if (index == -1) continue;

    if (index > currentIndex) {
      spans.add(
        TextSpan(
          text: text.substring(currentIndex, index),
          style: defaultStyle,
        ),
      );
    }

    spans.add(TextSpan(text: key, style: style));

    currentIndex = index + key.length;
  }

  if (currentIndex < text.length) {
    spans.add(
      TextSpan(text: text.substring(currentIndex), style: defaultStyle),
    );
  }

  return Text.rich(
    TextSpan(children: spans, style: defaultStyle),
    textAlign: textAlign,
  );
}

// Format Date
String formatDate(String date, BuildContext context) {
  try {
    final DateTime dateTime = DateTime.parse(date);
    final locale = Localizations.localeOf(context).toString();
    return DateFormat.yMMMMd(locale).format(dateTime);
  } catch (e) {
    return date;
  }
}

// Format Currency
String formatCurrency(double amount) {
  return amount
      .toStringAsFixed(0)
      .replaceAllMapped(
    RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
        (Match m) => '${m[1]}.',
  );
}

