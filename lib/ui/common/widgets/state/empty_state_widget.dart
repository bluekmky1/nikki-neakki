import 'package:flutter/material.dart';

import '../../../../theme/app_colors.dart';
import '../../../../theme/app_text_styles.dart';
import '../card/base_card_widget.dart';

class EmptyStateWidget extends StatelessWidget {
  const EmptyStateWidget({
    required this.icon,
    required this.title,
    required this.description,
    this.primaryButton,
    this.secondaryButton,
    super.key,
  });

  final IconData icon;
  final String title;
  final String description;
  final Widget? primaryButton;
  final Widget? secondaryButton;

  @override
  Widget build(BuildContext context) => BaseCardWidget(
        hasShadow: false,
        child: Column(
          children: <Widget>[
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: AppColors.main.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: AppColors.main,
                size: 36,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              title,
              style: AppTextStyles.textB18,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              description,
              style: AppTextStyles.textR14.copyWith(
                color: AppColors.gray600,
                height: 1.4,
              ),
              textAlign: TextAlign.center,
            ),
            if (primaryButton != null || secondaryButton != null) ...<Widget>[
              const SizedBox(height: 24),
              if (primaryButton != null) primaryButton!,
              if (secondaryButton != null) ...<Widget>[
                const SizedBox(height: 12),
                secondaryButton!,
              ],
            ],
          ],
        ),
      );
}
