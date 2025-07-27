import 'package:flutter/material.dart';

import '../../../../theme/app_colors.dart';
import '../../../../theme/app_text_styles.dart';
import '../../../../util/date_time_formatter.dart';

class WeekCalendarWidget extends StatefulWidget {
  const WeekCalendarWidget({
    required this.selectedDate,
    required this.onDateSelected,
    this.height = 60.0,
    this.disableFutureDates = true,
    super.key,
  });

  final DateTime selectedDate;
  final ValueChanged<DateTime> onDateSelected;
  final double height;
  final bool disableFutureDates;

  @override
  State<WeekCalendarWidget> createState() => _WeekCalendarWidgetState();
}

class _WeekCalendarWidgetState extends State<WeekCalendarWidget> {
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _getWeekPage(DateTime.now()));
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  int _getWeekPage(DateTime date) {
    final DateTime base = DateTime(1945, 12, 3);
    return date.difference(base).inDays ~/ 7;
  }

  List<DateTime> _getWeekDates(DateTime date) {
    final DateTime monday =
        date.subtract(Duration(days: (date.weekday + 6) % 7));
    return List<DateTime>.generate(7, (int i) => monday.add(Duration(days: i)));
  }

  @override
  Widget build(BuildContext context) => SizedBox(
        height: widget.height,
        child: PageView.builder(
          controller: _pageController,
          itemBuilder: (BuildContext context, int pageIndex) {
            final DateTime base = DateTime(1945, 12, 3);
            final DateTime weekStart = base.add(Duration(days: pageIndex * 7));
            final List<DateTime> weekDates = _getWeekDates(weekStart);

            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: weekDates.map((DateTime date) {
                final bool isSelected = date.year == widget.selectedDate.year &&
                    date.month == widget.selectedDate.month &&
                    date.day == widget.selectedDate.day;

                final bool afterToday =
                    widget.disableFutureDates && date.isAfter(DateTime.now());

                return GestureDetector(
                  onTap: afterToday ? null : () => widget.onDateSelected(date),
                  behavior: afterToday
                      ? HitTestBehavior.opaque
                      : HitTestBehavior.translucent,
                  child: Container(
                    width: MediaQuery.of(context).size.width / 9,
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    decoration: isSelected
                        ? BoxDecoration(
                            color: AppColors.main,
                            borderRadius: BorderRadius.circular(8),
                          )
                        : null,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          '${date.day}',
                          style: AppTextStyles.textSb18.copyWith(
                            color: isSelected
                                ? AppColors.white
                                : afterToday
                                    ? AppColors.gray500
                                    : AppColors.gray900,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          DateTimeFormatter.formatWeekDay(date),
                          style: AppTextStyles.textM14.copyWith(
                            color: isSelected
                                ? AppColors.white
                                : afterToday
                                    ? AppColors.gray500
                                    : AppColors.gray900,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            );
          },
        ),
      );
}
