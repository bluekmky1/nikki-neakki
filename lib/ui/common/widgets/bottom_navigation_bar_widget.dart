import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../routes/routes.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/app_text_styles.dart';

class BottomNavigationBarWidget extends ConsumerStatefulWidget {
  const BottomNavigationBarWidget({
    required this.currentRouteName,
    super.key,
  });

  final String currentRouteName;

  @override
  ConsumerState<BottomNavigationBarWidget> createState() =>
      _BottomNavigationBarWidgetState();
}

class _BottomNavigationBarWidgetState
    extends ConsumerState<BottomNavigationBarWidget> {
  @override
  Widget build(BuildContext context) => ColoredBox(
        color: AppColors.main,
        child: SafeArea(
          child: DecoratedBox(
            decoration: const BoxDecoration(
              border: Border(
                top: BorderSide(
                  width: 0.5,
                  color: AppColors.gray300,
                ),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  _BottomNavigationBarItemWidget(
                    label: '홈',
                    selectedIcon: Icons.home_rounded,
                    unselectedIcon: Icons.home_rounded,
                    isSelected: widget.currentRouteName == Routes.home.name,
                    onTap: () {
                      context.goNamed(Routes.home.name);
                    },
                  ),
                  _BottomNavigationBarItemWidget(
                    label: '자주 먹는 음식',
                    selectedIcon: Icons.restaurant,
                    unselectedIcon: Icons.restaurant,
                    isSelected: widget.currentRouteName ==
                        Routes.frequentlyEatenFoods.name,
                    onTap: () {
                      context.goNamed(Routes.frequentlyEatenFoods.name);
                    },
                  ),
                  _BottomNavigationBarItemWidget(
                    label: '마이페이지',
                    selectedIcon: Icons.person,
                    unselectedIcon: Icons.person,
                    isSelected: widget.currentRouteName == Routes.myPage.name,
                    onTap: () {
                      context.goNamed(Routes.myPage.name);
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      );
}

class _BottomNavigationBarItemWidget extends StatelessWidget {
  const _BottomNavigationBarItemWidget({
    required this.label,
    required this.selectedIcon,
    required this.unselectedIcon,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final IconData selectedIcon;
  final IconData unselectedIcon;
  final bool isSelected;
  final GestureTapCallback onTap;

  @override
  Widget build(BuildContext context) => GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: onTap,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(
              isSelected ? selectedIcon : unselectedIcon,
              size: 24,
              color: isSelected ? AppColors.sub : AppColors.white,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: AppTextStyles.textMButton6.copyWith(
                color: isSelected ? AppColors.sub : AppColors.white,
              ),
            ),
          ],
        ),
      );
}
