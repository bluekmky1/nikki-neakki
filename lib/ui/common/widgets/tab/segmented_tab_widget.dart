import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../theme/app_colors.dart';
import '../../../../theme/app_text_styles.dart';

class SegmentedTabWidget extends ConsumerWidget {
  final int selectedTabIndex;
  final Function(int) onTabChanged;
  final List<String> tabTitles;

  const SegmentedTabWidget({
    required this.selectedTabIndex,
    required this.onTabChanged,
    required this.tabTitles,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final int tabCount = tabTitles.length;
    final double alignmentX =
        tabCount == 1 ? 0 : -1 + 2 * (selectedTabIndex / (tabCount - 1));
    final double widthFactor = 1 / tabCount;
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
            alignment: Alignment(alignmentX, 0),
            duration: const Duration(milliseconds: 200),
            curve: Curves.ease,
            child: FractionallySizedBox(
              widthFactor: widthFactor,
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
            children: List<Widget>.generate(tabTitles.length, (int index) {
              final bool isSelected = index == selectedTabIndex;
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
