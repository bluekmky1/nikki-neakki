import 'package:flutter/material.dart';

import '../../../theme/app_colors.dart';
import '../../../theme/app_text_styles.dart';
import '../../../util/date_time_formatter.dart';

class CalendarHeaderWidget extends StatelessWidget {
  final bool isInDisplayWeek;
  final DateTime selectedDate;
  final DateTime displayWeekStartDate;
  final VoidCallback? onCalendarTap;

  const CalendarHeaderWidget({
    required this.isInDisplayWeek,
    required this.selectedDate,
    required this.displayWeekStartDate,
    super.key,
    this.onCalendarTap,
  });

  @override
  Widget build(BuildContext context) => SliverAppBar(
        centerTitle: true,
        title: Text(
          isInDisplayWeek
              ? DateTimeFormatter.yearMonthFormat(selectedDate)
              : DateTimeFormatter.yearMonthFormat(displayWeekStartDate),
          style: AppTextStyles.textSb22.copyWith(
            color: AppColors.gray900,
          ),
        ),
        actions: <Widget>[
          IconButton(
            onPressed: onCalendarTap,
            style: IconButton.styleFrom(
              foregroundColor: AppColors.gray900,
            ),
            icon: const Icon(Icons.today_rounded),
          ),
        ],
      );
}
