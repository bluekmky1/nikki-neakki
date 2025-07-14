import 'package:flutter/material.dart';

import '../../../theme/app_colors.dart';
import '../../../theme/app_text_styles.dart';

class AddFoodCardWidget extends StatelessWidget {
  const AddFoodCardWidget({
    required this.title,
    required this.onTap,
    super.key,
  });

  final String title;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) => Container(
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: AppColors.gray200,
          ),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: AppColors.gray500.withValues(alpha: 0.2),
              blurRadius: 2,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            splashColor: Colors.transparent,
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    title,
                    style: AppTextStyles.textB16.copyWith(
                      color: AppColors.gray900,
                    ),
                  ),
                  const Icon(Icons.add),
                ],
              ),
            ),
          ),
        ),
      );
}
