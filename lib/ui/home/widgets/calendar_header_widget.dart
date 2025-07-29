import 'package:flutter/material.dart';

import '../../../theme/app_colors.dart';
import '../../../theme/app_text_styles.dart';
import '../../../util/date_time_formatter.dart';

class CalendarHeaderWidget extends StatelessWidget {
  final bool isInDisplayWeek;
  final DateTime selectedDate;
  final DateTime displayWeekStartDate;
  final VoidCallback? onCalendarTap;
  final VoidCallback? onTodayTap;

  const CalendarHeaderWidget({
    required this.isInDisplayWeek,
    required this.selectedDate,
    required this.displayWeekStartDate,
    super.key,
    this.onCalendarTap,
    this.onTodayTap,
  });

  @override
  Widget build(BuildContext context) => SliverAppBar(
        centerTitle: false,
        title: Text(
          isInDisplayWeek
              ? DateTimeFormatter.yearMonthFormat(selectedDate)
              : DateTimeFormatter.yearMonthFormat(displayWeekStartDate),
          style: AppTextStyles.textSb22.copyWith(
            color: AppColors.gray900,
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: onTodayTap,
            style: TextButton.styleFrom(
              foregroundColor: AppColors.gray600,
            ),
            child: Text(
              '오늘',
              style: AppTextStyles.textM16.copyWith(
                color: AppColors.gray900,
              ),
            ),
          ),
          IconButton(
            onPressed: onCalendarTap,
            style: IconButton.styleFrom(
              foregroundColor: AppColors.gray900,
            ),
            icon: const Icon(
              Icons.event,
              size: 24,
              color: AppColors.gray900,
            ),
          ),
        ],
      );
}
