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
}
