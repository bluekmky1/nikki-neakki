import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../routes/routes.dart';
import '../common/widgets/bottom_navigation_bar_widget.dart';
import '../common/widgets/tab/segmented_tab_widget.dart';
import 'home_state.dart';
import 'home_view_model.dart';
import 'widgets/calendar_header_widget.dart';
import 'widgets/meal_list_section_widget.dart';
import 'widgets/one_line_calendar_widget.dart';
import 'widgets/summary_card_widget.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  ConsumerState<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final HomeState state = ref.watch(homeViewModelProvider);
    final HomeViewModel viewModel = ref.read(homeViewModelProvider.notifier);

    return Scaffold(
      bottomNavigationBar: BottomNavigationBarWidget(
        currentRouteName: Routes.home.name,
      ),
      body: CustomScrollView(
        slivers: <Widget>[
          CalendarHeaderWidget(
            isInDisplayWeek: state.isInDisplayWeek,
            selectedDate: state.selectedDate,
            displayWeekStartDate: state.displayWeekStartDate,
            onCalendarTap: () {
              showDatePicker(
                context: context,
                initialDate: state.selectedDate,
                firstDate: DateTime(1900),
                lastDate: DateTime.now(),
              ).then((DateTime? selectedDate) {
                if (selectedDate != null) {
                  viewModel.jumpToDate(date: selectedDate);
                }
              });
            },
          ),
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.fromLTRB(16, 6, 16, 0),
              child: OneLineCalendar(),
            ),
          ),
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: SummaryCardWidget(),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: SegmentedTabWidget(
                selectedTabIndex: state.selectedTabIndex,
                tabTitles: const <String>['내 끼니', '니 끼니'],
                onTabChanged: (int index) {
                  viewModel.onTabChanged(index: index);
                },
              ),
            ),
          ),
          MealListSectionWidget(
            hasPartner: state.hasPartner,
            selectedTabIndex: state.selectedTabIndex,
            myMeals: state.myMeals,
            otherMeals: state.otherMeals,
          ),
        ],
      ),
    );
  }
}
