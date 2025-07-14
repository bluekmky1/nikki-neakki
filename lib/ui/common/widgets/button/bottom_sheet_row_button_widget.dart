import 'package:flutter/material.dart';

import '../../../../theme/app_colors.dart';
import '../../../../theme/app_text_styles.dart';

class BottomSheetRowButtonWidget extends StatelessWidget {
  const BottomSheetRowButtonWidget({
    required this.title,
    this.icon,
    this.onTap,
    this.color = AppColors.gray700,
    super.key,
  });

  final String title;
  final IconData? icon;
  final VoidCallback? onTap;
  final Color? color;

  @override
  Widget build(BuildContext context) => TextButton(
        style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(
            vertical: 16,
            horizontal: 16,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          foregroundColor: color,
        ),
        onPressed: onTap,
        child: Row(
          children: <Widget>[
            if (icon != null)
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: Icon(icon!, color: color),
              ),
            Text(
              title,
              style: AppTextStyles.textSb16.copyWith(color: color),
            ),
          ],
        ),
      );
}
