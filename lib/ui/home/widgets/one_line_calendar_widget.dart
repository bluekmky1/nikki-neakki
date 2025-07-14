import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../theme/app_colors.dart';
import '../../../theme/app_text_styles.dart';
import '../../../util/date_time_formatter.dart';
import '../home_state.dart';
import '../home_view_model.dart';

class OneLineCalendar extends ConsumerStatefulWidget {
  const OneLineCalendar({
    super.key,
  });

  @override
  ConsumerState<OneLineCalendar> createState() => _OneLineCalendarState();
}

class _OneLineCalendarState extends ConsumerState<OneLineCalendar> {
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _getWeekPage(DateTime.now()));
  }

  int _getWeekPage(DateTime date) {
    // 1970년 1월 5일(월요일) 기준으로 몇 번째 주인지 계산
    final DateTime base = DateTime(1945, 12, 3);
    return date.difference(base).inDays ~/ 7;
  }

  List<DateTime> _getWeekDates(DateTime date) {
    // 해당 주의 월~일 날짜 리스트 반환
    final DateTime monday =
        date.subtract(Duration(days: (date.weekday + 6) % 7));
    return List<DateTime>.generate(7, (int i) => monday.add(Duration(days: i)));
  }

  @override
  Widget build(BuildContext context) {
    final HomeState state = ref.watch(homeViewModelProvider);
    final HomeViewModel viewModel = ref.read(homeViewModelProvider.notifier);

    return SizedBox(
      height: 60,
      child: PageView.builder(
        controller: _pageController,
        itemBuilder: (BuildContext context, int pageIndex) {
          final DateTime base = DateTime(1945, 12, 3);
          final DateTime weekStart = base.add(Duration(days: pageIndex * 7));
          final List<DateTime> weekDates = _getWeekDates(weekStart);

          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: weekDates.map((DateTime date) {
              final bool isSelected = date.year == state.selectedDate.year &&
                  date.month == state.selectedDate.month &&
                  date.day == state.selectedDate.day;

              final bool afterToday = date.isAfter(DateTime.now());
              return GestureDetector(
                onTap:
                    afterToday ? null : () => viewModel.selectDate(date: date),
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
                        '${date.day}', // 일자
                        style: AppTextStyles.textSb18.copyWith(
                          color: isSelected
                              ? AppColors.white
                              : afterToday
                                  ? AppColors.gray600
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
                                  ? AppColors.gray600
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
        onPageChanged: (int pageIndex) {
          // 페이지 이동 시, 선택 날짜를 해당 주의 월요일로 변경
          final DateTime base = DateTime(1945, 12, 3);
          final DateTime weekStart = base.add(Duration(days: pageIndex * 7));
          viewModel.changeDisplayWeekStartDate(date: weekStart);
        },
      ),
    );
  }
}
