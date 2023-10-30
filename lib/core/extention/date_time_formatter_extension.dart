import 'package:intl/intl.dart';

extension DateTimeFormatterExtension on DateTime {
  /// 10-05-2023
  String ddMMyyyy([String d = '-']) {
    return DateFormat('dd${d}MM${d}yyyy', 'id_ID').format(this);
  }

  /// 10-05-23
  String ddMMyy([String d = '-']) {
    return DateFormat('dd${d}MM${d}yy', 'id_ID').format(this);
  }

  /// 10-Mei-2023
  String ddMMMyyyy([String d = '-']) {
    return DateFormat('dd${d}MMM${d}yyyy', 'id_ID').format(this);
  }

  /// Kamis, 15-April-2021
  String eeeeddMMMMyyyy([String d = '-']) {
    return DateFormat('EEEE, dd${d}MMMM${d}yyyy', 'id_ID').format(this);
  }

  /// 23-05-25
  String yyMMdd([String d = '-']) {
    return DateFormat('yy${d}MM${d}dd', 'id_ID').format(this);
  }

  /// 2023-06-32
  String yyyyMMdd([String d = '-']) =>
      DateFormat('yyyy${d}MM${d}dd', 'id_ID').format(this);

  /// 32
  String dd() => DateFormat('dd', 'id_ID').format(this);

  /// 1-Okt-2023, 19:30
  String dMMMyyyyHHmm({
    String dateDelimiter = '-',
    String timeDelimiter = ':',
    String dateTimeDelimiter = ', ',
  }) {
    final d = dateDelimiter;
    final t = timeDelimiter;
    final dt = dateTimeDelimiter;
    return DateFormat('d${d}MMM${d}yyyy${dt}HH${t}mm', 'id_ID').format(this);
  }

  /// 1-Okt-2023
  String dMMMyyyy([String d = '-']) {
    return DateFormat('d${d}MMM${d}yyyy', 'id_ID').format(this);
  }

  /// 10-Oktober-2023
  String ddMMMMyyyy({
    String dateDelimiter = '-',
  }) {
    final d = dateDelimiter;
    return DateFormat('dd${d}MMMM${d}yyyy', 'id_ID').format(this);
  }

  /// 10-Oktober-2023
  String mMMMMyyyy({
    String dateDelimiter = '-',
  }) {
    final d = dateDelimiter;
    return DateFormat('MMMM${d}yyyy', 'id_ID').format(this);
  }

  /// 15:00
  String hHmm({
    String delimiter = ':',
  }) {
    final d = delimiter;
    return DateFormat('HH${d}mm', 'id_ID').format(this);
  }

  /// Senin
  String eEEE() {
    return DateFormat('EEEE', 'id_ID').format(this);
  }

  /// ISO-8601 Local Timezone
  /// 2023-05-29T10:35:23+07:00
  String toLocalIso8601WithTimeZone() {
    final offset = toLocal().timeZoneOffsetRfc822(':');
    final df = DateFormat('yyyy-MM-ddTHH:mm:ss', 'id_ID');
    return df.format(toLocal()) + offset;
  }

  /// Rfc 822 Duration
  /// +/-HHmm -> +0700 or -0530
  /// when delimiter is added, it is no longer Rfc 822
  String timeZoneOffsetRfc822([String d = '']) {
    var offset = timeZoneOffset;
    final h = offset.inHours.twoDigits;
    final m = (offset.inMinutes - (offset.inHours * 60)).twoDigits;
    final o = offset.isNegative ? '-' : '+';

    return '$o$h$d$m';
  }
}

int? getRangeDurationTimeStampFromNow(String timeStamp) {
  if (timeStamp.isEmpty) {
    return null;
  }
  DateTime dateTime = DateTime.parse(timeStamp);
  return dateTime.difference(DateTime.now()).inSeconds;
}

String intervalSecondToMinuteString(int interval) {
  int minutes, seconds;
  minutes = interval ~/ 60;
  seconds = interval % 60;
  return '${minutes.twoDigits}:${seconds.twoDigits}';
}

extension _Formatter on int {
  String get twoDigits => toString().padLeft(2, '0');
}
