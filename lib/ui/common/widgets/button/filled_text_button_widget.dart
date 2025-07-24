import 'package:flutter/material.dart';

import '../../../../theme/app_colors.dart';
import '../../../../theme/app_text_styles.dart';

class FilledTextButtonWidget extends StatelessWidget {
  const FilledTextButtonWidget({
    required this.title,
    required this.isEnabled,
    required this.onPressed,
    super.key,
  });

  final String title;
  final bool isEnabled;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) => TextButton(
        onPressed: isEnabled ? onPressed : null,
        style: TextButton.styleFrom(
          backgroundColor: isEnabled ? AppColors.main : AppColors.gray400,
          foregroundColor: isEnabled ? AppColors.white : AppColors.gray600,
          textStyle: AppTextStyles.textSb18.copyWith(
            color: isEnabled ? AppColors.white : AppColors.gray600,
          ),
          padding: const EdgeInsets.symmetric(
            vertical: 16,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(title),
          ],
        ),
      );
}
