import 'package:intl/intl.dart';

class DateTimeFormatter {
  static String getWrittenTime(DateTime dateTime) {
    final Duration difference = DateTime.now().difference(dateTime);
    if (difference.inDays > 0) {
      return DateFormat('yy.MM.dd').format(dateTime);
    }
    if (difference.inHours > 0) {
      return '${difference.inHours}시간 전';
    }
    if (difference.inMinutes > 0) {
      return '${difference.inMinutes}분 전';
    }
    return '방금 전';
  }

  static String getDate(DateTime dateTime) =>
      DateFormat('yy.MM.dd').format(dateTime);

  /// 상대적인 시간 표시 (예: "3시간 전", "5일 전")
  static String formatRelativeTime(DateTime dateTime) {
    final Duration difference = DateTime.now().difference(dateTime);

    if (difference.inDays > 30) {
      return DateFormat('yy.MM.dd').format(dateTime);
    }
    if (difference.inDays > 0) {
      return '${difference.inDays}일 전';
    }
    if (difference.inHours > 0) {
      return '${difference.inHours}시간 전';
    }
    if (difference.inMinutes > 0) {
      return '${difference.inMinutes}분 전';
    }
    return '방금 전';
  }

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
}
