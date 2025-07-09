import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../routes/routes.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_text_styles.dart';
import '../common/widgets/bottom_navigation_bar_widget.dart';
import 'home_state.dart';
import 'home_view_model.dart';
import 'widgets/food_card_widget.dart';
import 'widgets/one_line_calendar_widget.dart';
import 'widgets/summary_card_widget.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  ConsumerState<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  final PageController _pageController = PageController();

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
          SliverAppBar(
            title: Text(
              '2025년 7월',
              style: AppTextStyles.textSb22.copyWith(
                color: AppColors.gray900,
              ),
            ),
            actions: <Widget>[
              IconButton(
                onPressed: () {
                  context.goNamed(Routes.login.name);
                },
                icon: const Icon(Icons.person),
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 6, 16, 0),
              child: OneLineCalendar(
                initialDate: DateTime.now(),
                onDateSelected: (DateTime date) {},
              ),
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

                  _pageController.animateToPage(
                    index,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                },
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 850,
              child: PageView.builder(
                itemCount: 2,
                controller: _pageController,
                onPageChanged: (int index) {
                  viewModel.onTabChanged(index: index);
                },
                itemBuilder: (BuildContext context, int index) => const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: <Widget>[
                      FoodCardWidget(
                        title: '아침',
                        description: '알리오 올리오',
                      ),
                      SizedBox(height: 16),
                      FoodCardWidget(
                        title: '점심',
                        description: '알리오 올리오',
                      ),
                      SizedBox(height: 16),
                      FoodCardWidget(
                        title: '저녁',
                        description: '알리오 올리오',
                      ),
                    ],
                  ),
                ),
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
