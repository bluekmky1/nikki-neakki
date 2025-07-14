import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../theme/app_colors.dart';
import '../../../../theme/app_text_styles.dart';
import '../../../home/home_state.dart';
import '../../../home/home_view_model.dart';

class SegmentedTabWidget extends ConsumerWidget {
  final Function(int) onTabChanged;
  final List<String> tabTitles;

  const SegmentedTabWidget({
    required this.onTabChanged,
    required this.tabTitles,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final HomeState state = ref.watch(homeViewModelProvider);
    return Container(
      height: 56,
      decoration: BoxDecoration(
        color: AppColors.gray350,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Stack(
        children: <Widget>[
          // 움직이는 흰색 상자
          AnimatedAlign(
            alignment: state.selectedTabIndex == 0
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
                  color: AppColors.white,
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
            children: List<Widget>.generate(2, (int index) {
              final bool isSelected = index == state.selectedTabIndex;
              return Expanded(
                child: GestureDetector(
                  onTap: () => onTabChanged(index),
                  behavior: HitTestBehavior.translucent,
                  child: Container(
                    height: double.infinity,
                    alignment: Alignment.center,
                    child: Text(
                      tabTitles[index],
                      style: AppTextStyles.textSb16.copyWith(
                        color:
                            isSelected ? AppColors.gray900 : AppColors.gray700,
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
}
