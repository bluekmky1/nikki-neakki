import 'package:intl/intl.dart';

class DateTimeFormatter {
  static String yearMonthFormat(DateTime dateTime) =>
      DateFormat('yyyy년 MM월').format(dateTime);

  static String yearMonthDayFormat(DateTime dateTime) =>
      DateFormat('yy.MM.dd').format(dateTime);

  static String formatWeekDay(DateTime dateTime) {
    final int weekday = dateTime.weekday;
    switch (weekday) {
      case 1:
        return '월';
      case 2:
        return '화';
      case 3:
        return '수';
      case 4:
        return '목';
      case 5:
        return '금';
      case 6:
        return '토';
      case 7:
        return '일';
      default:
        return '';
    }
  }

  static String fullDateTimeFormat(DateTime dateTime) =>
      DateFormat('yyyy년 MM월 dd일 HH:mm').format(dateTime);

  static String dateTimeFormat(DateTime dateTime) =>
      DateFormat('MM월 dd일').format(dateTime);

  static String timeFormat(DateTime dateTime) =>
      DateFormat('HH:mm').format(dateTime);

  static String timeFormatWithAmPm(DateTime dateTime) =>
      DateFormat('a h:mm', 'ko').format(dateTime);

  static String formatExpiryDate(DateTime? dateTime) {
    if (dateTime == null) {
      return '7일 후 만료';
    }

    final DateTime now = DateTime.now();
    final int difference = dateTime.difference(now).inDays;
    final String formattedDate =
        '''${dateTime.year}.${dateTime.month.toString().padLeft(2, '0')}.${dateTime.day.toString().padLeft(2, '0')}''';

    if (difference <= 0) {
      return '만료됨';
    } else if (difference == 1) {
      return '내일 만료 ($formattedDate)';
    } else {
      return '$difference일 후 만료 ($formattedDate)';
    }
  }
}
