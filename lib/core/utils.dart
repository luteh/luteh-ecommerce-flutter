import 'dart:math';

import 'package:intl/intl.dart';

String generateRandomString({
  required int length,
}) {
  const String validChars = 'abcdefghijklmnopqrstuvwxyz0123456789';
  final Random random = Random();
  String result = '';

  for (int i = 0; i < length; i++) {
    final int randomIndex = random.nextInt(validChars.length);
    result += validChars[randomIndex];
  }

  return result;
}

const String patternDateOnly = 'yyyy/MM/dd';
const String patternDayOnly = 'EEE';

String formattedCurrentDate({required String pattern}) {
  DateTime now = DateTime.now();

  return DateFormat(pattern).format(now);
}

String formattedDate({
  required String pattern,
  required DateTime date,
}) {
  return DateFormat(pattern).format(date);
}
