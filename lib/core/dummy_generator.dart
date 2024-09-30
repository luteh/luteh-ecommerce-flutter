import 'dart:math';

import 'package:intl/intl.dart';

class DummyGenerator {
  const DummyGenerator._();

  static final List<String> loremIpsumWords = [
    'lorem',
    'ipsum',
    'dolor',
    'sit',
    'amet',
    'consectetur',
    'adipiscing',
    'elit',
    'sed',
    'do',
    'eiusmod',
    'tempor',
    'incididunt',
    'ut',
    'labore',
    'et',
    'dolore',
    'magna',
    'aliqua',
    'ut',
    'enim',
    'ad',
    'minim',
    'veniam',
    'quis',
    'nostrud',
    'exercitation',
    'ullamco',
    'laboris',
    'nisi',
    'ut',
    'aliquip',
    'ex',
    'ea',
    'commodo',
    'consequat',
    'duis',
    'aute',
    'irure',
    'dolor',
    'in',
    'reprehenderit',
    'in',
    'voluptate',
    'velit',
    'esse',
    'cillum',
    'dolore',
    'eu',
    'fugiat',
    'nulla',
    'pariatur',
    'excepteur',
    'sint',
    'occaecat',
    'cupidatat',
    'non',
    'proident',
    'sunt',
    'in',
    'culpa',
    'qui',
    'officia',
    'deserunt',
    'mollit',
    'anim',
    'id',
    'est',
    'laborum'
  ];

  /// Generates a lorem ipsum text with a specified number of words
  static String generateLoremIpsum(int wordsCount) {
    final random = Random();
    return '${List.generate(wordsCount, (_) => loremIpsumWords[random.nextInt(loremIpsumWords.length)]).join(' ').replaceFirstMapped(RegExp(r'^\w'), (match) => match.group(0)!.toUpperCase())}.';
  }

  /// Generates a random date in the format "YYYY-MM-DDThh:mm:ssTZD" (ISO 8601 format)
  static String generateRandomDate() {
    final randomDateTime = generateRandomLocalDateTime();
    return formatDateTimeToUTC(randomDateTime);
  }

  static DateTime generateRandomLocalDateTime() {
    final random = Random();
    final randomYear = random.nextInt(2025 - 2020) + 2020;
    final randomMonth = random.nextInt(12) + 1;

    final maxDay = DateTime(randomYear, randomMonth + 1, 0)
        .day; // Get correct number of days in month
    final randomDay = random.nextInt(maxDay) + 1;

    final randomHour = random.nextInt(24);
    final randomMinute = random.nextInt(60);
    final randomSecond = random.nextInt(60);

    return DateTime(randomYear, randomMonth, randomDay, randomHour,
        randomMinute, randomSecond);
  }

  /// Formats the DateTime into UTC (ISO 8601 format)
  static String formatDateTimeToUTC(DateTime dateTime) {
    final DateFormat formatter = DateFormat("yyyy-MM-dd'T'HH:mm:ssXXX");
    return formatter.format(dateTime.toUtc());
  }
}
