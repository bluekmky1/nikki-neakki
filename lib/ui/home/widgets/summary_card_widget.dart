import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/meal/model/meal_model.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/app_text_styles.dart';
import '../../../util/date_time_formatter.dart';
import '../home_state.dart';
import '../home_view_model.dart';

class MealTimelineBar extends ConsumerStatefulWidget {
  final List<MealModel> myMeals;
  final List<MealModel> otherMeals;

  const MealTimelineBar({
    required this.myMeals,
    required this.otherMeals,
    super.key,
  });

  @override
  ConsumerState<MealTimelineBar> createState() => _MealTimelineBarState();
}

class _MealTimelineBarState extends ConsumerState<MealTimelineBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  double _timeToFraction(TimeOfDay time) => (time.hour + time.minute / 60) / 24;

  @override
  Widget build(BuildContext context) {
    const double timelineWidth = 1500; // 0~24시를 넓게 잡아 스크롤 가능하게
    const double barHeight = 48;
    const double barTop = 32;
    const double dotRadius = 24;
    final TimeOfDay now = TimeOfDay.now();
    final double nowFraction = _timeToFraction(now);
    const double marginHorizontal = 56;
    final HomeState state = ref.watch(homeViewModelProvider);
    return SizedBox(
      // 높이 조절 (타임라인 높이 + 시간 라벨 높이)
      height: barTop + barHeight + 65,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SizedBox(
          width: timelineWidth,
          child: Stack(
            children: <Widget>[
              // 1. 전체 타임라인(연한 회색, 두꺼운 막대)
              Positioned(
                left: 0,
                top: barTop,
                width: timelineWidth,
                height: barHeight,
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 56),
                  decoration: BoxDecoration(
                    color: AppColors.gray200,
                    borderRadius: BorderRadius.circular(barHeight / 2),
                  ),
                ),
              ),
              // 2. 지나간 시간(메인 컬러로 채움)
              Positioned(
                left: 0,
                top: barTop,
                width: timelineWidth,
                height: barHeight,
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 56),
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(barHeight / 2),
                  ),
                  child: Row(
                    children: <Widget>[
                      Container(
                        width: state.isToday
                            ? (timelineWidth - 2 * marginHorizontal) *
                                nowFraction
                            : timelineWidth - 2 * marginHorizontal,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: <Color>[
                              AppColors.main.withValues(alpha: 0.2),
                              AppColors.main,
                              AppColors.sub
                            ],
                          ),
                          borderRadius: BorderRadius.horizontal(
                            left: const Radius.circular(barHeight / 2),
                            right: nowFraction == 1.0
                                ? const Radius.circular(barHeight / 2)
                                : Radius.zero,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // 식사 위치 점 + 시간
              ...widget.myMeals.map(
                (MealModel meal) {
                  final double fraction =
                      _timeToFraction(TimeOfDay.fromDateTime(meal.mealTime));
                  final double left = (marginHorizontal +
                          fraction * (timelineWidth - 2 * marginHorizontal) -
                          dotRadius)
                      .clamp(marginHorizontal - dotRadius,
                          timelineWidth - marginHorizontal - dotRadius);
                  return Stack(
                    children: <Widget>[
                      // 나
                      Positioned(
                        left: left,
                        top: barTop - dotRadius,
                        child: Container(
                          width: dotRadius * 2,
                          height: dotRadius * 2,
                          decoration: BoxDecoration(
                            color: AppColors.deepMain,
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 2),
                          ),
                          child: Center(
                            child: Text(
                              meal.mealType.name,
                              style: AppTextStyles.textR12.copyWith(
                                color: AppColors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      // 상대
                    ],
                  );
                },
              ),

              ...widget.otherMeals.map(
                (MealModel meal) {
                  final double fraction =
                      _timeToFraction(TimeOfDay.fromDateTime(meal.mealTime));

                  final double left = (marginHorizontal +
                          fraction * (timelineWidth - 2 * marginHorizontal) -
                          dotRadius)
                      .clamp(marginHorizontal - dotRadius,
                          timelineWidth - marginHorizontal - dotRadius);
                  return Stack(
                    children: <Widget>[
                      // 나
                      Positioned(
                        left: left,
                        top: barTop + dotRadius,
                        child: Container(
                          width: dotRadius * 2,
                          height: dotRadius * 2,
                          decoration: BoxDecoration(
                            color: AppColors.sub,
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 2),
                          ),
                          child: Center(
                            child: Text(
                              meal.mealType.name,
                              style: AppTextStyles.textR12.copyWith(
                                color: AppColors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      // 상대
                    ],
                  );
                },
              ),
              // 시간 라벨 (0, 6, 12, 18, 24)
              Positioned(
                left: 0,
                top: barTop + barHeight + 48,
                width: timelineWidth,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 56),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List<Widget>.generate(
                      13,
                      (int index) {
                        if (index == 0) {
                          return const SizedBox.shrink();
                        }
                        return Text(
                          (index * 2).toString(),
                          style: AppTextStyles.textR12.copyWith(
                            color: AppColors.gray500,
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SummaryCardWidget extends ConsumerWidget {
  const SummaryCardWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final HomeState state = ref.watch(homeViewModelProvider);
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.gray900,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.white, width: 3),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: AppColors.gray900.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
            child: Row(
              children: <Widget>[
                Text(
                  '''${state.isToday ? '오늘의' : DateTimeFormatter.yearMonthDayFormat(state.selectedDate)} 밥 시간''',
                  style: AppTextStyles.textB18.copyWith(
                    color: AppColors.white,
                  ),
                ),
                const Spacer(),
                Container(
                  width: 16,
                  height: 16,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.deepMain,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  '나',
                  style: AppTextStyles.textR14.copyWith(
                    color: AppColors.white,
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  width: 16,
                  height: 16,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.sub,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  '상대',
                  style: AppTextStyles.textR14.copyWith(
                    color: AppColors.white,
                  ),
                ),
              ],
            ),
          ),
          // 식사 시간 타임라인 추가
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 16),
            child: MealTimelineBar(
              myMeals: state.myMeals,
              otherMeals: state.otherMeals,
            ),
          ),
        ],
      ),
    );
  }
}
