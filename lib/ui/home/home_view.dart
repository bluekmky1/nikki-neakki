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
import '../common/widgets/tab/segmented_tab_widget.dart';
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
                style: IconButton.styleFrom(
                  foregroundColor: AppColors.gray900,
                ),
                icon: const Icon(Icons.today_rounded),
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
              child: SegmentedTabWidget(
                tabTitles: const <String>['내 음식', '니 음식'],
                onTabChanged: (int index) {
                  viewModel.onTabChanged(index: index);
                },
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: <Widget>[
                  const SizedBox(height: 8),
                  ..._buildMealList(
                    meals: state.selectedTabIndex == 0
                        ? state.myMeals
                        : state.otherMeals,
                    context: context,
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

  List<Widget> _buildMealList({
    required List<MealModel> meals,
    required BuildContext context,
  }) =>
      List<Widget>.generate(
        MealType.values.length,
        (int index) {
          if (meals.any(
            (MealModel meal) => meal.mealType == MealType.values[index],
          )) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: FoodCardWidget(
                title: MealType.values[index].name,
                foods: meals
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
      );
}
