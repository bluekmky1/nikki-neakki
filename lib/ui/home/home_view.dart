import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../domain/meal/model/meal_model.dart';
import '../../routes/routes.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_text_styles.dart';
import '../../util/date_time_formatter.dart';
import '../common/consts/meal_type.dart';
import '../common/widgets/bottom_navigation_bar_widget.dart';
import 'home_state.dart';
import 'home_view_model.dart';
import 'widgets/add_food_card_widget.dart';
import 'widgets/food_card_widget.dart';
import 'widgets/one_line_calendar_widget.dart';
import 'widgets/summary_card_widget.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  ConsumerState<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  @override
  Widget build(BuildContext context) {
    final HomeState state = ref.watch(homeViewModelProvider);
    final HomeViewModel viewModel = ref.read(homeViewModelProvider.notifier);
    final bool isInDisplayWeek = !state.selectedDate
            .isBefore(state.displayWeekStartDate) &&
        !state.selectedDate
            .isAfter(state.displayWeekStartDate.add(const Duration(days: 6)));
    return Scaffold(
      bottomNavigationBar: BottomNavigationBarWidget(
        currentRouteName: Routes.home.name,
      ),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            centerTitle: true,
            title: Text(
              isInDisplayWeek
                  ? DateTimeFormatter.yearMonthFormat(state.selectedDate)
                  : DateTimeFormatter.yearMonthFormat(
                      state.displayWeekStartDate),
              style: AppTextStyles.textSb22.copyWith(
                color: AppColors.gray900,
              ),
            ),
            actions: <Widget>[
              IconButton(
                onPressed: () {
                  showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1900),
                    lastDate: DateTime.now(),
                  );
                },
                icon: const Icon(Icons.today),
              ),
            ],
          ),
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.fromLTRB(16, 6, 16, 0),
              child: OneLineCalendar(),
            ),
          ),
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.fromLTRB(16, 16, 16, 10),
              child: SummaryCardWidget(),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: SegmentedTab(
                selectedIndex: state.selectedTabIndex,
                labels: const <String>['내 음식', '니 음식'],
                onTabChanged: (int index) {
                  viewModel.onTabChanged(index: index);
                },
              ),
            ),
          ),
          if (state.selectedTabIndex == 0)
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: <Widget>[
                    const SizedBox(height: 8),
                    ...List<Widget>.generate(
                      MealType.values.length,
                      (int index) {
                        if (state.myMeals.any((MealModel meal) =>
                            meal.mealType == MealType.values[index])) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 16),
                            child: FoodCardWidget(
                              title: MealType.values[index].name,
                              foods: state.myMeals
                                  .firstWhere((MealModel meal) =>
                                      meal.mealType == MealType.values[index])
                                  .foods,
                            ),
                          );
                        } else {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 16),
                            child: AddFoodCardWidget(
                              title: MealType.values[index].name,
                              onTap: () {
                                context.pushNamed(Routes.recordFood.name);
                              },
                            ),
                          );
                        }
                      },
                    ),
                    const SizedBox(height: 50),
                  ],
                ),
              ),
            ),
          if (state.selectedTabIndex == 1)
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: <Widget>[
                    const SizedBox(height: 8),
                    ...List<Widget>.generate(
                      MealType.values.length,
                      (int index) {
                        if (state.otherMeals.any((MealModel meal) =>
                            meal.mealType == MealType.values[index])) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 16),
                            child: FoodCardWidget(
                              title: MealType.values[index].name,
                              foods: state.otherMeals
                                  .firstWhere((MealModel meal) =>
                                      meal.mealType == MealType.values[index])
                                  .foods,
                            ),
                          );
                        } else {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 16),
                            child: AddFoodCardWidget(
                              title: MealType.values[index].name,
                              onTap: () {
                                context.pushNamed(Routes.recordFood.name);
                              },
                            ),
                          );
                        }
                      },
                    ),
                    const SizedBox(height: 50),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class SegmentedTab extends ConsumerWidget {
  final int selectedIndex;
  final List<String> labels;
  final Function(int) onTabChanged;

  const SegmentedTab({
    required this.selectedIndex,
    required this.labels,
    required this.onTabChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) => Container(
        height: 48,
        decoration: BoxDecoration(
          color: AppColors.gray350,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Stack(
          children: <Widget>[
            // 움직이는 흰색 상자
            AnimatedAlign(
              alignment: selectedIndex == 0
                  ? Alignment.centerLeft
                  : Alignment.centerRight,
              duration: const Duration(milliseconds: 200),
              curve: Curves.ease,
              child: FractionallySizedBox(
                widthFactor: 0.5,
                heightFactor: 1.0,
                child: Container(
                  margin: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: AppColors.gray500.withValues(alpha: 0.2),
                        blurRadius: 2,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // 텍스트 버튼
            Row(
              children: List<Widget>.generate(labels.length, (int index) {
                final bool isSelected = index == selectedIndex;
                return Expanded(
                  child: GestureDetector(
                    onTap: () => onTabChanged(index),
                    behavior: HitTestBehavior.translucent,
                    child: Container(
                      height: double.infinity,
                      alignment: Alignment.center,
                      child: Text(
                        labels[index],
                        style: AppTextStyles.textSb16.copyWith(
                          color: isSelected
                              ? AppColors.gray900
                              : AppColors.gray700,
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),
          ],
        ),
      );
}
